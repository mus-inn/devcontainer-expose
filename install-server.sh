#!/bin/bash

# Variables
APP_DIR="/var/www/expose"

sudo rm -rf $APP_DIR
sudo mkdir -p $APP_DIR
sudo chmod 777 $APP_DIR


# Mise à jour de la liste des paquets
sudo apt update

# Liste des versions de PHP installées
php_versions=$(dpkg --get-selections | grep -oP '^php[0-9.]+(?=\s+install)' | sort -u)

# Conservez uniquement PHP 8.1
for version in $php_versions; do
    echo "Suppression de $version et des paquets associés..."
    sudo apt-get remove --purge -y $version*
done

# Suppression des paquets résiduels et des fichiers de configuration
sudo apt-get autoremove -y
sudo apt-get autoclean

# Fin du script
echo "Toutes les versions de PHP ont été supprimées."

# Installation des dépendances nécessaires
sudo apt install -y software-properties-common apt-transport-https ca-certificates curl

# Ajouter le repository pour PHP 8.1
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update

echo "Installation de PHP 8.1 et des extensions courantes..."

# Installer PHP 8.1 et les extensions courantes
sudo apt install -y php8.1-cli php8.1-mbstring php8.1-xml php8.1-bcmath php8.1-sqlite3 curl git unzip


echo "Installation de Composer et Caddy..."

# Installation de Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Installation de Caddy
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/caddy-stable-archive-keyring.gpg] https://dl.cloudsmith.io/public/caddy/stable/deb/debian any-version main" | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install -y caddy

# Configurer Caddy pour démarrer automatiquement
sudo systemctl enable caddy
sudo systemctl start caddy

# Cloner votre projet Laravel Zero (ou le préparer)
cd $APP_DIR
git clone https://github.com/mus-inn/devcontainer-expose.git .

# Installation des dépendances de l'application Laravel Zero
composer install --optimize-autoloader --no-dev

#create sqlite database
mkdir /home/ubuntu/.expose
touch /home/ubuntu/.expose/expose.db

# Fin du script
echo "Installation terminée. L'environnement pour Laravel Zero avec PHP 8.1 est prêt sur l'instance EC2."
