WinPE: Create USB Bootable drive
Windows 10, Version 1703

In Windows 10, Version 1703 you can create multiple partitions on a USB drive, allowing you to have a single USB key with a combination of FAT32 and and NTFS partitions. To work with USB drives that have multiple partitions, your technician PC has to be Windows 10, Version 1703, with the most recent version of the ADK installed.

```batch
diskpart
   list disk
   select <disk number>
   clean
   rem === Create the Windows PE partition. ===
   create partition primary size=2000
   format quick fs=fat32 label="Windows PE"
   assign letter=P
   active
   rem === Create a data partition. ===
   create partition primary
   format fs=ntfs quick label="Other files"
   assign letter=O
   list vol
   exit
```

Windows 10, Version 1607 and earlier

Start the Deployment and Imaging Tools Environment as an administrator.
Create a working copy of the Windows PE files. Specify either x86, amd64, or arm:

`copype amd64 C:\WinPE_amd64

Install Windows PE to the USB flash drive, specifying the WinPE drive letter:

`MakeWinPEMedia /UFD C:\WinPE_amd64 P:
