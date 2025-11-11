#!/bin/bash
set -e

# --- Variables de configuration du serveur ---
STEAMCMD_BIN="/home/steam/steamcmd/steamcmd.sh" 
SERVER_DIR="/home/steam/necesse_server"
NECESSE_APPID="1169370"
NECESSE_JAR="Server.jar"

echo "=========================================="
echo "      Serveur Necesse Démarrage Unifié     "
echo "=========================================="

# 1. Mise à jour du serveur
echo "-> Vérification et mise à jour du serveur Necesse (AppID: $NECESSE_APPID)..."

# La commande SteamCMD pour mettre à jour
"${STEAMCMD_BIN}" +force_install_dir "${SERVER_DIR}" +login anonymous +app_update "${NECESSE_APPID}" +quit

echo "-> Mise à jour terminée."

# 2. Lancement du Serveur
echo "-> Lancement du serveur Necesse (via Java)..."

cd "${SERVER_DIR}"

# Utiliser exec java -jar pour lancer le serveur
# -Xms et -Xmx définissent la RAM min et max allouée à Java (ajustez 512m/2048m selon vos besoins)
# -XX:+ExitOnOutOfMemoryError garantit l'arrêt propre en cas de manque de RAM.
# "$@" passe tous les arguments reçus par le conteneur (via docker compose command:) au processus Java.
exec java -Xms512m -Xmx2048m \
            -XX:+ExitOnOutOfMemoryError \
            -jar "${NECESSE_JAR}" "$@"