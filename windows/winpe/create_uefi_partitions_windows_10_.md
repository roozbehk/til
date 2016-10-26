``create_uefi_partitions_windows_10_.conf
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
assign letter="C"
rem === 4. Recovery tools partition ================
create partition primary
format quick fs=ntfs label="Recovery tools"
assign letter="R"
set id="de94bba4-06d1-4d40-a16a-bfd50179d6ac"
gpt attributes=0x8000000000000001
list volume
exit
```
