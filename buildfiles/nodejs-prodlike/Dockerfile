# Use the official Node.js image
# FROM node:18.20
FROM node:20.18

# Install Git
RUN apt-get update && apt-get install -y git && apt-get clean

#copy idrsa
COPY config/sshkey/id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Install PM2
RUN npm install -g pm2

# Set the working directory (optional)
WORKDIR /projects

# Expose a range of ports for development (optional)
EXPOSE 3011-3020

# Default command (keep the container running)
CMD ["tail", "-f", "/dev/null"]
