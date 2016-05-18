Import Application

```powershell
Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
New-PSDrive -Name "DS001" -PSProvider MDTProvider -Root "E:\MDTBuildLab"
$ApplicationName = "Install - Microsoft Visual C++ 2005 SP1 - x86"
$CommandLine = "vcredist_x86.exe /Q"
$ApplicationSourcePath = "E:\Downloads\VC++2005SP1x86"
Import-MDTApplication -Path "DS001:\Applications\Microsoft" -Enable "True" -Name $ApplicationName -ShortName $ApplicationName -Commandline $Commandline -WorkingDirectory ".\Applications\$ApplicationName" -ApplicationSourcePath $ApplicationSourcePath -DestinationFolder $ApplicationName 
-Verbose
```
