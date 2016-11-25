```batch
@echo off
PUSHD %~dp0
 
PowerShell.exe -ExecutionPolicy Bypass -File ".\PowerShellScriptFileName.ps1"
 
POPD
```
