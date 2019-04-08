$scriptpath = $MyInvocation.MyCommand.Path
$path = Split-Path $scriptpath
Set-Location  $path
# Get Computer Names
$computers = get-content ..\computers.txt

# Chrome
$installfile = "GoogleChromeStandaloneEnterprise64.msi"

$computers | where{test-connection $_ -quiet -count 1} | ForEach-Object{
     

     copy-item $path  "\\$_\c$\os" -recurse -force

     Write-Host  "Application Installing on  $_  ..."
     Invoke-Command -Computername $_ -ScriptBlock {
     
      
                  Start-Process "C:\os\Install_GoogleChrome\install.cmd" /silent -Wait

               
     }
}

Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")