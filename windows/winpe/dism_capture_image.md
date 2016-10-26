
This batch file will capture your C: drive to E:\capture folder, you should run this from winpe and you can have another external drive mounted on e to capture the file to.

if you need to split your image, use the last command. 

```


@echo off

for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /format:list') do set datetime=%%I
set datetime=%datetime:~0,8%-%datetime:~8,4%

rem "Capturing Windows Image"
%systemdrive%\windows\system32\dism.exe /ScratchDir:%UFDPATH%\TEMP /Capture-Image /Verify /Compress:fast /ImageFile:e:\capture\%datetime%_Windows.wim /CaptureDir:C:\ /Name:"Windows"

rem "Spliting captured image to 4GB sizes"
%systemdrive%\windows\system32\dism.exe /Split-Image /ImageFile:e:\capture\%datetime%_Windows.wim /SWMFile:%datetime%_Windows.swm /FileSize:4096

```
