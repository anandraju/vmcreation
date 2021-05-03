#!/bin/bash
set -x
USER_ID="testadmin"

#UPDATE
#=======
sudo apt update


#install all of pyenv’s OR other binary dependencies:
#====================================================
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

sudo git init

git clone https://github.com/pyenv/pyenv.git /home/${USER_ID}/.pyenv
#read
/bin/echo 'export PYENV_ROOT="$HOME/.pyenv"' >> /home/${USER_ID}/.bashrc
/bin/echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> /home/${USER_ID}/.bashrc
/bin/echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> /home/${USER_ID}/.bashrc
source /home/${USER_ID}/.bashrc

sudo /home/${USER_ID}/.pyenv/bin/pyenv install 3.7.9
#/home/${USER_ID}/.pyenv/bin/pyenv versions


#Install PIP
#===========
sudo apt install -y python-pip


#Install Az Cli
#==============
sudo apt update
sudo apt install -y ca-certificates curl apt-transport-https lsb-release gnupg
curl -sL https://packages.microsoft.com/keys/microsoft.asc |     gpg --dearmor |     sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
curl -sL https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt update
sudo apt install -y azure-cli
###

#INSTALL AZURE-CORE
#==================
pip install --upgrade --force-reinstall azure-core

##

#INSTALL DOCKER COMPOSE
#======================
sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
###

#TOOLS
#======
mkdir /home/${USER_ID}/_tools && cd /home/${USER_ID}/_tools
sudo ln -s /usr/bin/pip /home/${USER_ID}/_tools/
sudo ln -s /usr/bin/python /home/${USER_ID}/_tools/
sudo ln -s /home/testadmin/.pyenv/versions/3.7.9/bin/python3.7  /home/${USER_ID}/_tools/

#CREATING DIRECTORIES
#=======================================
mkdir -p /home/${USER_ID}/myagent/_work/ && cd /home/${USER_ID}/myagent/_work/
mkdir -p /home/${USER_ID}/myagent/_work/_tool/Python/3.7.9/x64 && cd /home/${USER_ID}/myagent/_work/_tool/Python/3.7.9/
touch x64.complete

#CREATE SYMLINKS
#================
cd /home/${USER_ID}/myagent/_work/_tool/Python/3.7.9/x64
sudo ln -s /home/testadmin/.pyenv/versions/3.7.9/bin/python3.7 /home/${USER_ID}/myagent/_work/_tool/Python/3.7.9/x64/python
sudo ln -s /usr/bin/pip /home/${USER_ID}/myagent/_work/_tool/Python/3.7.9/x64/pip

echo "#INSTALLED PACKAGES"
echo "#=================="
pyenv versions
pip --version
az --version
docker --version
docker-compose --version
/home/testadmin/.pyenv/versions/3.7.9/bin/python3.7 --version

#end#

