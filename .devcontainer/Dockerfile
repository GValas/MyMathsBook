# Image de base : TeX Live complète (Debian)
FROM texlive/texlive:latest-full

ARG USERNAME=vscode
# 1000 est déjà utilisé par l'utilisateur "texlive" de l'image de base
ARG USER_UID=1001
ARG USER_GID=${USER_UID}

# Outils système, dont git (installé ici plutôt que via une feature devcontainer)
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      git ca-certificates curl sudo zsh \
 && rm -rf /var/lib/apt/lists/*

# Utilisateur non-root + sudo sans mot de passe (requis par le postStartCommand : chown)
RUN groupadd --gid ${USER_GID} ${USERNAME} \
 && useradd  --uid ${USER_UID} --gid ${USER_GID} --create-home --shell /bin/bash ${USERNAME} \
 && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
 && chmod 0440 /etc/sudoers.d/${USERNAME}

# Claude Code : outil par-utilisateur, installé dans le home de ${USERNAME}
# (le launcher va dans ~/.local/bin et l'outil se met à jour tout seul dans ~/.claude)
USER ${USERNAME}
ENV HOME=/home/${USERNAME}
ENV PATH="/home/${USERNAME}/.local/bin:${PATH}"
RUN curl -fsSL https://claude.ai/install.sh | bash
