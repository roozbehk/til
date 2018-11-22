https://omgdebugging.com/2017/10/09/command-line-equivalent-of-wuauclt-in-windows-10-windows-server-2016/

usoclient StartScan

Note: USOClient.exe is located in C:\Windows\System32

This will also force the client to report its status to the WSUS server (if configured).

On using Sysinternal's Strings on UsoClient.exe, I found that there are more switches which can be used -

StartScan  - Used To Start Scan
StartDownload - Used to Start Download of Patches
StartInstall - Used to Install Downloaded Patches
RefreshSettings - Refresh Settings if any changes were made
StartInteractiveScan - May ask for user input and/or open dialogues to show progress or report errors
RestartDevice - Restart device to finish installation of updates
ScanInstallWait - Combined Scan Download Install
ResumeUpdate - Resume Update Installation On Boot
