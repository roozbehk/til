### Expand VMDK Rescan iscsi host for changes in host
Once you've changed the disk's size in VMware and did not reboot your server, rescan your SCSI devices as such.

First, check the name(s) of your scsi devices.

`$ ls /sys/class/scsi_device/`

Then rescan the scsi bus. Below you can replace the '0\:0\:0\:0′ with the actual scsi bus name found with the previous
command. Each colon is prefixed with a slash, which is what makes it look weird.

`~$ echo 1 > /sys/class/scsi_device/0\:0\:0\:0/device/rescan`

That will rescan the current scsi bus and the disk size that has changed will show up.

## fdisk create new LVM parition 

```bash

root@gsrc-web:~# fdisk -l

Disk /dev/sda: 16.1 GB, 16106127360 bytes
255 heads, 63 sectors/track, 1958 cylinders, total 31457280 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x000554f4

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048      499711      248832   83  Linux
/dev/sda2          501758    20969471    10233857    5  Extended
/dev/sda5          501760    20969471    10233856   8e  Linux LVM

Disk /dev/mapper/GSR--WEB--vg-root: 9403 MB, 9403629568 bytes
255 heads, 63 sectors/track, 1143 cylinders, total 18366464 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

Disk /dev/mapper/GSR--WEB--vg-root doesn't contain a valid partition table

Disk /dev/mapper/GSR--WEB--vg-swap_1: 1073 MB, 1073741824 bytes
255 heads, 63 sectors/track, 130 cylinders, total 2097152 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

Disk /dev/mapper/GSR--WEB--vg-swap_1 doesn't contain a valid partition table
root@gsrc-web:~# fdisk /dev/sda

Command (m for help): p

Disk /dev/sda: 16.1 GB, 16106127360 bytes
255 heads, 63 sectors/track, 1958 cylinders, total 31457280 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x000554f4

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048      499711      248832   83  Linux
/dev/sda2          501758    20969471    10233857    5  Extended
/dev/sda5          501760    20969471    10233856   8e  Linux LVM

Command (m for help): n
Partition type:
   p   primary (1 primary, 1 extended, 2 free)
   l   logical (numbered from 5)
Select (default p): p
Partition number (1-4, default 3): 3
First sector (499712-31457279, default 499712):
Using default value 499712
Last sector, +sectors or +size{K,M,G} (499712-501757, default 501757):
Using default value 501757

Command (m for help): t
Partition number (1-5): 3
Hex code (type L to list codes): 8e
Changed system type of partition 3 to 8e (Linux LVM)

Command (m for help): p

Disk /dev/sda: 16.1 GB, 16106127360 bytes
255 heads, 63 sectors/track, 1958 cylinders, total 31457280 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x000554f4

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048      499711      248832   83  Linux
/dev/sda2          501758    20969471    10233857    5  Extended
/dev/sda3          499712      501757        1023   8e  Linux LVM
/dev/sda5          501760    20969471    10233856   8e  Linux LVM

Partition table entries are not in disk order

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.

WARNING: Re-reading the partition table failed with error 16: Device or resource busy.
The kernel still uses the old table. The new table will be used at
the next reboot or after you run partprobe(8) or kpartx(8)
Syncing disks.


```
