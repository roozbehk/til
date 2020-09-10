
```

Taskbar
%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\Taskbar

TaskbarLayout - LayoutModification.xml
%LOCALAPPDATA%\Microsoft\Windows\Shell\


DEL /F /S /Q /A "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*"
REG DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband /F
taskkill /IM explorer.exe /F && start explorer.exe
start explorer.exe
```
