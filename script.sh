#!/bin/bash
set -x
#Update and Install Dependencies
sudo apt update


#install all of pyenv’s dependencies:
#====================================
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

#sudo git init

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
#read
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
#read
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
#read
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> ~/.bashrc
source $HOME/.bashrc
#exec "$SHELL"
#source $HOME/.bashrc
#Reinstalling on the same machine second time
#rm -rvf ~/.pyenv/versions/3.7.9
####
source $HOME/.bashrc

pyenv install 3.7.9
pyenv versions
#exec "$SHELL"
#pyenv global
pyenv global 3.7.9
#read
#Install PIP
#===========
sudo apt install -y python3-pip
pip3 --version

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

#INSTALL DOCKER
#==============
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get install -y docker-ce
sudo systemctl enable docker
# Linux post-install
sudo usermod -aG docker ${USER}
docker info
###

#INSTALL DOCKER COMPOSE
#======================
sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
###

mkdir ~/_tool && cd _tool
pyenv local 3.7.9
pyenv versions

#CREATING SYMLINKS UNDER _tool DIRECTORY
#=======================================
mkdir -p ~/myagent/_work/_tool/Python/3.7.9/x64
cd mkdir -p ~/myagent/_work/_tool/Python/3.7.9
touch x64.complete
ls -rtl x64.complete

cd ~/myagent/_work/_tool/Python/3.7.9/x64
sudo ln -s $HOME/.pyenv/shims/pip3.7 pip3.7
sudo ln -s /usr/lib/python3.7 python3.7

cd ~/myagent/_work/_tool/
sudo ln -s $HOME/.pyenv/bin/pyenv pyenv
sudo ln -s $HOME/.pyenv/shims/pip3.7 pip3.7
sudo ln -s /usr/bin/docker docker
sudo ln -s /usr/local/bin/docker-compose docker-compose

