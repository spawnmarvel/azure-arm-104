# https://www.youtube.com/watch?v=88HaOuXaUcU&list=LL&index=1&t=600s

# How To Install Zabbix 6.0 LTS

# 6.0 LTS, MySQL, Apache

# All this was done with root

# VM MySql
# 1  -y to confirm it, mysql-server gives 8.0
yum install mysql-server -y

# 2 start db
systemctl start mysqld 

# 3 get in if access
mysql

# VM Zabbix
# 4 add packages, Install Zabbix repository
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-3+ubuntu22.04_all.deb
dpkg -i zabbix-release_6.0-3+ubuntu22.04_all.deb
apt update

# 5 Install Zabbix server for mysql (we get all configuration for mysql (not MySql)), frontend, agent
# apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

# 6 VM MySql
# Create initial database, Make sure you have database server up and running.
# Run the following on your database host.
# Replace localhost with ip to Zabbix server
# Must allow VM Zabbix IP to connect to MySQL

# mysql -uroot -p
password
mysql> create database zabbix character set utf8mb4 collate utf8mb4_bin;
mysql> create user zabbix@localhost identified by 'password';
mysql> grant all privileges on zabbix.* to zabbix@localhost;
mysql> quit;

# 7, The files must be copied from zabbix to mysql. This creates all the zabbix tables
# The zcat command allows the user to expand and view a compressed file without uncompressing that file.
# On MySql (since remote Zabbix) server host import initial schema and data. You will be prompted to enter your newly created password.
zcat /usr/share/doc/zabbix-sql-scripts/mysql/server.sql.gz | mysql -uzabbix -p zabbix

# 8 
# VM Zabbix
# Configure the database for Zabbix server
# Edit file /etc/zabbix/zabbix_server.conf
DBPassword=password
DBHost=IP to MySQL
DBName=zabbix
DBUser=zabbix

# 9
# Start Zabbix server and agent processes and make it start at system boot.
systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2

# Check log file
tail -f /var/log/zabbix/zabbix_server.log

# 10
# Configure Zabbix frontend
# Connect to your newly installed Zabbix frontend: http://server_ip_or_name/zabbix
# https://www.zabbix.com/documentation/6.0/en/manual/installation/frontend
# 11 For Apache: 

http://<server_ip_or_name>/zabbix

# 12 Make sure that all software prerequisites are met.
# 13 Enter details for connecting to the database. Zabbix database must already be created.
# 14 Entering a name for Zabbix server is optional, however, if submitted, it will be displayed in the menu bar and page titles.
#    Set the default time zone and theme for the frontend.
# 16 If installing Zabbix from sources, download the configuration file and place it under conf/ in the webserver HTML documents subdirectory where you copied Zabbix PHP files to.
#    Providing the webserver user has write access to conf/ directory the configuration file would be saved automatically and it would be possible to proceed to the next step right away.
# 17 Zabbix frontend is ready! The default user name is Admin, password zabbix.

