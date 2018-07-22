
```
c:\OS\PSTools\PsExec.exe \\server -accepteula -e cmd.exe /c  "net start SQLAgent$CDRDICOM"
c:\OS\PSTools\PsExec.exe \\server -accepteula -e cmd.exe /c  "net stop SQLAgent$CDRDICOM && net stop MSSQL$CDRDICOM"

SQL_Diff
sqlcmd -S .\CDRDICOM -E -Q "EXEC sp_BackupDatabases @backupLocation='X:\SQLBackups\', @databaseName='CDRData', @backupType='D'"

SQL_Full
sqlcmd -S .\CDRDICOM -E -Q "EXEC sp_BackupDatabases @backupLocation='X:\SQLBackups\', @databaseName='CDRData', @backupType='F'"

SQL_Log
sqlcmd -S .\CDRDICOM -E -Q "EXEC sp_BackupDatabases @backupLocation='X:\SQLBackups\', @databaseName='CDRData', @backupType='L'"

