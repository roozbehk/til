$scriptpath = $MyInvocation.MyCommand.Path
$path = Split-Path $scriptpath
Set-Location  $path
#$computers = get-content ..\computers.txt
$computers = get-content ..\computers_all.txt
$path_systeminfo_shortcut = "systeminfo.lnk"
$path_systeminfo = "systeminfo.exe"
$computers | where{test-connection $_ -quiet -count 1} | ForEach-Object{

copy-item $path_systeminfo_shortcut "\\$_\c$\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
Write-Host $_
Write-Host "Copied file $path_systeminfo_shortcut to C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"

if (!(Test-Path -path "\\$_\c$\Program Files (x86)\SystemInfo")) 

{New-Item "\\$_\c$\Program Files (x86)\SystemInfo" -Type Directory}

copy-item $path_systeminfo "\\$_\c$\Program Files (x86)\SystemInfo\" -force -recurse
}

Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")