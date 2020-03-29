$scriptpath = $MyInvocation.MyCommand.Path
$path = Split-Path $scriptpath
Set-Location  $path
#$computers = get-content ..\computers.txt
$computers = get-content ..\computers_all.txt


$computers | where{test-connection $_ -quiet -count 1} | ForEach-Object{

Write-Host "Computer: $_"



Invoke-Command -Computername $_ -ScriptBlock {


if (test-path C:\Users\*\AppData\Local\Microsoft\Teams\current\Teams.exe)
{kill -name teams -force;
(Get-ItemProperty C:\Users\*\AppData\Local\Microsoft\Teams\Current).PSParentPath | foreach-object {Start-Process $_\Update.exe -ArgumentList "--uninstall /s" -PassThru -Wait}
}


}
    

}

Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")