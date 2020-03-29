$scriptpath = $MyInvocation.MyCommand.Path
$path = Split-Path $scriptpath
Set-Location  $path
#$computers = get-content ..\computers.txt
$computers = get-content ..\computers_all.txt


$computers | where{test-connection $_ -quiet -count 1} | ForEach-Object{
Write-Host "Computer: $_"
Invoke-Command -Computername $_ -ScriptBlock {

net user smk smk /add
net user smk /fullname:"Smile Klub"
net user smkadmin /fullname:"Smile Klub Admin"
wmic useraccount where "name='smk'" set PasswordExpires=FALSE
exit


}
    

}

Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")