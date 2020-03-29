$scriptpath = $MyInvocation.MyCommand.Path
$path = Split-Path $scriptpath
Set-Location  $path
$computers = get-content ..\computers.txt
$computers = get-content ..\computers_all.txt


$computers | where{test-connection $_ -quiet -count 1} | ForEach-Object{
Write-Host "Computer: $_"


Invoke-Command -Computername $_ -ScriptBlock {


Start-Process taskkill -ArgumentList "/f /im OneDrive.exe " 


$process = Start-Process -FilePath "C:\Windows\SysWOW64\OneDriveSetup.exe " -ArgumentList "/uninstall  /S" -PassThru

for($i = 0; $i -le 100; $i = ($i + 1) % 100)
{
    Write-Progress -Activity "Uninstaller" -PercentComplete $i -Status "Uninstalling OneDrive"
    Start-Sleep -Milliseconds 100
    if ($process.HasExited) {
        Write-Progress -Activity "Installer" -Completed
        break
    }
}


}
    

}

Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")