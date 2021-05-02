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

git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
#read
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> ~/.bashrc
source $HOME/.bashrc
#read
#exec "$SHELL"
#source $HOME/.bashrc
#Reinstalling on the same machine second time
#rm -rvf ~/.pyenv/versions/3.7.9
####
source $HOME/.bashrc
sudo ln -s /home/${USER_ID}/.pyenv/bin/pyenv /usr/local/bin
pyenv install 3.7.9
pyenv versions
#read
#exec "$SHELL"
#pyenv global
pyenv global 3.7.9
#read

#Install PIP
#===========
sudo apt-get install -y python-pip
pip --version


#Install Az Cli
#==============
#curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
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
az --version
###

#INSTALL AZURE-CORE
#==================
pip install --upgrade --force-reinstall azure-core

#INSTALL DOCKER
#==============
sudo apt-get purge -y docker lxc-docker docker-engine docker.io
sudo apt-get install -y curl apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
#read
sudo systemctl enable docker
# Linux post-install
sudo groupadd docker
sudo usermod -aG docker ${USER_ID}
docker info

###

#INSTALL DOCKER COMPOSE
#======================
sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
###

#TOOLS
#======
mkdir /home/${USER_ID}/_tools && cd /home/${USER_ID}/_tools
sudo ln -s /usr/bin/pip /home/${USER_ID}/_tools/
sudo ln -s /usr/bin/python /home/${USER_ID}/_tools/
sudo ln -s /usr/bin/python3.6 /home/${USER_ID}/_tools/

#CREATING DIRECTORIES
#=======================================
mkdir -p /home/${USER_ID}/myagent/_work/ && cd /home/${USER_ID}/myagent/_work/
mkdir -p /home/${USER_ID}/myagent/_work/_tool/Python/3.7.9/x64 && cd /home/${USER_ID}/myagent/_work/_tool/Python/3.7.9/
touch x64.complete

#CREATE SYMLINKS
#================
cd /home/${USER_ID}/myagent/_work/_tool/Python/3.7.9/x64
sudo ln -s /home/ubuntu/.pyenv/versions/3.7.9/bin/python3.7 /home/${USER_ID}/myagent/_work/_tool/Python/3.7.9/x64/python
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

# cd /home/${USER_ID}/myagent/_work/_tool/
# sudo ln -s $HOME/.pyenv/bin/pyenv /home/${USER_ID}/myagent/_work/_tool/pyenv
# sudo ln -s /usr/bin/pip /home/${USER_ID}/myagent/_work/_tool/pip
# sudo ln -s /usr/bin/docker /home/${USER_ID}/myagent/_work/_tool/docker
# sudo ln -s /usr/local/bin/docker-compose /home/${USER_ID}/myagent/_work/_tool/docker-compose

