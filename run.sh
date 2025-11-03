#!/bin/bash
set -e

# Ajusté au chemin courant dans l'image cm2network/steamcmd
STEAMCMD_BIN="/home/steam/steamcmd/steamcmd.sh" 
SERVER_DIR="/home/steam/necesse_server"
NECESSE_APPID="1169370"

echo "=========================================="
echo "         Serveur Necesse Démarrage         "
echo "=========================================="

# 1. Mise à jour du serveur
echo "-> Vérification et mise à jour du serveur Necesse (AppID: $NECESSE_APPID)..."

# Mise à jour avec la connexion anonyme
"${STEAMCMD_BIN}" +force_install_dir "${SERVER_DIR}" +login anonymous +app_update "${NECESSE_APPID}" +quit

echo "-> Mise à jour terminée."

# 2. Lancement du Serveur
echo "-> Lancement du serveur Necesse..."

cd "${SERVER_DIR}"

# IMPORTANT : Confirmez le véritable binaire de lancement sur Linux pour Necesse.
# Cela suppose que le script StartServer.sh existe et est exécutable.
exec bash StartServer.sh 
# Alternative courante pour Java : exec java -jar NecesseServer.jar