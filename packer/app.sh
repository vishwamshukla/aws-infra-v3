#!/bin/bash

sleep 30

sudo yum update -y

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
. ~/.nvm/nvm.sh

nvm install 16

# sudo yum install -y git

# git clone https://github.com/vishwam-prod/webapp.git

# git clone https://${GITHUB_USERNAME}:${GITHUB_TOKEN}git@github.com:vishwam-prod/webapp.git

# mkdir ~/.ssh
# chmod 700 ~/.ssh

# cp /Users/vishwamshukla/Desktop/aws-infra/packer/key.pub ~/.ssh/id_rsa
# chmod 600 ~/.ssh/id_rsa

# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_rsa

# eval `ssh-agent -s`
# ssh-add ./key.pub
# ssh-keyscan github.com >> ~/.ssh/known_hosts





# git clone https://:@github.com/vishwam-prod/webapp.git


# ssh-keyscan github.com >> /home/ec2-user/.ssh/known_hosts
# eval `ssh-agent`
# ssh-agent bash -c \
# 'ssh-add /home/ec2-user/.ssh/; git clone git@github.com:vishwam-prod/webapp.git'

# ssh-keyscan github.com >> /home/ec2-user/.ssh/known_hosts
# eval `ssh-agent`
# ssh-agent bash -c \
# 'ssh-add /home/ec2-user/.ssh/key.pub; git clone git@github.com:vishwam-prod/webapp.git'

npm install pm2 -g

npm install express

npm install --save pg




sudo yum install unzip -y
cd ~/ && unzip webapp.zip

cd ~/webapp && npm i --only=prod

npm uninstall bcrypt
npm install bcrypt


pm2 start server.js
pm2 startup systemd
sudo env PATH=$PATH:/home/ec2-user/.nvm/versions/node/v16.19.1/bin /home/ec2-user/.nvm/versions/node/v16.19.1/lib/node_modules/pm2/bin/pm2 startup systemd -u ec2-user --hp /home/ec2-user
pm2 save
pm2 link



#pm2 save
#pm2 list


# sudo mv /tmp/webapp.service /etc/systemd/system/webapp.service

# sudo systemctl enable webapp.service
# sudo systemctl start webapp.service





# sudo yum install git

# nvm install 16

# nvm use 16

# sudo yum install npm
# sudo npm install pm2 -g

# # npm install pm2 -g

# sudo yum install unzip -y
# cd ~/ && unzip webapp.zip

# cd ~/webapp && npm i --only=prod

# pm2 start server.js
# pm2 startup
# pm2 save