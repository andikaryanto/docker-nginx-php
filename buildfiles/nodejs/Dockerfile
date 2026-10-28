# Use the official Node.js image
# FROM node:18.20
FROM andiaryanto11/node:24.22.1

# Install OpenAI Codex CLI so the mounted ~/.codex session is usable.
RUN npm install -g @openai/codex

# This image must ship the "node" user baked into the official node:* base
# image (uid/gid 1000); fail the build loudly if a custom base ever drops it.
RUN id node

# util-linux provides setpriv, used below to drop Codex from root to "node".
RUN apt-get update && apt-get install -y --no-install-recommends util-linux \
    && rm -rf /var/lib/apt/lists/*

# Run Codex as the non-root "node" user (not root) so files it writes into
# the host-mounted .codex volume keep the host user's ownership instead of
# root's.
RUN real="$(command -v codex)" \
    && mv "$real" "${real}-real" \
    && printf '#!/bin/sh\nexport HOME=/home/node USER=node\nexec setpriv --reuid=node --regid=node --init-groups "%s-real" "$@"\n' "$real" > "$real" \
    && chmod +x "$real"

#copy idrsa into the "node" user's home, since Codex/Claude/git now run as
#that user instead of root
RUN mkdir -p /home/node/.ssh /home/node/.codex /home/node/.claude \
    && chown node:node /home/node/.ssh /home/node/.codex /home/node/.claude \
    && chmod 700 /home/node/.ssh
COPY --chown=node:node config/sshkey/config /home/node/.ssh/config
COPY --chown=node:node config/sshkey/id_rsa /home/node/.ssh/id_rsa
RUN chmod 600 /home/node/.ssh/id_rsa

# Set the working directory (optional)
WORKDIR /projects

# Expose a range of ports for development (optional)
EXPOSE 3001-3005

# Default command (keep the container running)
CMD ["tail", "-f", "/dev/null"]
