#!/bin/bash

# variables
domain=prometheus.mindheartsoul.org
site=mhs_prometheus

echo "Installer for 'Graph-HTTP SSL proxy' on 'Ubuntu 18.04'"
echo "WARNING : unpolished code !!  (Requires manual copy paste from external config flies.)"
read -p "Press any key to continue or CTRL+C to abort"

# CHECK root
if ! [ $(id -u) = 0 ]; then
   echo "Script must be run as root / sudo."
   exit 1
fi

# packages
apt-get install -y apache2 dnsutils
echo "On some servers apache2 automatically installs ufw, which might conflict with other firewalls if you installed any, choose Y/n on the removal accordingly."
apt-get purge ufw

# apache2
cd /etc/apache2/
mkdir logs
echo "paste from file"
nano conf-available/LetsEncrypt.conf

mkdir -p  /var/www/all_LetsEncrypt/.well-known/acme-challenge/
a2enconf LetsEncrypt

echo "paste from file"
nano sites-available/000-default.conf

# prepare for getting ssl certificate
a2enmod rewrite
systemctl restart apache2
echo "Don't forget to add ports 80 & 443 to firewall exceptions."
read -p "Press any key to continue or CTRL+C to abort"

# getssl
curl --silent https://raw.githubusercontent.com/srvrco/getssl/master/getssl > getssl ; chmod 700 getssl
./getssl -c $domain
echo "Adjust staging->real & reload cmd"
nano ~/.getssl/getssl.cfg
echo "Adjust SANS, ACL, singleACL & locations"
nano /home/seed/.getssl/$domain/getssl.cfg

./getssl $domain

# vhosts
echo "paste from file"
nano /etc/apache2/sites-available/$site.conf
a2ensite $site
a2enmod headers
a2enmod ssl
a2enmod proxy
a2enmod proxy_http

systemctl restart apache2
