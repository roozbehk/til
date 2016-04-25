Check if Service is not running, start it
```pwoershell
function FuncCheckService{
  param($ServiceName)
  $arrService = Get-Service -Name $ServiceName
  $Date = Get-Date -Format "MM/dd/yyyy HH:mm:ss"
  $Start = "Started "
  $Started = " service is already started."
  if ($arrService.Status -ne "Running"){
  Start-Service $ServiceName
  ($Date + " - " + $Start + $ServiceName) | Out-file C:\OS\Log.txt -append
  }
}
```
