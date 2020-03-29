$scriptpath = $MyInvocation.MyCommand.Path
$path = Split-Path $scriptpath
Set-Location  $path
#$computers = get-content ..\computers.txt
$computers = get-content ..\computers_all.txt

$SourcePath = "Uninstall-Office365"

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

        $exe = "c:\Program Files\Microsoft Office\Office16\WINWORD.exe"

        if (Test-Path $exe) {
            $path = (Resolve-Path $exe).ProviderPath
            $ver = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($path).FileVersion
	    write-host  "Microsoft Office Version Number Installed: $ver"
	    Remove-Item 'C:\installer\' -Recurse
	    return; 
        }


$process = Start-Process -FilePath "C:\installer\Uninstall-Office365\unisntall.cmd" -PassThru

for($i = 0; $i -le 100; $i = ($i + 1) % 100)
{
    Write-Progress -Activity "UnInstaller" -PercentComplete $i -Status "Uninstalling Pre-Installed Office365"
    Start-Sleep -Milliseconds 100
    if ($process.HasExited) {
        Write-Progress -Activity "Installer" -Completed
        break
    }
}

Remove-Item 'C:\installer\' -Recurse

}
    

}

Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")