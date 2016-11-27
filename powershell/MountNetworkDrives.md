# Powershell-MountDrives

After you enable PowerShell remoting on the client machines. (Windows 8/8.1/10)

Run Mount_Drives.bat
This will copy Mount_Drives.vbs into c:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp on all the client machine. 

`Mount_Drives.bat`

```batch
PowerShell.exe -Command "& {Start-Process PowerShell.exe -ArgumentList '-File ""%~dpn0.ps1""' -Verb RunAs}"
```

`Mount_Drives.ps1`

```ps
$scriptpath = $MyInvocation.MyCommand.Path
$path = Split-Path $scriptpath
Set-Location  $path
$computers = get-content computers.txt
$path = "Mount_Drives.vbs"
$computers | where{test-connection $_ -quiet -count 1} | ForEach-Object{

copy-item $path "\\$_\c$\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
Write-Host $_
Write-Host "Copied file to C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
}

Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
```

`Mount_Drives.vbs`

```vbs
Option Explicit
Dim WshNetwork, objShell, objFSO

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set WshNetwork = WScript.CreateObject("WScript.Network")
Set objShell = CreateObject("Shell.Application")

' Section to map the H network drive
If (objFSO.DriveExists("H:") = false) Then
    WshNetwork.MapNetworkDrive "H:", "\\server\share", True
    objShell.NameSpace("H:").Self.Name = "Share"
End If



WScript.Quit
```
 
`computers.txt`
name of the computers
```
PC1
PC2
PC3
```
at next logon they will get the network shares. 

be sure to edit Mount_Drivers.vbs to your liking. 
