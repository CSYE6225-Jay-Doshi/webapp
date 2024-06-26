#!/bin/sh
sudo apt-get update
sudo apt-get upgrade -y
sudo apt install unzip
sudo apt install nodejs npm -y
sudo wget https://amazoncloudwatch-agent.s3.amazonaws.com/debian/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb

sudo groupadd "$APPLICATION_USER"
sudo useradd -s /bin/false -g "$APPLICATION_USER" -d "/opt/$APPLICATION_USER" -m "$APPLICATION_USER"
sudo mv /home/admin/webapp.zip "/opt/$APPLICATION_USER/webapp.zip"
sudo mv /home/admin/users.csv "/opt/$APPLICATION_USER/users.csv"
sudo mv /home/admin/config.json "/opt/$APPLICATION_USER/config.json"
cd "/opt/$APPLICATION_USER"
sudo unzip -o webapp.zip
sudo chown -R "$APPLICATION_USER" "/opt/$APPLICATION_USER"
sudo chgrp -R "$APPLICATION_USER" "/opt/$APPLICATION_USER"
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c "file:/opt/$APPLICATION_USER/config.json" -s
cd "/opt/$APPLICATION_USER"
sudo npm i

sudo cp /home/admin/application.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable application.service
sudo systemctl start application.service



sudo systemctl enable amazon-cloudwatch-agent
sudo systemctl start amazon-cloudwatch-agent