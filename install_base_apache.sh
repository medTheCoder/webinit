echo 'Installation with Apache2...'

echo ' ---/ update and upgrade'
apt-get update
apt-get upgrade

echo ' ---/ install apache2, php, mysql'
apt-get --yes --force-yes install apache2 php5 mysql-server mysql-client
apt-get --yes --force-yes install libapache2-mod-php5 php5-mysql

echo ' ---/ install monit'
apt-get --yes --force-yes install monit

 
