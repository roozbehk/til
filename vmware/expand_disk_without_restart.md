Once you've changed the disk's size in VMware and did not reboot your server, rescan your SCSI devices as such.

First, check the name(s) of your scsi devices.

`$ ls /sys/class/scsi_device/`

Then rescan the scsi bus. Below you can replace the '0\:0\:0\:0′ with the actual scsi bus name found with the previous
command. Each colon is prefixed with a slash, which is what makes it look weird.

`~$ echo 1 > /sys/class/scsi_device/0\:0\:0\:0/device/rescan`

That will rescan the current scsi bus and the disk size that has changed will show up.

