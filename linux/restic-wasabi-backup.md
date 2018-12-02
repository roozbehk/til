### Create Wasabi Account
### CREATE BUCKET
### CREATE USER
### CREATE POLICY 
### ATTACH POLICY TO USER 


### Download Restic 
Go to URL:
https://github.com/restic/restic/releases/ and download latest linux_arm64.bz2

wget https://github.com/restic/restic/releases/download/v0.9.3/restic_0.9.3_linux_amd64.bz2
bzip2 -d restic_0.9.3_linux_amd64.bz2
chmod u+x restic_0.9.3_linux_amd64
mv restic_0.9.3_linux_amd64 /bin/restic
restic version


## Create backup script files

`vim /root/restic/.restic-keys`
```
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export RESTIC_PASSWORD=""

```


`vim /root/restic/backup.sh`
```
#!/bin/bash

source /root/restic/.restic-keys
export RESTIC_REPOSITORY="s3:https://s3.us-west-1.wasabisys.com/BUCKETNAME"

echo -e "\n`date` - Starting backup...\n"

restic backup /etc
restic backup /root --exclude .cache --exclude .local
restic backup /home --exclude .cache --exclude .local
restic backup /var/log
restic backup /var/www
restic backup /backup/automysqlbackup

echo -e "\n`date` - Running forget and prune...\n"

restic forget --prune --keep-daily 7 --keep-weekly 4 --keep-monthly 6

echo -e "\n`date` - Backup finished.\n"
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset RESTIC_PASSWORD
unset RESTIC_REPOSITORY
```

### CronJob

cron
*/5 * * * *  ionice -c2 -n7 nice -n19 bash /root/restic/backup.sh > /var/log/restic-backup.log && curl -fsS --retry 3 https://hc-ping.com/ab626f33 > /dev/null

