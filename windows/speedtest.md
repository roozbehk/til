How to test internet speed

```powershell
$Request=Get-Date; Invoke-WebRequest 'http://client.akamai.com/install/test-objects/10MB.bin' | Out-Null;
[int]$speed = ((10 / ((NEW-TIMESPAN –Start $Request –End (Get-Date)).totalseconds)) * 8)
"{0:N2}" -f $Speed
Write-host "$($speed) Mbit/sec"  
```
