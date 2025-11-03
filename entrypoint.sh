#!/bin/bash
set -e

# Ce script appelle run.sh, qui gère la mise à jour SteamCMD et le lancement du serveur.
# 'exec' garantit que le processus run.sh remplace le shell, permettant à Docker
# de gérer correctement les signaux d'arrêt (ex: CTRL+C ou docker stop).

exec /usr/local/bin/run.sh "$@"