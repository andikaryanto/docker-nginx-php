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

# Non-root user the container runs as (python:slim ships no
# equivalent to node's built-in "node" user, so create one).
RUN useradd -m -u 1000 -s /bin/bash agent

RUN (type -p wget >/dev/null || (apt-get update && apt-get install -y wget)) \
    && mkdir -p -m 755 /etc/apt/keyrings \
    && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y gh \
    && rm -rf /var/lib/apt/lists/*

# Create working directory, owned by "agent" (the container runs as "agent",
# see docker-compose user:)
RUN mkdir -p /workspace && chown agent:agent /workspace
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

    
#copy idrsa into the "agent" user's home, since Codex/Claude now run as
#that user instead of root
RUN mkdir -p /home/agent/.ssh /home/agent/.codex /home/agent/.claude \
    && chown agent:agent /home/agent/.ssh /home/agent/.codex /home/agent/.claude \
    && chmod 700 /home/agent/.ssh
COPY --chown=agent:agent config/sshkey/id_rsa /home/agent/.ssh/id_rsa
COPY --chown=agent:agent config/sshkey/id_rsa.pub /home/agent/.ssh/id_rsa.pub
RUN chmod 600 /home/agent/.ssh/id_rsa

CMD ["tail", "-f", "/dev/null"]