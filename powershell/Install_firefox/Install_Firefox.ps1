$scriptpath = $MyInvocation.MyCommand.Path
$path = Split-Path $scriptpath
Set-Location  $path

$computers = get-content ..\computers.txt


$computers | where{test-connection $_ -quiet -count 1} | ForEach-Object{
     

     copy-item $path  "\\$_\c$\OS" -recurse -force

    
     Write-Host  "Application Installing on  $_  ..."
     Invoke-Command -Computername $_ -ScriptBlock {
     
     	    Start-Process "C:\os\Install_Firefox\install.cmd" /silent -Wait

               
     }
}

Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")