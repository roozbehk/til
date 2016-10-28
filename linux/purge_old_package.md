
0
down vote
`sudo update-grub`

And if you want delete / purge old packages you can do also

`dpkg --list |grep "^rc" | cut -d " " -f 3 | xargs sudo dpkg --purge`
