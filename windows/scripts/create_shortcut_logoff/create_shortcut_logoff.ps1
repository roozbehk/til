$scriptpath = $MyInvocation.MyCommand.Path
$path = Split-Path $scriptpath
Set-Location  $path
$computers = get-content ..\computers.txt
$computers = get-content ..\computers_all.txt
$path_logout_icon = "Logoff.ico"
$path_logout = "Logout.lnk"
$computers | where{test-connection $_ -quiet -count 1} | ForEach-Object{

copy-item $path_logout_icon "\\$_\c$\windows\web"
copy-item $path_logout "\\$_\c$\Users\public\desktop"


Write-Host $_
Write-Host "Copied file to public desktop"
}

Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")