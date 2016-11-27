# MS-ReleaseManagement-RUNas
Run Command/Batch Files (Administrator Mode). `Run Command Line as User` in MS Release Management has never work for me. This is a replacement to Run Batch files as Administrator (Agent Service Account must be an Administrator)

### Exmaple:
Filepath  c:\scripts\batch.bat

## How to setup

### Under Inventory -> Tools  Create New Tool
```
Name: Run Command/Batch (Administrator Mode)
Description: Specify the Location of file you like to run
Command: PowerShell
Argument: -command ./Run_Batch.ps1 -Filepath '__Filepath__'
```
Upload `Run_Batch.ps1`

```ps

param
(
  [string]$Filepath = $(throw "File absolute path is missing")

)

# Get the ID and security principal of the current user account
$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent();
$myWindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($myWindowsID);

# Get the security principal for the administrator role
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator;

# Check to see if we are currently running as an administrator
if($myWindowsPrincipal.IsInRole($adminRole))
{
    # We are running as an administrator, so change the title and background colour to indicate this
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)";
    $Host.UI.RawUI.BackgroundColor = "DarkBlue";
    Clear-Host;
}else{
    # We are not running as an administrator, so relaunch as administrator

    # Create a new process object that starts PowerShell
    $newProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell";

    # Specify the current script path and name as a parameter with added scope and support for scripts with spaces in it's path
    #-noexit
    $newProcess.Arguments =  " & '" + $script:MyInvocation.MyCommand.Path + "' '" + $Filepath + "'"

    # Indicate that the process should be elevated
    $newProcess.Verb = "runas";

    # Start the new process
    [System.Diagnostics.Process]::Start($newProcess);

    # Exit from the current, unelevated, process
    Exit;
}


Write-Host File path is  $Filepath;

$Filepathwithspaces = '"{0}"' -f $Filepath



cmd.exe  "/c $Filepathwithspaces"



```

Save New Tool.

![alt text](https://github.com/roozbehk/til/master/powershell/releasemanagement/RUNas/images/run-action.png "Run Command/Batch Tool")

### Under Inventory -> Actions Create New Action
```
Name: Run Command/Batch (Administrator Mode)
Description: Runs File Specified , Usually .bat , .com , .exe file extenstions
Categories: Custom
Tools used: Select the Tool you just created "Run Command/Batch (Administrator Mode)"
```
Save New Action.


![alt text](https://github.com/roozbehk/til/master/powershell/releasemanagement/RUNas/images/run-action.png "Run Command/Batch Action")



You can use the new action in your Release Template.

### License

open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)
