# Use the official Node.js image
# FROM node:18.20
FROM andiaryanto11/node:24.22.1

# Install OpenAI Codex CLI so the mounted ~/.codex session is usable.
RUN npm install -g @openai/codex

# This image must ship the "node" user baked into the official node:* base
# image (uid/gid 1000); fail the build loudly if a custom base ever drops it.
RUN id node

#copy idrsa into the "node" user's home; the whole container runs as "node"
#(see docker-compose user:), so Codex/Claude/git use this home, not root's
RUN mkdir -p /home/node/.ssh /home/node/.codex /home/node/.claude \
    && chown node:node /home/node/.ssh /home/node/.codex /home/node/.claude \
    && chmod 700 /home/node/.ssh
COPY --chown=node:node config/sshkey/config /home/node/.ssh/config
COPY --chown=node:node config/sshkey/id_rsa /home/node/.ssh/id_rsa
RUN chmod 600 /home/node/.ssh/id_rsa

# Set the working directory (optional); owned by "node" so a fresh "node"
# volume mounted here is writable by the non-root user
RUN mkdir -p /projects && chown node:node /projects
WORKDIR /projects

# Expose a range of ports for development (optional)
EXPOSE 3001-3005

# Default command (keep the container running)
CMD ["tail", "-f", "/dev/null"]
