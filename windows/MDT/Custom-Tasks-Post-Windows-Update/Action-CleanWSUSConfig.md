# Action-CleanWSUSConfig
under `Windows Update (Post-Application Installation)` create `Custom Tasks (Post Windows Update)` folder.

## Install Application Action-CleanWSUSConfig
Type: `Install Application`
Name: `Install Application Action-CleanWSUSConfig`
Install a single application: `Action-CleanWSUSConfig`

Import Application File: Action-CleanWSUSConfig.wsf
   
   ```vbs
<job id="Action-CleanupBeforeSysprep">
<script language="VBScript" src="..\..\Scripts\ZTIUtility.vbs"/>
<script language="VBScript"> 

'//----------------------------------------------------------------------------
'// Purpose: Clean WSUS configuration from registry
'// Usage: cscript Action-CleanWSUSConfig.wsf [/debug:true]
'// Version: 1.0 - 2014-11-12
'// Author: Nickolaj Andersen
'// Core functionality is based upon a script created by Mikael Nyström 
'// and Johan Arwidmark.
'//
'//----------------------------------------------------------------------------

'//----------------------------------------------------------------------------
'// Global constant and variable declarations
'//---------------------------------------------------------------------------- 

Option Explicit 
Const HKEY_LOCAL_MACHINE = &H80000002
Dim iRetVal 

'//----------------------------------------------------------------------------
'// End declarations
'//---------------------------------------------------------------------------- 

'//----------------------------------------------------------------------------
'// Main routine
'//---------------------------------------------------------------------------- 

'On Error Resume Next
iRetVal = ZTIProcess
ProcessResults iRetVal
On Error Goto 0 

'//---------------------------------------------------------------------------
'//
'// Function: ZTIProcess()
'//
'// Input: None
'// 
'// Return: Success - 0
'// Failure - non-zero
'//
'// Purpose: Perform main ZTI processing
'// 
'//---------------------------------------------------------------------------
Function ZTIProcess() 

	Dim sComputer
	Dim sActionName
	Dim sOSCurrentVersion
	Dim sOSCurrentVersionShort
	Dim oWMIService
	Dim colServices
	Dim colService
	Dim oRegistry
	Dim sKeyPath
	Dim aSubKeys
	Dim sSubKey
	
	sComputer = "."
	sActionName = "Action-CleanWSUSConfig"
	sOSCurrentVersion = oEnvironment.item("OSCurrentVersion")
	sOSCurrentVersionShort = Left(oEnvironment.item("OSCurrentVersion"),3)
	
	'Starting
	oLogging.CreateEntry sActionName & ": Starting", LogTypeInfo
	oLogging.CreateEntry sActionName & ": Running on " & sOSCurrentVersion, LogTypeInfo

	' Stop Windows Update service (wuauserv)
	Set oWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & sComputer & "\root\cimv2")
	Set colServices = oWMIService.ExecQuery("SELECT * FROM Win32_Service WHERE Name='wuauserv'",,48)
	
	For Each colService in colServices
		If colService.State = "Stopped" Then
			oLogging.CreateEntry sActionName & ": Windows Update service is already stopped", LogTypeInfo
		ElseIf colService.State = "Running" Then
			oLogging.CreateEntry sActionName & ": Attempting to stop the Windows Update service", LogTypeInfo
			colService.StopService
			Do Until oWMIService.ExecQuery("SELECT * FROM Win32_Service WHERE Name='wuauserv' AND State='Stopped'").Count > 0
				oLogging.CreateEntry sActionName & ": Attempting to stop the Windows Update service", LogTypeInfo
				WScript.Sleep 100
			Loop
			If oWMIService.ExecQuery("SELECT * FROM Win32_Service WHERE Name='wuauserv' AND State='Stopped'").Count > 0 Then
				oLogging.CreateEntry sActionName & ": Successfully stopped the Windows Update service", LogTypeInfo
			End If
		Else
			oLogging.CreateEntry sActionName & ": Unhandled state detected for the Windows Update service, exiting script", LogTypeInfo
			WScript.Quit 1
		End If
	Next
	
	' Remove WindowsUpdate key and subkeys from the registry
	oLogging.CreateEntry sActionName & ": Deleting Windows Update registry key and subkeys", LogTypeInfo
	'Set oRegistry = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & sComputer & "\root\default:StdRegProv")
	DeleteSubKeys HKEY_LOCAL_MACHINE, "SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"

	oLogging.CreateEntry oUtility.ScriptName & ": Finished", LogTypeInfo

End Function 

'//---------------------------------------------------------------------------
'//
'// Sub: DeleteSubkeys()
'//
'// Input: Registry root, registry key path
'// 
'// Purpose: Recursively delete subkeys
'// 
'//---------------------------------------------------------------------------

	Sub DeleteSubkeys(HKEY_LOCAL_MACHINE, sKeyPath)
	
	Dim oRegistry
	Dim aSubKeys
	Dim sSubKey
	Dim sComputer
	sComputer = "."

	Set oRegistry = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & sComputer & "\root\default:StdRegProv")
		oRegistry.EnumKey HKEY_LOCAL_MACHINE, sKeyPath, aSubkeys 
		If IsArray(aSubkeys) Then 
			For Each sSubkey In aSubkeys 
				DeleteSubkeys HKEY_LOCAL_MACHINE, sKeyPath & "\" & sSubkey 
			Next 
		End If 
		oRegistry.DeleteKey HKEY_LOCAL_MACHINE, sKeyPath 
	End Sub	

</script>
</job>

```
