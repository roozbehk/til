
I recently ran into a really annoying problem on my Windows 8.1 64-bit PC: every time I restarted it and booted into Windows, the Windows Explorer Libraries window would pop up. It never occurred before and I could not pinpoint any particular software or update that I had installed that would cause it to start happening.

Userinit Registry Key

create a reg file `explorer_fix.reg` and copy this into and run it. 

```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon]
"Shell"="explorer.exe"
```


[Reference](http://helpdeskgeek.com/windows-7/fix-windows-explorer-window-opening-on-startup)