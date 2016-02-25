Hibernation is a power-saving state designed primarily for laptops. While sleep puts your work and settings in memory and draws a small amount of power, hibernation puts your open documents and programs on your hard disk, and then turns off your computer. Of all the power-saving states in Windows, hibernation uses the least amount of power. On a laptop, use hibernation when you know that you won't use your laptop for an extended period and won't have an opportunity to charge the battery during that time.

## To Disable Hibernate

NOTE: This step will disable hibernation, delete the hiberfil.sys file, and remove the Allow hybrid sleep and Hibernate after Power Options under Sleep. This will also disable fast startup in Windows 8.


```
powercfg -h off
```

http://www.sevenforums.com/tutorials/819-hibernate-enable-disable.html
