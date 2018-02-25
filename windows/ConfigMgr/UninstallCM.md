### powershell
Stopp the Services:
1. Stopp SMS Agent Host Service
2. Stopp CCMSetup service (if present)

Delete Files and Folders:
3. Delete \windows\ccm directory
4. Delete \windows\ccmsetup directory
5. Delete \windows\ccmcache directory
6. Delete \windows\smscfg.ini
7. Delete \windows\sms*.mif (if present)

Delete Registry Entries:
8. Delete HKLM\software\Microsoft\ccm registry keys
9. Delete HKLM\software\Microsoft\CCMSETUP registry keys
10. Delete HKLM\software\Microsoft\SMS registry keys

Delete WMI Namespace:
11. Delete root\cimv2\sms WMI namespace
12. Delete root\ccm WMI namespace

Delete Folder at the Task Scheduler:
13. In Task Scheduler library, under “Microsoft” delete the “Configuration Manager” folder and any tasks within it

For this you can use the following PS-Script instead:
Try { Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force -ErrorAction Stop } Catch {}

# Stop Services
Stop-Service -Name ccmsetup -Force -ErrorAction SilentlyContinue
Stop-Service -Name CcmExec -Force -ErrorAction SilentlyContinue
Stop-Service -Name smstsmgr -Force -ErrorAction SilentlyContinue
Stop-Service -Name CmRcService -Force -ErrorAction SilentlyContinue

# Remove WMI Namespaces
Get-WmiObject -Query "SELECT * FROM __Namespace WHERE Name='ccm'" -Namespace root | Remove-WmiObject
Get-WmiObject -Query "SELECT * FROM __Namespace WHERE Name='sms'" -Namespace root\cimv2 | Remove-WmiObject

# Remove Services from Registry
$MyPath = “HKLM:\SYSTEM\CurrentControlSet\Services”
Remove-Item -Path $MyPath\CCMSetup -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $MyPath\CcmExec -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $MyPath\smstsmgr -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $MyPath\CmRcService -Force -Recurse -ErrorAction SilentlyContinue

# Remove SCCM Client from Registry
$MyPath = “HKLM:\SOFTWARE\Microsoft”
Remove-Item -Path $MyPath\CCM -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $MyPath\CCMSetup -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $MyPath\SMS -Force -Recurse -ErrorAction SilentlyContinue

# Remove Folders and Files
$MyPath = $env:WinDir
Remove-Item -Path $MyPath\CCM -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $MyPath\ccmsetup -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $MyPath\ccmcache -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $MyPath\SMSCFG.ini -Force -ErrorAction SilentlyContinue
Remove-Item -Path $MyPath\SMS*.mif -Force -ErrorAction SilentlyContinue

And the final Steps are the following:
1. First run at an elevated Prompt : CHKDSK /F
2. Reboot
3. Open an elevated CMD and run the following command:
fsutil resource setautoreset true C:\
4. Reboot
5. Install the SCCM Agent
###
