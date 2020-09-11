```dd if=/dev/vda1 | gzip -1 - | ssh roozbeh@76.169.180.36 -p 2222  dd of=web01.gz```

gzip -d web01.gz
 sudo mount -o loop web01 /mnt/temp


 I've never used dd before to copy disks. It's a unix tool that copies files bit by bit. Since hard disks on unix systems are just represented as files you can do exact copies of them with it. It's strength is really it's weakness. It copies all the data on the disk if you tell it to copy your harddrive. That means everything. Even data that is was on the disk before but was not written over. Unless you wipe the disk with a disk wiping program (writing zero's across it) the previous data (if there was any) is still there. Copying every bit means it takes a very long time. We are talking hours to copy a disk. But your copy is exact. Partition info, boot sector info, everything.

I wanted to copy everything off the disk and send it over the network. So we can do it with ssh. First zero out the non used space on the running disk to make compressing the image much eaiser. Using the command:

```dd if=/dev/zero of=0bits bs=20M; rm 0bits```

Then boot knoppix (or any other bootable linux distro like sysrescuecd) from the machine you want to image and give the command:

```dd if=/dev/sda | gzip -1 - | ssh user@hostname dd of=image.gz```

Assuming sda is your hard drive. This sends the local disks data to the remote machine. To restore the image boot knoppix on the machine to restore and pull the image that you created and dump it back with the command:

```ssh user@hostname dd if=image.gz | gunzip -1 - | dd of=/dev/sda```

This will usually take a few hours so be prepared. A good site that has some info on using ssh this way is here.

Reddit! 
