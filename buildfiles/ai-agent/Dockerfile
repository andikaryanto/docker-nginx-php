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

RUN (type -p wget >/dev/null || (apt-get update && apt-get install -y wget)) \
    && mkdir -p -m 755 /etc/apt/keyrings \
    && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y gh \
    && rm -rf /var/lib/apt/lists/*

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

    
#copy idrsa
COPY config/sshkey/id_rsa /root/.ssh/id_rsa
COPY config/sshkey/id_rsa.pub /root/.ssh/id_rsa.pub
RUN chmod 600 /root/.ssh/id_rsa

CMD ["tail", "-f", "/dev/null"]