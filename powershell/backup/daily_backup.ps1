$_datetime=(Get-Date).tostring("yyyy-MM-dd")


robocopy "H:\SQLBackups" "\\sa-nas\Backups\H\SQLBackups" /MIR /NP /ndl /FFT /Z  /R:5 /W:5 /LOG+:\\sa-nas\Backups\H\backup-logs\${_datetime}_Dailybackup.log
robocopy "H:\pbsw"       "\\sa-nas\Backups\H\pbsw" /MIR /NP /ndl /FFT /Z  /R:5 /W:5 /LOG+:\\sa-nas\Backups\H\backup-logs\${_datetime}_Dailybackup.log
robocopy "H:\Software"       "\\sa-nas\Backups\H\Software" /MIR /NP /ndl /FFT /Z  /R:5 /W:5 /LOG+:\\sa-nas\Backups\H\backup-logs\${_datetime}_Dailybackup.log
robocopy "H:\Share"       "\\sa-nas\Backups\H\Share" /MIR /NP  /ndl /FFT /Z  /R:5 /W:5 /LOG+:\\sa-nas\Backups\H\backup-logs\${_datetime}_Dailybackup.log
robocopy "H:\TW"       "\\sa-nas\Backups\H\TW" /MIR /NP /NDL /ndl /FFT /Z  /R:5 /W:5 /LOG+:\\sa-nas\Backups\H\backup-logs\${_datetime}_Dailybackup.log
robocopy "H:\images" "\\sa-nas\Backups\H\images" /MIR /NP /ndl /FFT /Z  /R:5 /W:5 /LOG+:\\sa-nas\Backups\H\backup-logs\${_datetime}_Dailybackup.log


Invoke-RestMethod  https://hc-ping.com/e6d61bd8-d12a-4261-b821-1fe5dc3f54d0
