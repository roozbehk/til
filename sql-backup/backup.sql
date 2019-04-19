DECLARE @MyFileName varchar(1000)

SELECT @MyFileName = (SELECT 'D:\SQL Backup\PLUS_Reports\PLUS_Reports_backup_' + convert(varchar(500),GetDate(),112) + '.bak') 
BACKUP DATABASE [PLUS_Reports] TO DISK=@MyFileName WITH COPY_ONLY;

SELECT @MyFileName = (SELECT 'D:\SQL Backup\PLUS\PLUS_backup_' + convert(varchar(500),GetDate(),112) + '.bak') 
BACKUP DATABASE [PLUS] TO DISK=@MyFileName WITH COPY_ONLY;
