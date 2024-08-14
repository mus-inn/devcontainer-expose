#!/bin/bash

# Titre et description du script
cmd="Serve"
description="Serveur expose !"
author="Gtko"

source $UTILS_DIR/functions.sh

# Exécuter les commandes avec des barres de progression
print_message "Lancement du serveur" "📦"
php expose serve --validateAuthTokens
