takeown /f c:\windows\WEB\wallpaper\Windows\img0.jpg
takeown /f C:\Windows\Web\4K\Wallpaper\Windows\*.*
icacls c:\windows\WEB\wallpaper\Windows\img0.jpg /Grant 'System:(F)'
icacls C:\Windows\Web\4K\Wallpaper\Windows\*.* /Grant 'System:(F)'
Remove-Item c:\windows\WEB\wallpaper\Windows\img0.jpg
Remove-Item C:\Windows\Web\4K\Wallpaper\Windows\*.*
Copy-Item $PSScriptRoot\img0.jpg c:\windows\WEB\wallpaper\Windows\img0.jpg
Copy-Item $PSScriptRoot\4k\*.* C:\Windows\Web\4K\Wallpaper\Windows


