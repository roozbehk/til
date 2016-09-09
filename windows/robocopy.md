```
::Copy all files from sourcepath to destinationpath using Robocopy
::
::Switches:
::(E)mpty folders included in copy
::(R)etry each copy up to 15 times
::(W)ait 5 seconds between attempts
::(LOG) creates log file
::(NP) do not include progress txt in logfile; this keeps filesize down
::(MIR)rors a directory tree
::Source path
set sourcepath=E:\Backups
::Destination path
set destinationpath=F:\Backups
::Log path
set logpath=E:\Logs\Robocopy\
::Include format yyyy-mm-dd#hh-mm-ss.ms in log filename
set filename=Robocopy_%date:~-4,4%-%date:~-7,2%-%date:~-10,2%#%time::=-%.txt
::Run command
robocopy %sourcepath% %destinationpath% /E /R:15 /W:5 /LOG:”%logpath%%filename%” /NP /MIR
```

```
@echo off

SET SORC="\\SORC\e$\FOLDER"
SET DEST="\\DEST\w$\FOLDER"
SET LOG="\\LOG\w$\file.log"

ROBOCOPY %SORC% %DEST% /e /R:1 /W:1 /NP /LOG:%LOG%
@if errorlevel 16 echo ***ERROR *** & goto END
@if errorlevel 8 echo **FAILED COPY ** & goto END
@if errorlevel 4 echo *MISMATCHES * & goto END
@if errorlevel 2 echo EXTRA FILES & goto END
@if errorlevel 1 echo --Copy Successful-- & goto END
@if errorlevel 0 echo --Copy Successful-- & goto END
goto END

:END

pause

```
