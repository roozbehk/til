`cmd.exe /c install.cmd`

```batch
:: ***** Set varilables *****
:: Environment Variables for x86/x64
IF %PROCESSOR_ARCHITECTURE%==AMD64 SET HKPATH=HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node
IF %PROCESSOR_ARCHITECTURE%==x86 SET HKPATH=HKEY_LOCAL_MACHINE\SOFTWARE
ECHO %HKPATH%

:: ::::::::::::::::::::::::::::::::::::::::::

:: ***** Check if Chrome installation exists *****

REG QUERY "%HKPATH%\Google\Update\ClientState\{8A69D345-D564-463C-AFF1-A69D9E530F96}"
REM ***** If registry exist continue to uninstall script. If registry key does not exist goto :INSTALL *****
IF %ERRORLEVEL%==1 goto INSTALL

:: ::::::::::::::::::::::::::::::::::::::::::

:: ***** Setup.exe uninstall script *****
:: ****** Query for setup.exe path *****
FOR /F "usebackq tokens=3*" %%A IN (`REG QUERY "%HKPATH%\Google\Update\ClientState\{8A69D345-D564-463C-AFF1-A69D9E530F96}" /v UninstallString`) DO (
    set appdir=%%A %%B
    )
ECHO %appdir%
:: ***** Setup.exe uninstall *****
"%appdir%" --uninstall --multi-install --chrome --system-level --force-uninstall

:: ::::::::::::::::::::::::::::::::::::::::::

REM ***** taskkill GoogleUpdate.exe *****
taskkill.exe /F /IM GoogleUpdate.exe /T

:: ::::::::::::::::::::::::::::::::::::::::::

:INSTALL

:: ***** Install *****

msiexec.exe ALLUSERS=2 /m MSIHUPGC /i "%~dp0googlechromestandaloneenterprise64.msi" /qn
xcopy "%~dp0master_preferences" "C:\Program Files (x86)\Google\Chrome\Application\master_preferences*" /I /Y
del "C:\Users\Public\Desktop\Google Chrome.lnk"
```
