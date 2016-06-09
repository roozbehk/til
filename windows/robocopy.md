```
::Copy all files from sourcepath to destinationpath using Robocopy
::Last updated on 23/02/2012 by Adam Rush
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
