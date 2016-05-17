### This PowerShell script will automatically download and install Microsoft Windows ADK for Windows 10, and MDT 2013 update 2
http://renshollanders.nl/2015/09/mdt-updated-powershell-scripts-for-windows-adk-10-and-mdt-2013-update-1-build-8298/

`MDT_DownloadInstall_ADK-MDT_for_Windows_10.ps1`
``` Powershell
# *************************************************************************** 
# *************************************************************************** 
# 
# File:      MDT_DownloadInstall_ADK-MDT_for_Windows_10.ps1 
# 
# Author:    Rens Hollanders rens.hollanders (@) gmail.com
# 
# Purpose:   This PowerShell script will automatically download and install
#            Microsoft Windows ADK for Windows 10, and MDT 2013 update 2
#            
# 
#            This requires PowerShell 2.0 CTP3 or later. 
# 
# Usage:     Copy this file to an appropriate location. Execute it from there
#
# Version:   v1.0
#
#
# Support:   This script supports MDT 2013 Update 2
#
# 
# **************************************************************************

Write-Host "This scripts needs a working internet connection " -ForegroundColor Yellow
Write-Host "This scripts needs unrestricted access (Set-ExecutionPolicy Bypass or Unrestricted.) " -ForegroundColor Yellow
Write-Host "The setup takes around 15 minutes depending on your internet speed." -ForegroundColor Yellow
Write-Host "At the end of the process, any errors are shown in red, please review them to see what has failed." -ForegroundColor Yellow

# Download the setup files if needed
# Below you can set the sourcepath variable to whatever drive\folder you want.

# Check for elevation
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "You need to run this script from an elevated PowerShell prompt!`nPlease start the PowerShell prompt as an Administrator and re-run the script."
    Write-Warning "Aborting script..."
    Break
}

# Get Start Time
$startDTM = (Get-Date)

$SourcePath = Split-Path -Path $MyInvocation.MyCommand.Path

if (!(Test-Path -path $SourcePath"\Software")){
   New-Item $SourcePath"\Software" -ItemType directory
} 

# Check if these files exists, if not, download them
 $file1 = $SourcePath+"\Software\adksetup.exe"
 $file2 = $SourcePath+"\Software\MicrosoftDeploymentToolkit2013_x64.msi"
  
if (Test-Path $file1){
 write-host "The file $file1 exists."
 } else {
 
# Download Windows Assessment and Deployment Kit (ADK 10)
		Write-Host "Downloading Windows Assessment and Deployment Kit (ADK 10).." -ForegroundColor Green
		$clnt = New-Object System.Net.WebClient
		$url = "http://download.microsoft.com/download/3/8/B/38BBCA6A-ADC9-4245-BCD8-DAA136F63C8B/adk/adksetup.exe"
		$clnt.DownloadFile($url,$file1)
		Write-Host "done!" -ForegroundColor Green
 }
 
 if (Test-Path $file2){
 write-host "The file $file2 exists."
 } else {
 
# Download Microsoft Deployment Toolkit 2013 update 2
		Write-Host "Downloading Microsoft Deployment Toolkit 2013 update 2" -ForegroundColor Green
		$clnt = New-Object System.Net.WebClient
		$url = "https://download.microsoft.com/download/3/0/1/3012B93D-C445-44A9-8BFB-F28EB937B060/MicrosoftDeploymentToolkit2013_x64.msi"
		$clnt.DownloadFile($url,$file2)
		Write-Host "done!" -ForegroundColor Green

 }

# Install .NET Framework Feature
$OSVersion = get-wmiobject win32_operatingsystem | select-object Version
Import-Module ServerManager
if ($OSVersion -like '*6.3*') {write-host 'Operating System is Microsoft Windows Server 2012 R2 ..' -ForegroundColor Green ; Add-WindowsFeature as-net-framework}
Else {Write-Warning 'Could not install .NET Framework due to different Operating System (Not Microsoft Server 2012)'}

# Install Windows ADK for Windows 10
Write-Host "Installing Windows ADK for Windows 10" -ForegroundColor Green
Start-Process -FilePath "$SourcePath\Software\adksetup.exe" -Wait -ArgumentList "/Features OptionId.DeploymentTools OptionId.WindowsPreinstallationEnvironment OptionId.ImagingAndConfigurationDesigner OptionId.UserStateMigrationTool /norestart /quiet /ceip off"
Start-Sleep -s 20
Write-Host "done!" -ForegroundColor Green

# Install Microsoft Deployment Toolkit 2013 update 2
Write-Host "Installing Microsoft Deployment Toolkit 2013 update 2" -ForegroundColor Green
$PSScriptRoot = Split-Path -Path $MyInvocation.MyCommand.Path
msiexec /qb /i "$SourcePath\Software\MicrosoftDeploymentToolkit2013_x64.msi" | Out-Null
Start-Sleep -s 10
Write-Host "done!" -ForegroundColor Green

# Get End Time
$EndDTM = (Get-Date)

# Echo Time elapsed
"Elapsed Time: $(($endDTM-$startDTM).totalminutes) minutes"

# End of script
```
