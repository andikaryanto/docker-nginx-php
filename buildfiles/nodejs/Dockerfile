# Use the official Node.js image
# FROM node:18.20
FROM node:20.18

# Install Git
RUN apt-get update && apt-get install -y git && apt-get clean

# Install Yarn globally
# RUN npm install -g yarn

# Set the working directory (optional)
WORKDIR /projects

# Expose a range of ports for development (optional)
EXPOSE 3001-3005

# Default command (keep the container running)
CMD ["tail", "-f", "/dev/null"]
