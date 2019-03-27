$Exclude = @(
'svcXXSQL001Agent',
'svcXXSQL001DBEng',
'svcXXSQL001Int'
)

$filter = ($Exclude | foreach {'(Name -ne ' + "'$_')"}) -join ' -and '
$ou = "OU=ServiceAccts,DC=nlong,DC=com"

Get-ADUser -Filter $filter -SearchBase $ou | ?{$_.name -like "svcxxsql*"} 
