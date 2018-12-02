## S3 + Duplicity + duplicity-backup.sh on Ubuntu 	Ubuntu 16.04 LTS

<pre>
apt-get install s3cmd
sudo apt-add-repository ppa:duplicity-team/ppa
sudo apt-get update

16.04 release of ubuntu
sudo apt-get install duplicity haveged python-boto

18.03 release of ubuntu
sudo apt-get install duplicity haveged python-boto3

apt-get install mailutils
chmod 0700 ~/.duplicity/.backup.sh
chmod 0700 ~/duplicity-backup/duplicity-backup.sh


0 3 * * * /root/.duplicity/.backup.sh && curl -fsS --retry 3 https://hchk.io/e2 > /dev/null
source "/root/.duplicity/.env_variables.conf"

</pre>
