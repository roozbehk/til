Boot winpe, mount S drive (UEFI Partition) , use Dism to Capture both C:\ and S:\ , for windows 10 you will need to use winpe10 dism version. 

```
diskpart
list partition
select partition=1
assign letter=S
exit
Dism /Capture-Image /ImageFile:c:\windows-partition.wim /CaptureDir:C:\ /Name:"Windows Partition"
Dism /Capture-Image /ImageFile:c:\system-partition.wim /CaptureDir:S:\ /Name:"System Partition"
```




Split your image to fit into USB fat32 formatted stick.

```
@echo off

rem "Spliting captured image to 4GB sizes"
%systemdrive%\windows\system32\dism.exe /Split-Image /ImageFile:C:\Windows.wim /SWMFile:Windows.swm /FileSize:4096

```
