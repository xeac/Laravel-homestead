# Once Ubuntu VM is ready and you are logged in, execute the following comands:


sudo usermod -aG sudo $(whoami)

sudo ufw allow OpenSSH
sudo ufw allow SSH
sudo ufw allow 'Nginx HTTP'
sudo ufw enable

sudo 


install php7.2-cli
sudo apt install php7.2
sudo apt-get install php7.2-zip
sudo apt install python-softlayer
sudo apt-get install php7.2-xml php7.2-
php7.2-mysql php7.2-json php7.2-curl php7.2-common php7.2-zip libapache2-mod-php7.2
sudo apt install php-mbstring php-xml php-bcmath
sudo apt install mysql-server
sudo mysql_secure_installation
sudo apt install php-mbstring php-xml php-bcmath
sudo apt install nginx
sudo ufw allow 'Nginx HTTP'
sudo apt install php-fpm php-mysql
sudo apt-get install php7.2-gd
sudo apt-get install php-curl
sudo apt-get update
sudo service apache2 restart

sudo apt update
sudo apt upgrade

# sudo nano /etc/nginx/sites-available/$site 

#server {
#        listen 80;
#        root /var/www/html;
#        index index.php index.html index.htm index.nginx-debian.html;
#        server_name 40.85.97.11;
#
#        location / {
#                try_files $uri $uri/ =404;
#        }
#
#        location ~ \.php$ {
#                include snippets/fastcgi-php.conf;
#                fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
#        }
#
#        location ~ /\.ht {
#                deny all;
#        }
#}

# sudo ln -s /etc/nginx/sites-available/naposao.rs /etc/nginx/sites-enabled/
sudo unlink /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx


# Install and Use Composer
sudo apt update
sudo apt install curl php-cli php-mbstring git unzip
cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
composer require illuminate/html
composer update
sudo chown -R $USER ~/.composer/


#Create Laravel new Project
composer create-project --prefer-dist laravel/laravel $Project_name


# Configuring Laravel
nano .env

APP_NAME=$Project_name
APP_ENV=development
APP_KEY=APPLICATION_UNIQUE_KEY_DONT_COPY
APP_DEBUG=true
APP_URL=http://domain_or_IP

LOG_CHANNEL=stack

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=travel_list
DB_USERNAME=travel_user
DB_PASSWORD=password

sudo mv ~/$Project_name /var/www/$Project_name
sudo chown -R www-data.www-data /var/www/$Project_name/storage
sudo chown -R www-data.www-data /var/www/$Project_name/bootstrap/cache
sudo nano /etc/nginx/sites-available/$Project_name

server {
    listen 80;
    server_name $IP ADDRESS;         
    root /var/www/$Project_name/public;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-XSS-Protection "1; mode=block";
    add_header X-Content-Type-Options "nosniff";

    index index.html index.htm index.php;

    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    error_page 404 /index.php;

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}

sudo ln -s /etc/nginx/sites-available/$Project_name /etc/nginx/sites-enabled/
sudo systemctl reload nginx
