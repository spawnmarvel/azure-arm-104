
# Azure pre
# Rg test-monitor
# A new vnet and subnet test-monitor-vnet

# VM MySQL
#
#
#
# VM Zabbix
#
#
#

# ladmin
# Thisisnotgood789

# https://www.youtube.com/watch?v=88HaOuXaUcU&list=LL&index=1&t=600s

# How To Install Zabbix 6.0 LTS

# 6.0 LTS, MySQL, Apache

# All this was done with root

# VM MySql
# 1 update the vm
sudo apt update

# 2  install mysql server
sudo apt install mysql-server

# 3 secure mysql (SKIP THIS FOR NOW)
sudo mysql_secure_installation

# In the last step I kept all for the test, pass is the same as for VM.
# But that is not the correct for secure installation, choose several “YES”, you will see when you do it.

# 3.1  Test 
sudo mysql

# query
select now();

# exit
exit;

# VM Zabbix
# 4 add packages, Install Zabbix repository
# Install Zabbix repository
wget https://repo.zabbix.com/zabbix/6.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.2-1+ubuntu20.04_all.deb

sudo dpkg -i zabbix-release_6.2-1+ubuntu20.04_all.deb

sudo apt update
# 5 Install Zabbix server for mysql (we get all configuration for mysql (not MySql)), frontend, agent
sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent

# 6 VM MySql
# Create initial database, Make sure you have database server up and running.
# Run the following on your database host.
# Replace localhost with ip to Zabbix server
# Must allow VM Zabbix IP to connect to MySQL

# mysql -uroot -p
# password
sudo mysql
mysql> create database zabbix character set utf8mb4 collate utf8mb4_bin;
mysql> create user zabbix@10.1.0.5 identified by 'zabbix123';
mysql> select user, host from mysql.user;
mysql> grant all privileges on zabbix.* to zabbix@10.1.0.5;
mysql> show databases;
mysql> quit;

# 7, The files must be copied from zabbix to mysql. This creates all the zabbix tables
# The zcat command allows the user to expand and view a compressed file without uncompressing that file.
# On MySql (since remote Zabbix) server host import initial schema and data. You will be prompted to enter your newly created password.
# on the vm-zabbix navigate to

# before you start make a the folder on vm-mysql
mkdir from-vm-zabbix

# then back to vm-zabbox for the copy
/usr/share/doc/zabbix-sql-scripts/mysql

/usr/share/doc/zabbix-sql-scripts/mysql$ scp server.sql.gz ladmin@IP-of-mysql:/home/ladmin/from-vm-zabbix
 # type yes
 # give password for user



# 8 
# VM Zabbix
# Configure the database for Zabbix server
# Edit file /etc/zabbix/zabbix_server.conf
DBPassword=password
DBHost=IP to MySQL
DBName=zabbix
DBUser=zabbix
DBPort=3306

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

