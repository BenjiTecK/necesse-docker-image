#!/bin/bash

STEAMCMD_BIN="/home/steam/steamcmd/steamcmd.sh"
SERVER_DIR="/home/steam/necesse_server"
NECESSE_APPID="1169370"

# Mettre à jour le serveur au démarrage du conteneur (pour s'assurer d'avoir la dernière version)
echo "Mise à jour du serveur Necesse..."
"${STEAMCMD_BIN}" +force_install_dir "${SERVER_DIR}" +login anonymous +app_update "${NECESSE_APPID}" +quit

# Lancer le serveur Necesse (ajustez la commande de lancement si nécessaire)
# Le script de lancement dépend de la façon dont Necesse gère son lancement sur Linux. 
# Si Necesse utilise un JAR, la commande sera de type :
# java -jar "${SERVER_DIR}/NecesseServer.jar" -port 14100 -etc... 
# Sinon, utilisez le binaire de lancement fourni.
echo "Lancement du serveur Necesse..."

# **IMPORTANT** : Cette commande peut nécessiter d'être ajustée en fonction du véritable binaire de lancement de Necesse sur Linux.
# Exemples courants : ./StartServer.sh, java -jar <fichier>.jar
cd "${SERVER_DIR}"
exec bash StartServer.sh # Remplacez par la commande de lancement correcte si différente