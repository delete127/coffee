#!/bin/bash
apt update && apt install -y nginx 
echo "custome page" > /var/www/html/index.nginx-debian.html
service restart nginx
