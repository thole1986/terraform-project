#!/bin/bash
#!/bin/bash
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

# install nginx
apt-get update -y
apt-get -y install nginx
# make sure nginx is started
service nginx start
echo "Hello POC Team 01 and IMS Team" > /var/www/html/index.html