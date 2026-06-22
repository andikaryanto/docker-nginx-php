FROM python:3.12-slim

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
    pyyaml

# Optional utilities
RUN pip install \
    python-dotenv \
    pydantic \
    rich

CMD ["tail", "-f", "/dev/null"]