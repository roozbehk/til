takeown /f c:\windows\WEB\wallpaper\Windows\img0.jpg
takeown /f C:\Windows\Web\4K\Wallpaper\Windows\*.*
icacls c:\windows\WEB\wallpaper\Windows\img0.jpg /Grant System:(F)
icacls C:\Windows\Web\4K\Wallpaper\Windows\*.* /Grant System:(F)
del c:\windows\WEB\wallpaper\Windows\img0.jpg
del /q C:\Windows\Web\4K\Wallpaper\Windows\*.*
copy %~dp0img0.jpg c:\windows\WEB\wallpaper\Windows\img0.jpg
copy %~dp04k\*.* C:\Windows\Web\4K\Wallpaper\Windows
