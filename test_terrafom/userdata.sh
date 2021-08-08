#!/bin/bash
sudo apt-get update
sudo apt-get install apache2 -y
sudo cp /tmp/index.html /var/www/html/index.html
sudo chmod 755 /var/www/index.html
sudo service apache2 restart