```poewrshell
Get-AppxPackage -AllUser | Where PublisherId -eq 8wekyb3d8bbwe | Format-List -Property PackageFullName,PackageUserInformation
Get-AppxProvisionedPackage -Online | Select PackageName

Get-AppxPackage -AllUsers | where-object {$_.name –notlike “*store*”} | Remove-AppxPackage
Get-appxprovisionedpackage –online | where-object {$_.packagename –notlike “*store*”} | Remove-AppxProvisionedPackage -online    


Remove-AppxPackage -Package Microsoft.BingFinance_4.7.118.0_neutral_~_8wekyb3d8bbwe
Remove-AppxPackage -Package Microsoft.BingNews_4.7.118.0_neutral_~_8wekyb3d8bbwe
Remove-AppxPackage -Package Microsoft.BingSports_4.7.130.0_neutral_~_8wekyb3d8bbwe
Remove-AppxPackage -Package Microsoft.BingWeather_4.7.118.0_neutral_~_8wekyb3d8bbwe
Remove-AppxPackage -Package Microsoft.Getstarted_2.5.6.0_neutral_~_8wekyb3d8bbwe
Remove-AppxPackage -Package Microsoft.MicrosoftOfficeHub_2015.6508.23761.0_neutral_~_8wekyb3d8bbwe
Remove-AppxPackage -Package Microsoft.MicrosoftSolitaireCollection_3.5.11021.0_neutral_~_8wekyb3d8bbwe
Remove-AppxPackage -Package Microsoft.Office.OneNote_2015.6366.15841.0_neutral_~_8wekyb3d8bbwe
Remove-AppxPackage -Package Microsoft.People_2015.1201.2033.0_neutral_~_8wekyb3d8bbwe
Remove-AppxPackage -Package Microsoft.SkypeApp_3.2.1.0_neutral_~_kzf8qxf38zg5c
Remove-AppxPackage -Package Microsoft.WindowsAlarms_2015.1161.20.0_neutral_~_8wekyb3d8bbwe
Remove-AppxPackage -Package Microsoft.WindowsCamera_2015.1211.10.0_neutral_~_8wekyb3d8bbwe
Remove-AppxPackage -Package microsoft.windowscommunicationsapps_2015.6515.64021.0_neutral_~_8wekyb3d8bbwe
Remove-AppxPackage -Package Microsoft.WindowsMaps_4.12.11000.0_neutral_~_8wekyb3d8bbwe
Remove-AppxPackage -Package Microsoft.XboxApp_2015.1209.230.0_neutral_~_8wekyb3d8bbwe
Remove-AppxPackage -Package Microsoft.ZuneMusic_2019.6.15131.0_neutral_~_8wekyb3d8bbwe
Remove-AppxPackage -Package Microsoft.ZuneVideo_2019.6.15731.0_neutral_~_8wekyb3d8bbwe

Remove-AppXProvisionedPackage -Online -PackageName Microsoft.BingFinance_4.7.118.0_neutral_~_8wekyb3d8bbwe
Remove-AppXProvisionedPackage -Online -PackageName Microsoft.BingNews_4.7.118.0_neutral_~_8wekyb3d8bbwe
Remove-AppXProvisionedPackage -Online -PackageName Microsoft.BingSports_4.7.130.0_neutral_~_8wekyb3d8bbwe
Remove-AppXProvisionedPackage -Online -PackageName Microsoft.BingWeather_4.7.118.0_neutral_~_8wekyb3d8bbwe
Remove-AppXProvisionedPackage -Online -PackageName Microsoft.Getstarted_2.5.6.0_neutral_~_8wekyb3d8bbwe
Remove-AppXProvisionedPackage -Online -PackageName Microsoft.MicrosoftOfficeHub_2015.6508.23761.0_neutral_~_8wekyb3d8bbwe
Remove-AppXProvisionedPackage -Online -PackageName Microsoft.MicrosoftSolitaireCollection_3.5.11021.0_neutral_~_8wekyb3d8bbwe
Remove-AppXProvisionedPackage -Online -PackageName Microsoft.Office.OneNote_2015.6366.15841.0_neutral_~_8wekyb3d8bbwe
Remove-AppXProvisionedPackage -Online -PackageName Microsoft.People_2015.1201.2033.0_neutral_~_8wekyb3d8bbwe
Remove-AppXProvisionedPackage -Online -PackageName Microsoft.SkypeApp_3.2.1.0_neutral_~_kzf8qxf38zg5c
Remove-AppXProvisionedPackage -Online -PackageName Microsoft.WindowsAlarms_2015.1161.20.0_neutral_~_8wekyb3d8bbwe
Remove-AppXProvisionedPackage -Online -PackageName Microsoft.WindowsCamera_2015.1211.10.0_neutral_~_8wekyb3d8bbwe
Remove-AppXProvisionedPackage -Online -PackageName microsoft.windowscommunicationsapps_2015.6515.64021.0_neutral_~_8wekyb3d8bbwe
Remove-AppXProvisionedPackage -Online -PackageName Microsoft.WindowsMaps_4.12.11000.0_neutral_~_8wekyb3d8bbwe
Remove-AppXProvisionedPackage -Online -PackageName Microsoft.XboxApp_2015.1209.230.0_neutral_~_8wekyb3d8bbwe
Remove-AppXProvisionedPackage -Online -PackageName Microsoft.ZuneMusic_2019.6.15131.0_neutral_~_8wekyb3d8bbwe
Remove-AppXProvisionedPackage -Online -PackageName Microsoft.ZuneVideo_2019.6.15731.0_neutral_~_8wekyb3d8bbwe
```
