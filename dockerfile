# 1. Image de base SteamCMD
FROM cm2network/steamcmd:latest

ENV SERVER_DIR="/home/steam/necesse_server" \
    NECESSE_APPID="1169370"

# Revenir à ROOT pour la gestion des utilisateurs et permissions
USER root

# 2. Gestion de l'utilisateur (maintenue pour corriger l'erreur 'steam user not found')
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        # Suppression de openjdk-17-jre-headless
        adduser \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Garantie de l'existence de l'utilisateur 'steam' (UID 1000)
RUN if ! id "steam" >/dev/null 2>&1; then \
        adduser --system --uid 1000 --gid 1000 --shell /bin/bash --disabled-password --home /home/steam steam; \
    fi \
    && chown -R 1000:1000 /home/steam

# 3. Installation Initiale du Serveur Necesse
USER steam 
RUN mkdir -p ${SERVER_DIR} \
    && /home/steam/steamcmd/steamcmd.sh +force_install_dir ${SERVER_DIR} +login anonymous +app_update ${NECESSE_APPID} validate +quit

# 4. Ajout et Permissions du script
USER root
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh \
    && chown steam:steam /usr/local/bin/entrypoint.sh

# 5. Configuration finale du conteneur
USER steam 

EXPOSE 14100/tcp
EXPOSE 14100/udp

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]