#!/bin/bash

cmd="install"
description="Inilitialiser le projet en lançant toutes les commandes."
author="Gtko"

source $UTILS_DIR/functions.sh

# create .env
print_message "Créer le .env a partir du .env-example" "📦"
cp $WORKSPACE_DIR/.env-example $WORKSPACE_DIR/.env

# Exécuter les commandes avec des barres de progression
print_message "Installation des dépendances Composer" "📦"
composer install

complete "Initialisation terminé !"
