Option Explicit
Dim WshNetwork, objShell, objFSO

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set WshNetwork = WScript.CreateObject("WScript.Network")
Set objShell = CreateObject("Shell.Application")

' Section to map the X network drive
If (objFSO.DriveExists("X:") = false) Then
    WshNetwork.MapNetworkDrive "X:", "\\smk-server\apps", True
    objShell.NameSpace("X:").Self.Name = "Software"
End If
   
' Section to map the H network drive
If (objFSO.DriveExists("H:") = false) Then
    WshNetwork.MapNetworkDrive "H:", "\\smk-server\share", True
    objShell.NameSpace("H:").Self.Name = "Share"
End If



WScript.Quit

