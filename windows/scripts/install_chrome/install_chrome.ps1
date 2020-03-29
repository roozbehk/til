$scriptpath = $MyInvocation.MyCommand.Path
$path = Split-Path $scriptpath
Set-Location  $path
#$computers = get-content ..\computers.txt
$computers = get-content ..\computers_all.txt

$source = "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B03FE9563-80F9-119F-DA3D-72FBBB94BC26%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable/dl/chrome/install/googlechromestandaloneenterprise64.msi"
$destinationFile = "chrome.msi"
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

        $exe = "c:\Program Files*\Google\Chrome\Application\chrome.exe"

        if (Test-Path $exe) {
            $path = (Resolve-Path $exe).ProviderPath
            $ver = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($path).FileVersion
	    write-host  "Chrome Version Number Installed: $ver"
	    Remove-Item 'C:\installer\' -Recurse
	    return; 
        }


$process = Start-Process msiexec.exe -ArgumentList "/I C:\installer\$Using:destinationFile /q /norestart" -PassThru

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