# Once Ubuntu VM is ready and you are logged in, execute the following comands:


sudo usermod -aG sudo $(whoami)

sudo ufw allow OpenSSH
sudo ufw allow SSH
sudo ufw allow 'Nginx HTTP'
sudo ufw enable

sudo apt install php7.2-cli
sudo apt install php7.2
sudo apt-get install php7.2-zip
sudo apt install python-softlayer
sudo apt-get install php7.2-xml php7.2-mbstring php7.2-mysql php7.2-json php7.2-curl php7.2-common php7.2-zip libapache2-mod-php7.2
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
composer update
composer require illuminate/html
sudo mv composer.phar /usr/local/bin/composer
sudo chown -R $USER ~/.composer/



composer global require laravel/installer
