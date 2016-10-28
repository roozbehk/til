So all I did to fix the problem was:
- hold down shift while booting so the grub menu shows up
- boot using another kernel (not the first one)
- check if you're out of disk space on /boot using
Code:
`df`
Look for the line that ends in "/boot". Mine said something like this:
Code:
Filesystem           1K-blocks      Used Available Use% Mounted on
...
/dev/sda1               233191    233191         0 100% /boot
- check which linux images are installed using:
Code:
`dpkg --get-selections | grep linux-image-`
- chech which one you're using now:
Code:
`uname -a`
- uninstall a bunch of the oldest ones (but leave a few just in case - including the one you used to boot!). You can do this using
Code:
`sudo apt-get remove linux-image-`

then just press tab to get a list of the installed images, type the next digit(s) and press tab again to autocomplete.
- also uninstall the last one (the one that failed) and install it again after all the old ones have been uninstalled)
- before uninstalling make absolutely sure you're not uninstalling the one you're currently using! The reason is that you may want to boot again using that kernel, if everything doesn't work out.
- reboot and see if it works (it did for me).
