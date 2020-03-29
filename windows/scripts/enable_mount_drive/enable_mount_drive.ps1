$scriptpath = $MyInvocation.MyCommand.Path
$path = Split-Path $scriptpath
Set-Location  $path
$computers = get-content ..\computers.txt
$computers = get-content ..\computers_all.txt
$path = "Mount.vbs"
$computers | where{test-connection $_ -quiet -count 1} | ForEach-Object{

copy-item $path "\\$_\c$\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
Write-Host $_
Write-Host "Copied file to C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
}

Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")