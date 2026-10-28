FROM node:20-bookworm

# Basic packages often needed in JS/mobile dev containers
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    unzip \
    openssh-client \
    ca-certificates \
    bash \
    procps \
    net-tools \
    iputils-ping \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# This image must ship the "node" user baked into the official node:* base
# image (uid/gid 1000); fail the build loudly if a custom base ever drops it.
RUN id node

# Optional but useful for cleaner shell history / color output
# SSH key lives under the non-root "node" user's home (matching the
# host-mounted .codex volume), not root's
RUN mkdir -p /home/node/.ssh /home/node/.codex \
    && chown node:node /home/node/.ssh /home/node/.codex \
    && chmod 700 /home/node/.ssh
COPY --chown=node:node config/sshkey/id_rsa /home/node/.ssh/id_rsa
RUN chmod 600 /home/node/.ssh/id_rsa
ENV TERM=xterm-256color

# Expo / Metro friendly defaults
ENV NODE_ENV=development
ENV CI=0
ENV EXPO_NO_TELEMETRY=1
ENV CHOKIDAR_USEPOLLING=true
ENV WATCHPACK_POLLING=true

WORKDIR /app

# Expo / Metro / web ports commonly used
EXPOSE 8081 19000 19001 19002

# Keep image generic; actual start command is in docker-compose
CMD ["bash"]