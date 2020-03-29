$scriptpath = $MyInvocation.MyCommand.Path
$path = Split-Path $scriptpath
Set-Location  $path
#$computers = get-content ..\computers.txt
$computers = get-content ..\computers_all.txt

$SourcePath = "show_this_pc"

$computers | where{test-connection $_ -quiet -count 1} | ForEach-Object{
Write-Host "Computer: $_"

$DestPath = "\\$_\c$\installer"

If (Test-Path -Path $DestPath -PathType Container)
   { Write-Host "$DestPath already exists, deleting $DestPath" -ForegroundColor Yellow;
     Remove-Item $DestPath -Recurse
   }

Write-Host "Copying Install Files ($SourcePath) to $DestPath" -ForegroundColor Yellow;
New-Item -Path $DestPath -ItemType directory | Out-Null
copy -Recurse -Path "$SourcePath" -destination $DestPath 

Invoke-Command -Computername $_ -ScriptBlock {


Start-Process -FilePath "C:\installer\show_this_pc\install.cmd" -Wait

Remove-Item 'C:\installer\' -Recurse

}
    

}

Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")