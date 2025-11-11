#!/bin/bash
set -e

# --- Variables de configuration du serveur ---
STEAMCMD_BIN="/home/steam/steamcmd/steamcmd.sh" 
SERVER_DIR="/home/steam/necesse_server"
NECESSE_APPID="1169370"

echo "=========================================="
echo "      Serveur Necesse Démarrage Final      "
echo "=========================================="

# 1. Mise à jour/Installation du serveur
echo "-> Vérification et mise à jour du serveur Necesse (AppID: $NECESSE_APPID)..."

# CORRECTION : Si le répertoire est vide (cas du premier lancement avec volume), 
# SteamCMD doit installer les fichiers, sinon il ne les téléchargera jamais.
if [ ! -f "${SERVER_DIR}/StartServer-nogui.sh" ]; then
    echo "-> Fichiers de jeu manquants. Forcer l'installation..."
    # 'validate' force la vérification complète, essentiel ici.
    "${STEAMCMD_BIN}" +force_install_dir "${SERVER_DIR}" +login anonymous +app_update ${NECESSE_APPID} validate +quit
else
    # Si le fichier est présent, faire une simple mise à jour.
    "${STEAMCMD_BIN}" +force_install_dir "${SERVER_DIR}" +login anonymous +app_update ${NECESSE_APPID} +quit
fi

echo "-> Mise à jour terminée."

# 2. Lancement du Serveur
echo "-> Lancement du serveur Necesse via StartServer-nogui.sh..."

cd "${SERVER_DIR}"

# --- Débogage : Liste des fichiers (Doit maintenant contenir les fichiers !) ---
echo "--- Débogage : Liste des fichiers dans $(pwd) (DOIT ÊTRE NON-VIDE) ---"
ls -la
echo "------------------------------------------------"

# Conversion du format de fin de ligne et assurance des droits
echo "-> Correction du format de fichier (dos2unix) et des droits..."
chmod +x StartServer-nogui.sh

# Exécuter le script de démarrage
exec bash StartServer-nogui.sh "$@"