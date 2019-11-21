#Create an Ubuntu VM with ports enabled 22, 80, 443, 3306 
#Once Ubuntu VM is ready and you are logged in, execute the following comands:

#Set variables
#Case 1 read from console

echo "Type the name of the laravel project ex. naposao, followed by [ENTER]:"

read project

if [ -z "$project" ] then
      echo "\$project is empty"
      exit 1
fi

#Case 2 set in the script
project_name = "naposao"

#Case 3 read from file

project_from_file = cat path_to_tile

#add current user to the sudoers
sudo usermod -aG sudo $(whoami)

sudo ufw allow OpenSSH

sudo apt-get update

sudo apt install nginx
sudo ufw allow 'Nginx HTTP'
sudo ufw allow 3306 

sudo apt install mysql-server
sudo add-apt-repository universe
sudo apt install php-fpm php-mysql
sudo ufw enable
sudo apt-get update && sudo apt-get upgrade

sudo systemctl reload nginx

#Install composer
sudo apt install curl php-cli php-mbstring git unzip
cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo composer require illuminate/html
sudo composer update
sudo apt-get update && sudo apt-get upgrade

#Install requiered PHP Mobules
sudo apt install php-mbstring php-xml php-bcmath
sudo chown -R $USER ~/.composer/

#Create laravel project
cd ~
composer create-project --prefer-dist laravel/laravel $project #naposao
cd $project

# copy original .env from the site to  .env
sudo nano .env

#APP_NAME=naposao
#APP_ENV=development
#APP_KEY=APPLICATION_UNIQUE_KEY_DONT_COPY
#APP_DEBUG=true
#APP_URL=http://domain_or_IP

#LOG_CHANNEL=stack

#DB_CONNECTION=mysql
#DB_HOST=127.0.0.1
#DB_PORT=3306
#DB_DATABASE=travel_list
#DB_USERNAME=travel_user
#DB_PASSWORD=password


sudo mv ~/$project /var/www/$project
sudo chown -R www-data.www-data /var/www/$project/storage
sudo chown -R www-data.www-data /var/www/$project/bootstrap/cache
sudo nano /etc/nginx/sites-available/$project


#sudo cat server >> {  /etc/nginx/sites-available/$dir
#sudo cat listen 80; >> /etc/nginx/sites-available/$dir
#    server_name server_domain_or_IP;
#    root /var/www/naposao/public;
#
#    add_header X-Frame-Options "SAMEORIGIN";
#    add_header X-XSS-Protection "1; mode=block";
#    add_header X-Content-Type-Options "nosniff";
#
#    index index.html index.htm index.php;
#
#    charset utf-8;
#
#    location / {
#        try_files $uri $uri/ /index.php?$query_string;
#    }
#
#    location = /favicon.ico { access_log off; log_not_found off; }
#    location = /robots.txt  { access_log off; log_not_found off; }
#
#    error_page 404 /index.php;
#
#    location ~ \.php$ {
#        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
#        fastcgi_index index.php;
#        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
#        include fastcgi_params;
#    }
#
#    location ~ /\.(?!well-known).* {
#        deny all;
#    }
#}

sudo ln -s /etc/nginx/sites-available/naposao /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx

#removed all projects from /var/www folder

#Git installation
sudo apt-get install git
sudo git clone https://github.com/xeac/naposao.git

sudo chown -R www-data.www-data /var/www/naposao/storage
sudo chown -R www-data.www-data /var/www/naposao/bootstrap/cache

#Continue with Database migration
sudo mysql
CREATE DATABASE naposaor_posao;
GRANT ALL ON *.* to 'xeac'@'%' IDENTIFIED BY 'PassWord12!@' WITH GRANT OPTION;
GRANT ALL ON *.* to 'naposaor_admin'@'%' IDENTIFIED BY 'PassWord12!@' WITH GRANT OPTION;
flush privileges;
exit

/etc/mysql/mysql.conf.d/mysqld.cnf # remove bind address
sudo /etc/init.d/mysql restart

#Import dump database into naposaor_posao DB;
#Site ready
