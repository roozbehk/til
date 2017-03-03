@ECHO.
@ECHO Installing Firefox
"%~dp0Firefox Setup 45.7.0esr.exe" -ms

REM Install 64-bit customisations
if exist "%ProgramFiles%\Mozilla Firefox\" copy /Y "%~dp0override.ini" "%ProgramFiles%\Mozilla Firefox\browser"
if exist "%ProgramFiles%\Mozilla Firefox\" copy /Y "%~dp0override.ini" "%ProgramFiles%\Mozilla Firefox"
if exist "%ProgramFiles%\Mozilla Firefox\" copy /Y "%~dp0mozilla.cfg" "%ProgramFiles%\Mozilla Firefox"
if exist "%ProgramFiles%\Mozilla Firefox\" copy /Y "%~dp0autoconfig.js" "%ProgramFiles%\Mozilla Firefox\defaults\pref"

if exist "%ProgramFiles%\Mozilla Firefox\" copy /Y "%~dp0Extensions\webclipper.xpi" "%ProgramFiles%\Mozilla Firefox\browser\extensions"


REM Removes Firefox Desktop Icon 
if exist "%public%\Desktop\Mozilla Firefox.lnk" del "%public%\Desktop\Mozilla Firefox.lnk"


