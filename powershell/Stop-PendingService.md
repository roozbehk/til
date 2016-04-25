Force Stop a Service that is pedning stop. 
```powershell
function Stop-PendingService {
<#
.SYNOPSIS
    Stops one or more services that is in a state of 'stop pending'.
.DESCRIPTION
     Stop-PendingService is a function that is designed to stop any service
     that is hung in the 'stop pending' state. This is accomplished by forcibly
     stopping the hung services underlying process.
.EXAMPLE
     Stop-PendingService
#>
    $Services = Get-WmiObject -Class win32_service -Filter "state = 'stop pending'"
    if ($Services) {
        foreach ($service in $Services) {
            try {
                Stop-Process -Id $service.processid -Force -PassThru -ErrorAction Stop
		Write-Warning $service.processid
            }
            catch {
                Write-Warning -Message "Unexpected Error. Error details: $_.Exception.Message"
            }
        }
    }
    else {
        Write-Output "There are currently no services with a status of 'Stopping'."
    }
}

Stop-PendingService
```
