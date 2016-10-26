Create Parition Config File
`create_uefi_partitions_windows_10_.conf`
```
select disk 0
clean
convert gpt
create partition efi size=100
format quick fs=fat32 label="System"
assign letter="S"
create partition msr size=16
create partition primary
shrink minimum=500
format quick fs=ntfs label="Windows"
assign letter="W"
rem === 4. Recovery tools partition ================
create partition primary
format quick fs=ntfs label="Recovery tools"
assign letter="R"
set id="de94bba4-06d1-4d40-a16a-bfd50179d6ac"
gpt attributes=0x8000000000000001
list volume
exit
```

Run this command, this will delete your disk 0, make sure it is the OS drive you are trying to parition. 

`diskpart /s create_uefi_partitions_windows_10_.conf`


Ceate: `deploy_windows_image_.bat`

This is if your image is split to 4GB files to be put on USB drive.

```
call powercfg /s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

DISM.exe /apply-image /imagefile:LOCATION_OF_YOUR_IMAGE\image.swm /swmfile:LOCATION_OF_YOUR_IMAGE\image*.swm /index:1 /applydir:W:\

```

Use this if you are going to apply full image

```
rem == Apply the image to the Windows partition ==
dism /Apply-Image /ImageFile:LOCATION_OF_YOUR_IMAGE\image.wim /Index:1 /ApplyDir:W:\

```

Run `deploy_windows_image_.bat`



Create Apply UEFI Partition
`apply_uefi_recovery_parition_windows_10_.bat`

```
rem == Copy boot files to the System partition ==
W:\Windows\System32\bcdboot W:\Windows /s S:

:rem == Copy the Windows RE image to the
:rem    Windows RE Tools partition ==
md R:\Recovery\WindowsRE
xcopy /h W:\Windows\System32\Recovery\Winre.wim R:\Recovery\WindowsRE\

:rem == Register the location of the recovery tools ==
W:\Windows\System32\Reagentc /Setreimage /Path R:\Recovery\WindowsRE /Target W:\Windows

:rem == Verify the configuration status of the images. ==
W:\Windows\System32\Reagentc /Info /Target W:\Windows
```

Run `apply_uefi_recovery_parition_windows_10_.bat`


Your machine should now be imaged, restart or shutdown.
