Give Specific User Access to Join Domain in Specific OU

## Execute
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
Set-Location C:\Setup\Scripts
.\Set-OUPermissions.ps1 -Account MDT_JD 
-TargetOU "OU=Workstations,OU=Computers,OU=Contoso"
```
https://gallery.technet.microsoft.com/Configure-permissions-in-2326651a

Set-OUPermissions.ps1
```powershell
<#
Created:	 2016-04-06
Version:	 1.1
Author       Mikael Nystrom and Johan Arwidmark       
Homepage:    http://deploymentartist.com

Disclaimer:
This script is provided "AS IS" with no warranties, confers no rights and 
is not supported by the authors or DeploymentArtist.

Author - Mikael Nystrom
    Twitter: @mikael_nystrom
    Blog   : http://deploymentbunny.com

Author - Johan Arwidmark
    Twitter: @jarwidmark
    Blog   : http://deploymentresearch.com
#>

Param
(
[parameter(mandatory=$true,HelpMessage="Please, provide the account name.")][ValidateNotNullOrEmpty()]$Account,
[parameter(mandatory=$true,HelpMessage="Please, provide the target OU.")][ValidateNotNullOrEmpty()]$TargetOU
)

# Start logging to screen
Write-host (get-date -Format u)" - Starting"

# This i what we typed in
Write-host "Account to search for is" $Account
Write-Host "OU to search for is" $TargetOU

if ($TargetOU -like '*dc=*')
{ 
    Write-Warning "Oupps, only specify the OU path. We get the domain for you..."
    Break
} 

$CurrentDomain = Get-ADDomain

$OrganizationalUnitDN = $TargetOU+","+$CurrentDomain
$SearchAccount = Get-ADUser $Account

$SAM = $SearchAccount.SamAccountName
$UserAccount = $CurrentDomain.NetBIOSName+"\"+$SAM

Write-Host "Account is = $UserAccount"
Write-host "OU is =" $OrganizationalUnitDN

dsacls.exe $OrganizationalUnitDN /G $UserAccount":CCDC;Computer" /I:T | Out-Null
dsacls.exe $OrganizationalUnitDN /G $UserAccount":LC;;Computer" /I:S | Out-Null
dsacls.exe $OrganizationalUnitDN /G $UserAccount":RC;;Computer" /I:S | Out-Null
dsacls.exe $OrganizationalUnitDN /G $UserAccount":WD;;Computer" /I:S  | Out-Null
dsacls.exe $OrganizationalUnitDN /G $UserAccount":WP;;Computer" /I:S  | Out-Null
dsacls.exe $OrganizationalUnitDN /G $UserAccount":RP;;Computer" /I:S | Out-Null
dsacls.exe $OrganizationalUnitDN /G $UserAccount":CA;Reset Password;Computer" /I:S | Out-Null
dsacls.exe $OrganizationalUnitDN /G $UserAccount":CA;Change Password;Computer" /I:S | Out-Null
dsacls.exe $OrganizationalUnitDN /G $UserAccount":WS;Validated write to service principal name;Computer" /I:S | Out-Null
dsacls.exe $OrganizationalUnitDN /G $UserAccount":WS;Validated write to DNS host name;Computer" /I:S | Out-Null
dsacls.exe $OrganizationalUnitDN
```
