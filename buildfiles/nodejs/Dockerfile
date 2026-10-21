# Use the official Node.js image
# FROM node:18.20
FROM andiaryanto11/andik-node:20

# Install OpenAI Codex CLI so the mounted /root/.codex session is usable.
RUN npm install -g @openai/codex

#copy idrsa
COPY config/sshkey/config /root/.ssh/config
COPY config/sshkey/id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Set the working directory (optional)
WORKDIR /projects

# Expose a range of ports for development (optional)
EXPOSE 3001-3005

# Default command (keep the container running)
CMD ["tail", "-f", "/dev/null"]
