#!/bin/bash
set -e

# --- Variables de configuration du serveur ---
STEAMCMD_BIN="/home/steam/steamcmd/steamcmd.sh" 
SERVER_DIR="/home/steam/necesse_server/"
NECESSE_APPID="1169370"
# NecesseServer.jar n'est plus utilisé directement, mais nous gardons les chemins.

echo "=========================================="
echo "      Serveur Necesse Démarrage Final      "
echo "=========================================="

# 1. Mise à jour du serveur
echo "-> Vérification et mise à jour du serveur Necesse (AppID: $NECESSE_APPID)..."

"${STEAMCMD_BIN}" +force_install_dir "${SERVER_DIR}" +login anonymous +app_update "${NECESSE_APPID}" +quit

echo "-> Mise à jour terminée."

# 2. Lancement du Serveur
echo "-> Lancement du serveur Necesse via StartServer-nogui.sh..."

# Se positionner dans le répertoire pour que le script trouve correctement son JRE interne et ses dépendances
cd "${SERVER_DIR}"
# --- ÉTAPE DE DÉBOGAGE : Vérification du répertoire ---
echo "--- Débogage : Liste des fichiers dans $(pwd) ---"
ls -la
echo "------------------------------------------------"

chmod +x StartServer-nogui.sh

# Exécuter le script de démarrage fourni par le jeu.
# "$@" passe tous les arguments reçus (via docker compose command:) au script StartServer-nogui.sh.
exec bash StartServer-nogui.sh "$@"