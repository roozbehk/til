
```powershell
Search-ADAccount –ComputersOnly -AccountInactive -TimeSpan 180.00:00:00 | ?{$_.enabled -eq $True} | sort LastLogonDate| Format-Table samaccountname, LastLogonDate, name, distinguishedname, enabled 
