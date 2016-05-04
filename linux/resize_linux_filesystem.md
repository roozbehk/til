Disclaimer: The following instructions can easily screw your data if you make a mistake. I was doing this on a VM which I backed up before performing the following actions. If you loose your data because you didn’t backup don’t come and complain.

## Increase the disk size.

In ESXi this is simple, just increase the size of the virtual disk. Now you have a bigger hard drive but you still need to a) increase the partition size and b) resize the filesystem.

## Increase the partition size.

You can use fdisk to change your partition table while running. The stock Ubuntu install has created 3 partitions: one primary (sda1), one extended (sda2) with a single logical partition (sda5) in it. The extended partition is simply used for swap, so I could easily move it without losing any data.

Delete the primary partition
Delete the extended partition
Create a new primary partition starting at the same sector as the original one just with a bigger size (leave some for swap)
Create a new extended partition with a logical partition in it to hold the swap space

```bash
fdisk -l

Disk /dev/sda: 64.4 GB, 64424509440 bytes
255 heads, 63 sectors/track, 7832 cylinders, total 125829120 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x0004dd36

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1            2048    75503614    37750783+  83  Linux
/dev/sda2        75503615    83886079     4191232+   5  Extended
/dev/sda5        75505663    83886079     4190208+  82  Linux swap / Solaris


root@rl-web:~# fdisk /dev/sda

Command (m for help): p

Disk /dev/sda: 64.4 GB, 64424509440 bytes
255 heads, 63 sectors/track, 7832 cylinders, total 125829120 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x0004dd36

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1            2048    75503614    37750783+  83  Linux
/dev/sda2        75503615    83886079     4191232+   5  Extended
/dev/sda5        75505663    83886079     4190208+  82  Linux swap / Solaris

Command (m for help): d
Partition number (1-5): 1

Command (m for help): d
Partition number (1-5): 2

Command (m for help): p
Disk /dev/sda: 64.4 GB, 64424509440 bytes
255 heads, 63 sectors/track, 7832 cylinders, total 125829120 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x0004dd36


Command (m for help): n
Partition type:
   p   primary (0 primary, 0 extended, 4 free)
   e   extended
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-125829119, default 2048): 
Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-125829119, default 125829119): 117448703

Command (m for help): n
Partition type:
   p   primary (1 primary, 0 extended, 3 free)
   e   extended
Select (default p): e
Partition number (1-4, default 2): 2
First sector (117448704-125829119, default 117448704): 
Using default value 117448704
Last sector, +sectors or +size{K,M,G} (117448704-125829119, default 125829119): 
Using default value 125829119

Command (m for help): p

Disk /dev/sda: 64.4 GB, 64424509440 bytes
255 heads, 63 sectors/track, 7832 cylinders, total 125829120 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x0004dd36

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1            2048   117448703    58723328   83  Linux
/dev/sda2       117448704   125829119     4190208    5  Extended
```
# Recreate Swap Parition in sda2

logical partition will be created in extended file system and will be assigned Hex code 82 for marking it swap partition

```bash
Command (m for help): n
Partition type:
   p   primary (1 primary, 1 extended, 2 free)
   l   logical (numbered from 5)
Select (default p): l
Adding logical partition 5
First sector (117450752-125829119, default 117450752): 
Using default value 117450752
Last sector, +sectors or +size{K,M,G} (117450752-125829119, default 125829119): 
Using default value 125829119

Command (m for help): t
Partition number (1-5): 5
Hex code (type L to list codes): 82
Changed system type of partition 5 to 82 (Linux swap / Solaris)

Command (m for help): p

Disk /dev/sda: 64.4 GB, 64424509440 bytes
255 heads, 63 sectors/track, 7832 cylinders, total 125829120 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x0004dd36

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1            2048   117448703    58723328   83  Linux
/dev/sda2       117448704   125829119     4190208    5  Extended
/dev/sda5       117450752   125829119     4189184   82  Linux swap / Solaris

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.

WARNING: Re-reading the partition table failed with error 16: Device or resource busy.
The kernel still uses the old table. The new table will be used at
the next reboot or after you run partprobe(8) or kpartx(8)
Syncing disks.

```
at this point you can reboot the system 

`root@rl-web:~# sudo reboot`

resize your disk
`root@rl-web:~# sudo resize2fs /dev/sda1`

check the space increase
`df -h`



## Recreate Swap:
remember the `UUID you will need to change your fstab
`root@rl-web:~# mkswap /dev/sda5`
Setting up swapspace version 1, size = 4189180 KiB
no label, UUID=9bcfb33b-a900-4688-875c-d5cfd02a7120
make swap active
`root@rl-web:~# sudo swapon --all --verbose`

change swap UUID in /etc/fstab
`root@rl-web:~# vim /etc/fstab`
