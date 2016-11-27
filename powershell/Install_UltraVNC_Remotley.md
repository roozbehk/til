Powershell-UltraVNC

Install Ultra VNC as Service to remote Windows Machines using Powershell

How to

first install Ultra VNC on a test machine and configure it the way you like Ultra VNC. Copy your configuration ultravnc.ini from application folder to the script install folder.

Included ultravnc.ini default password is "password"

`ultravnc.ini`

```ini
[ultravnc]
passwd=DBD83CFD727A145844
passwd2=DBD83CFD727A145844
[admin]
UseRegistry=0
MSLogonRequired=0
NewMSLogon=0
DebugMode=0
Avilog=0
path=C:\Program Files\uvnc bvba\UltraVNC
accept_reject_mesg=
DebugLevel=0
DisableTrayIcon=1
LoopbackOnly=0
UseDSMPlugin=0
AllowLoopback=1
AuthRequired=1
ConnectPriority=0
DSMPlugin=
AuthHosts=
DSMPluginConfig=
AllowShutdown=1
AllowProperties=1
AllowEditClients=1
FileTransferEnabled=1
FTUserImpersonation=1
BlankMonitorEnabled=1
BlankInputsOnly=0
DefaultScale=1
primary=1
secondary=0
SocketConnect=1
HTTPConnect=1
AutoPortSelect=1
PortNumber=5900
HTTPPortNumber=5800
IdleTimeout=0
IdleInputTimeout=0
RemoveWallpaper=0
RemoveAero=0
QuerySetting=2
QueryTimeout=10
QueryAccept=0
QueryIfNoLogon=1
InputsEnabled=1
LockSetting=0
LocalInputsDisabled=0
EnableJapInput=0
kickrdp=0
clearconsole=0
RemoveEffects=0
RemoveFontSmoothing=0
FileTransferTimeout=30
KeepAliveInterval=5
[admin_auth]
group1=
group2=
group3=
locdom1=0
locdom2=0
locdom3=0
[poll]
TurboMode=1
PollUnderCursor=0
PollForeground=0
PollFullScreen=1
OnlyPollConsole=0
OnlyPollOnEvent=0
MaxCpu=40
EnableDriver=0
EnableHook=1
EnableVirtual=0
SingleWindow=0
SingleWindowName=
[Permissions]

```


Download the latest version you like to install in to the script folder.

Run Ultra_VNC_install.bat

`Ultra_VNC_install.bat`

```
PowerShell.exe -Command "& {Start-Process PowerShell.exe -ArgumentList '-File ""%~dpn0.ps1""' -Verb RunAs}"
```

`Ultra_VNC_install.ps1`

```powershell
$scriptpath = $MyInvocation.MyCommand.Path
$path = Split-Path $scriptpath
Set-Location  $path
# Get Computer Names
$computers = get-content computers.txt
# Ultra VNC Configuration File
$file = "ultravnc.ini"
# Ultra VNC Installation File
$installfile = "UltraVNC_1_2_06_X64_Setup.exe"

$computers | where{test-connection $_ -quiet -count 1} | ForEach-Object{
     
     New-Item -ItemType Directory -Force -Path "\\$_\c$\Program Files\uvnc bvba\UltraVNC" 
     copy-item $file  "\\$_\c$\Program Files\uvnc bvba\UltraVNC" 
     copy-item $installfile  "\\$_\c$\Program Files\uvnc bvba\UltraVNC" 

     Invoke-Command -Computername $_ -ScriptBlock {
     
          $uvnceservice = Get-Service -display "uvnc_service" -ErrorAction SilentlyContinue 
     
          if (-Not $uvnceservice){ 
                  Start-Process "C:\Program Files\uvnc bvba\UltraVNC\UltraVNC_1_2_06_X64_Setup.exe" /silent -Wait
                  Start-Process "C:\Program Files\uvnc bvba\UltraVNC\winvnc.exe" "-install" -wait
                  Start-Service uvnc_service   
          }
          Else { write-host "Ultra VNC is Already Installed " }
               
     }
}

Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
```

`computers.txt`

```
PC1
PC2
PC3
```
