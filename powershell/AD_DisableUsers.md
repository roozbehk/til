# AD_DisableUsers
Disable Inactive Active Directory Users after 90 Days, Move Home and Profile Directories after 180 Days to Archive Folder. The script logs the disabled users and sends an email. 

This Powershell Script can be setup as a scheduled task which runs nightly, it will go through users in active directory and finds accounts that have not logged in 90 days (date count can be changed) and disables the account.

Disabled account Description will change to a date that it was disabled. 
Everytime the task runs, disabled users are check against the date they were disabled. 

I have implement moving the profile and home directories of users to archive folder after 90 days the user is disabled.

you can also implement deletion of using `Remove-ADUser`

## How to

Change the powershell variables to your enviroment. if you like to test the script, please change the searchbase to a test OU and setup a test user, home directory and profile directory. 

Setup a scheduled task to run nightly/weekly. 

## Disable_ADUsers.ps1
```powershell
# Disable accounts that have been created and the user have not logged in 90 days change Description to Date that was disabled
# Move Profile & Home Folders after 90 days after disabled date to _disabledUserAccounts
# Deletion not implemented. Do Manual Deletion

# PLEASE CHANGE FOLLOWING VARs
# $Disabledage,$PasswordAge,$userHomeFolder,$userDestinationHomeFolder
# $userProfileFolder,$userDestinationProfileFolder,$searchBase*,$smtp

#import the ActiveDirectory Module
Import-Module ActiveDirectory

#Create a variable for the date stamp in the log file
$LogDate = get-date -f yyyyMMddhhmm

#Create an empty array for the log file
$LogArray = @()

#Sets the number of days to move user home & profile directories to _disabledUserAccounts based on value in description field
$Disabledage = (get-date).adddays(-90)

#Sets the number of days to disable user accounts based on lastlogontimestamp and pwdlastset.
$PasswordAge = (Get-Date).adddays(-90)

#RegEx pattern to verify date format in user description field.
$RegEx ="([1-9]|1[012])[- /.]([1-9]|[12][0-9]|3[01])[- /.](19|20)[0-9]{2}"

# Move Home Directories of Disabled Accounts to _disabledUserAccounts.
$userHomeFolder = "\\SERVERNAME\home"
$userDestinationHomeFolder = "\\SERVERNAME\home\_disabledUserAccounts"


# Move Profile Directories of Disabled Accounts to _disabledUserAccounts.
$userProfileFolder = "\\SERVERNAME\profiles"
$userDestinationProfileFolder = "\\SERVERNAME\profiles\_disabledUserAccounts"


#Sets the OU to do the base search for all user accounts, change for your env.
#To add more Base URLs, create more vars and make sure $searchBases is updated.
$searchBaseStudentStaff = "OU=Users,DC=your,DC=company,DC=com"
$searchBaseORLUsers = "OU=Finance Users,DC=your,DC=company,DC=com"
$searchBaseManagedAccounts = "OU=HR Users,DC=your,DC=company,DC=com"

$searchBases = $searchBaseStudentStaff,$searchBaseORLUsers,$searchBaseManagedAccounts

# Email Server Variables
$smtp = "SMTP_SERVERIPADDRESS"
$to = "youremail@company.com" 
$from = "Disabled User Reports <AD@yourcompany.com>"
$subject = "Disabled Users Report"

# Html
$header = "<style>"
$header = $header + "BODY{background-color:Lavender ;}"
$header = $header + "TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}"
$header = $header + "TH{border-width: 1px;padding: 5px;border-style: solid;border-color: black;background-color:thistle}"
$header = $header + "TD{border-width: 1px;padding: 5px;border-style: solid;border-color: black;background-color:PaleGoldenrod}"
$header = $header + "</style>"

###### MOVE HOME AND PROFILE DIRECTORIES TO _disabledUserAccounts Folder
######
######
######

# Move files to  _disabledUserAccounts folder after 90 days 
ForEach ($searchBase in $searchBases){
 
     ForEach ($DisabledUser in (Get-Aduser -searchbase $searchBase -Filter {enabled -eq $False} -properties description ) ){

      #Verifies description field is in the correct date format by matching the regular expression from above to prevent errors with other disbaled users.
      If ($DisabledUser.Description -match $Regex){

  	    
        #Compares date in the description field to the DisabledAge set.
        If((get-date $DisabledUser.Description) -le $Disabledage){
            
            # Move Home & Profile Directories
            $userAccountsName = "$($DisabledUser.samaccountname)"
   	    Move-Item  $userHomeFolder\$userAccountsName $userDestinationHomeFolder
	    $userAccountsName = "$($DisabledUser.samaccountname).V2"
	    Move-Item  $userProfileFolder\$userAccountsName $userDestinationProfileFolder
  	    Write-Host $DisabledUser.samaccountname
  	    
            #Create new object for logging
            $obj = New-Object PSObject
            $obj | Add-Member -MemberType NoteProperty -Name "Name" -Value $DisabledUser.name
            $obj | Add-Member -MemberType NoteProperty -Name "samAccountName" -Value $DisabledUser.samaccountname
            $obj | Add-Member -MemberType NoteProperty -Name "DistinguishedName" -Value $DisabledUser.DistinguishedName
            $obj | Add-Member -MemberType NoteProperty -Name "Status" -Value 'Moved'
            $LogArray += $obj
        }
      }
    }
}

###### DISABLE ACCOUNTS
######
######
######

# Users Created but never logged in 90 days 
ForEach ($searchBase in $searchBases){

    ForEach ($DisabledUser in (Get-ADUser -SearchBase $searchBase -filter {(lastlogondate -notlike "*") -AND (enabled -eq $True)  -AND (WhenChanged -le $PasswordAge) -AND (sAMAccountName -notlike "_Template*")} )) {

      set-aduser $DisabledUser -Description ((get-date).toshortdatestring())
      Disable-ADAccount $DisabledUser

        #Create new object for logging
        $obj = New-Object PSObject
        $obj | Add-Member -MemberType NoteProperty -Name "Name" -Value $DisabledUser.name
        $obj | Add-Member -MemberType NoteProperty -Name "samAccountName" -Value $DisabledUser.samaccountname
        $obj | Add-Member -MemberType NoteProperty -Name "DistinguishedName" -Value $DisabledUser.DistinguishedName
        $obj | Add-Member -MemberType NoteProperty -Name "Status" -Value 'Disabled'
        $LogArray += $obj
    }
}


# Users that have not logged in 90 days
ForEach ($searchBase in $searchBases){
    ForEach ($DisabledUser in ( Get-ADUser -SearchBase $searchBase -filter {(lastlogondate -like "*") -AND (lastlogondate -le $PasswordAge) -AND (passwordlastset -le $PasswordAge) -AND (enabled -eq $True) -AND (sAMAccountName -notlike "_Template*")} )) {

      set-aduser $DisabledUser -Description ((get-date).toshortdatestring())
      Disable-ADAccount $DisabledUser

        #Create new object for logging
        $obj = New-Object PSObject
        $obj | Add-Member -MemberType NoteProperty -Name "Name" -Value $DisabledUser.name
        $obj | Add-Member -MemberType NoteProperty -Name "samAccountName" -Value $DisabledUser.samaccountname
        $obj | Add-Member -MemberType NoteProperty -Name "DistinguishedName" -Value $DisabledUser.DistinguishedName
        $obj | Add-Member -MemberType NoteProperty -Name "Status" -Value 'Disabled'
        $LogArray += $obj
    }
}

#Exports log array to CSV file in the temp directory with a date and time stamp in the file name.
$logArray | Export-Csv "UserAccountDisabled_Report_$logDate.csv" -NoTypeInformation

# Email Disabled Users

$Users = $logArray | sort | select Name,samAccountName,DistinguishedName,Status | ConvertTo-html -Head $header -Body "<H2>Users Disabled or Moved this Week.</H2>"
 
 $body = "Account Activity "
 $body += "`n"
 $body += $Users
 $body += "`n"

Send-MailMessage -SmtpServer $smtp -To $to -From $from -Subject $subject -Body $body -BodyAsHtml
# Export to HTML
$body | Out-File UserAccountDisabled_Report_$logDate.html
```

`run_Disable_ADUsers.bat`
```powershell -ExecutionPolicy ByPass c:\scripts\Disable_ADUsers.ps1```

### License

open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)
