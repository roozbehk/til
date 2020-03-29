$scriptpath = $MyInvocation.MyCommand.Path
$path = Split-Path $scriptpath
Set-Location  $path
$computers = get-content ..\computers.txt
#$computers = get-content ..\computers_all.txt

$source = "https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=en-US"
$destinationFile = "firefox.exe"
Invoke-WebRequest $source -OutFile $destinationFile  | Out-Null


$computers | where{test-connection $_ -quiet -count 1} | ForEach-Object{
Write-Host "Computer: $_"
$SourcePath = $destinationFile
$DestPath = "\\$_\c$\installer"

If (Test-Path -Path $DestPath -PathType Container)
   { Write-Host "$DestPath already exists, deleting $DestPath" -ForegroundColor Yellow;
     Remove-Item $DestPath -Recurse 
   }

Write-Host "Copying Install Files ($SourcePath) to $DestPath" -ForegroundColor Yellow;
New-Item -Path $DestPath -ItemType directory | Out-Null
copy -Recurse -Path "$SourcePath" -destination $DestPath 


Invoke-Command -Computername $_ -ScriptBlock {

        $exe = "c:\Program Files*\Mozilla Firefox\firefox.exe"

        if (Test-Path $exe) {
            $path = (Resolve-Path $exe).ProviderPath
            $ver = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($path).FileVersion
	    write-host  "Firefox Version Number Installed: $ver"
	    Remove-Item 'C:\installer\' -Recurse
	    return; 
        }


$process = Start-Process -FilePath "C:\installer\$Using:destinationFile" -ArgumentList "/S" -PassThru

for($i = 0; $i -le 100; $i = ($i + 1) % 100)
{
    Write-Progress -Activity "Installer" -PercentComplete $i -Status "Installing $Using:destinationFile"
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