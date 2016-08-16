You will need ADK for windows 10. Install and Select WINPE

Run as Administrator, Deployment and Imaging Tools Environment
## Create a 64bit version and copy to folder c:\WinPE_amd64

`copype amd64 C:\WinPE_amd64


Mount WINPE IMAGE ADD DRIVERS

`Dism /Mount-Image /ImageFile:"C:\WinPE_amd64\media\sources\boot.wim" /index:1 /MountDir:"C:\WinPE_amd64\mount"

`Dism /Add-Driver /Image:"C:\WinPE_amd64\mount" /Driver:"C:\SampleDriver\" /recurse

Check What Drivers are installed

`Dism /Get-Drivers /Image:"C:\WinPE_amd64\mount"

Commit

`Dism /Unmount-Image /MountDir:"C:\WinPE_amd64\mount" /commit

## Create ISO or USB

Create ISO of WINPE

`MakeWinPEMedia /ISO C:\winpe_amd64 c:\winpe_amd64\winpe.iso

Copy to USB:

`MakeWinPEMedia /UFD C:\winpe_amd64 F:

Manually Delete and Make UEFI

```
diskpart
  list disk
  select disk <disk number>
  clean
  create partition primary
  format quick fs=fat32 label="Windows PE"
  assign letter="F"
  exit
```


