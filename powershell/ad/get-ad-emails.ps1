$ActiveDirectoryList=@() 
$UserDetails = get-aduser -filter {enabled -eq $true} -properties * | Select DisplayName,EmailAddress, SAMAccountName
$counter = 0
foreach($User in $UserDetails){

    $ActiveDirectoryObject = New-Object PSObject
    $Users = get-aduser $User.SAMAccountName -properties * 
    if(!$Users.EmailAddress -eq ""){
        $counter++
        $ActiveDirectoryObject | Add-Member -MemberType NoteProperty -Name "DisplayName" -Value $Users.DisplayName
        $ActiveDirectoryObject | Add-Member -MemberType NoteProperty -Name "Email Address" -Value $Users.EmailAddress 
        write-host $Users.DisplayName
        $ActiveDirectoryList += $ActiveDirectoryObject
    }
}
