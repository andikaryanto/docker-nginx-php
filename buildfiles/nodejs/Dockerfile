# Use the official Node.js image
# FROM node:18.20
FROM node:20

# Install Git
RUN apt-get update -o Acquire::Check-Valid-Until=false && apt-get install -y git curl && apt-get clean

#copy idrsa
COPY config/sshkey/id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Install Composer (needs PHP CLI)
RUN apt-get update -o Acquire::Check-Valid-Until=false && apt-get install -y php-cli && apt-get clean \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Claude Code CLI
RUN npm install -g @anthropic-ai/claude-code

# Install Yarn globally
# RUN npm install -g yarn

# Set the working directory (optional)
WORKDIR /projects

# Expose a range of ports for development (optional)
EXPOSE 3001-3005

# Default command (keep the container running)
CMD ["tail", "-f", "/dev/null"]
