# 1. Image de base SteamCMD
FROM cm2network/steamcmd:latest

ENV SERVER_DIR="/home/steam/necesse_server" \
    NECESSE_APPID="1169370"

# Revenir à ROOT pour l'installation de Java et le CHMOD
USER root

# 2. Installation de Java
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        openjdk-17-jre-headless \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 3. Installation Initiale du Serveur Necesse
# Repasser à l'utilisateur non-root avant l'installation du jeu
USER steam 
RUN mkdir -p ${SERVER_DIR} \
    && /home/steam/steamcmd/steamcmd.sh +force_install_dir ${SERVER_DIR} +login anonymous +app_update ${NECESSE_APPID} validate +quit

# 4. Ajout des scripts d'exécution
# Le COPY peut se faire avant ou après le passage à root, mais le CHMOD doit être en root.
USER root
COPY entrypoint.sh run.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh /usr/local/bin/run.sh

# 5. Configuration finale du conteneur
USER steam # IMPORTANT : Retourner à l'utilisateur non-root pour l'exécution finale

EXPOSE 14100/tcp
EXPOSE 14100/udp

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
