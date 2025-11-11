#!/bin/bash
set -e

# Ajusté au chemin courant dans l'image cm2network/steamcmd
STEAMCMD_BIN="/home/steam/steamcmd/steamcmd.sh" 
SERVER_DIR="/home/steam/necesse_server"
NECESSE_APPID="1169370"

# Le nom du fichier JAR pour le serveur Necesse (basé sur la documentation)
NECESSE_JAR="NecesseServer.jar"

echo "=========================================="
echo "         Serveur Necesse Démarrage         "
echo "=========================================="

# 1. Mise à jour du serveur
echo "-> Vérification et mise à jour du serveur Necesse (AppID: $NECESSE_APPID)..."

"${STEAMCMD_BIN}" +force_install_dir "${SERVER_DIR}" +login anonymous +app_update "${NECESSE_APPID}" +quit

echo "-> Mise à jour terminée."

# 2. Lancement du Serveur
echo "-> Lancement du serveur Necesse..."

cd "${SERVER_DIR}"

# Utiliser exec java -jar pour lancer le serveur
# Nous supposons que le fichier NecesseServer.jar est bien à la racine du dossier d'installation
# et que Java est maintenant installé.
exec java -Xms512m -Xmx2048m -jar "${NECESSE_JAR}" "$@"
# -Xms et -Xmx définissent la RAM min et max allouée à Java (ajustez 512m/2048m selon vos besoins)