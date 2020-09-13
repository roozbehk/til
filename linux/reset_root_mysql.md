Reset MySQL root password

Below are commands:
service mysql stop
mysqld_safe --skip-grant-tables > /dev/null 2>&1 &  
mysql -u root -e "use mysql; update user set password=PASSWORD('NEW-PASSWORD') where User='root'; flush privileges;"
service mysql restart
Note: You may need to wait after mysqld_safe command, before you can run subsequent mysql command.

Test:
mysql -u root -pNEW-PASSWORD
