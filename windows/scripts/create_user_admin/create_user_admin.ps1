$scriptpath = $MyInvocation.MyCommand.Path
$path = Split-Path $scriptpath
Set-Location  $path
$computers = get-content ..\computers.txt


$computers | where{test-connection $_ -quiet -count 1} | ForEach-Object{
Write-Host "Computer: $_"
Invoke-Command -Computername $_ -ScriptBlock {

net user ltgadmin CHANGEPASSWORD /add
net localgroup administrators ltgadmin /add
wmic useraccount where "name='ltgadmin'" set PasswordExpires=FALSE
exit


}
    

}

Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")