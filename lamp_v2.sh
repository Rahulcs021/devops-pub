#!/bin/bash

# LAMP script for ubuntu operating system
# Written By RAHUL
# Last Modified 28th May 2019

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi


sudo apt update
sudo apt-get install -y apache2

sudo a2enmod rewrite headers ssl

sudo apt-get install -y mysql-server
#sudo mysql_secure_installation #installing MYSQL
# Make sure that NOBODY can access the server without a password
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root'"
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'"
# Kill off the demo database
mysql -e "DROP DATABASE test"
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"
# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

sudo apt-get -y update
sudo add-apt-repository ppa:ondrej/php #adding PHP repository
sudo apt-get -y update
echo
echo "#############################################################################################################"
echo "                                  Which PHP version you want to install                                        "
echo "#############################################################################################################"
echo "Press 1 for PHP7.2"
echo "Press 2 for PHP7.3"
echo "Press 3 for PHP7.4"
echo "Press 4 for PHP8.0"
echo "Press 5 for PHP8.1"
read -r option

# switch case for selecting PHP version

case $option in

	1)
		echo "You chose PHP7.2"
		sudo apt-get install -y php7.2 libapache2-mod-php7.2 php7.2-common php7.2-gd php7.2-mysql php7.2-curl php7.2-intl php7.2-xsl php7.2-mbstring php7.2-zip php7.2-bcmath php7.2-iconv php7.2-soap
		;;
	2)
		echo "You chose PHP7.3"
		sudo apt-get install -y php7.3 libapache2-mod-php7.3 php7.3-common php7.3-gd php7.3-mysql php7.3-mcrypt php7.3-curl php7.3-intl php7.3-xsl php7.3-mbstring php7.3-zip php7.3-bcmath php7.3-iconv php7.3-soap
		;;
	3)
		echo "You chose PHP7.4"
		sudo apt-get install -y php7.4 libapache2-mod-php7.4 php7.4-common php7.4-gd php7.4-mysql php7.4-mcrypt php7.4-curl php7.4-intl php7.4-xsl php7.4-mbstring php7.4-zip php7.4-bcmath php7.4-iconv php7.4-soap
		;;
	4)
		echo "You chose PHP8.0"
		sudo apt-get install -y php8.0 libapache2-mod-php8.0 php8.0-common php8.0-gd php8.0-mysql php8.0-mcrypt php8.0-curl php8.0-intl php8.0-xsl php8.0-mbstring php8.0-zip php8.0-bcmath php8.0-iconv php8.0-soap
		;;
	5)
		echo "You chose PHP8.1"
		sudo apt-get install -y php8.1 libapache2-mod-php8.1 php8.1-common php8.1-gd php8.1-mysql php8.1-mcrypt php8.1-curl php8.1-intl php8.1-xsl php8.1-mbstring php8.1-zip php8.1-bcmath php8.1-iconv php8.1-soap
		;;
	*)
		echo "Selected option is not available"
		;;
esac

echo "PHP installation is done"

echo "Installing other necessary packages"
sudo apt-get install -y zip unzip wget vim curl git phpmyadmin
sudo chown -R $USER:$USER /var/www/html

sudo echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php
echo "Please visit the URL: http://localhost/info.php to confirm"

sudo systemctl restart apache2
