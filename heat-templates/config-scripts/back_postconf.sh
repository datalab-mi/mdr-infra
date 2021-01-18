#!/bin/bash
#export no_proxy=$no_proxy
# deb http://depot-vip-sir.dtct.minint.fr/docker-debian stretch stable
# deb http://depot-vip-sir.dtct.minint.fr/elastic6 stable main

echo "# RUNNING: $(dirname $0)/$(basename $0)"
set -xe -o pipefail
function clean() {
[ "$?" -gt 0 ] && notify_failure "Deploy $0: $?"
}
trap clean EXIT QUIT KILL

HOME=/home/debian
export HOME
libdir=/home/debian

[ -f ${libdir}/common_functions.sh ] && source ${libdir}/common_functions.sh

apt-get -q update
apt-get -qy install curl
apt-get -y install git
apt-get -qy install python-pip
apt-get -qy install python3-venv
#pip install python-swiftclient

echo "## ajout debian au groupe docker"
usermod -aG docker debian

# ssh, use OpenStack Nova key_name instead
#echo '$ssh_authorized_keys' >> $HOME/.ssh/authorized_keys
#chown debian -R $HOME/.ssh
#chmod 700 $HOME/.ssh -R

systemctl daemon-reload
systemctl restart docker
####################### INSTALL DOCKER COMPOSE #################################
curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
#Test the installation.
docker-compose --version
