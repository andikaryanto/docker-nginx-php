FROM python:3.12-slim

RUN cat /etc/os-release

# Install system packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    bash \
    nano \
    grep \
    sed \
    procps \
    openssh-client \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get update \
    && apt-get install -y nodejs

# Install Codex CLI
RUN npm install -g @openai/codex
RUN npm install -g @anthropic-ai/claude-code

# Create working directory
WORKDIR /workspace

# Upgrade pip
RUN pip install --upgrade pip

# AI Frameworks
RUN pip install \
    langgraph \
    langchain \
    langchain-openai \
    langchain-anthropic \
    redis \
    langgraph-checkpoint-redis \
    pyyaml

# Optional utilities
RUN pip install \
    python-dotenv \
    pydantic \
    rich

CMD ["tail", "-f", "/dev/null"]