# Use the official Node.js 16 image based on Debian Buster as a parent image
FROM node:16-buster

# Set the working directory in the container to /app
WORKDIR /app

# Install dependencies required for Puppeteer and Git
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    procps \
    libxshmfence-dev \
    libgbm-dev \
    git \
    openssh-client \
    chromium \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# apt-get update
# apt-get install -y chromium
ENV CHROMIUM /usr/bin/chromium

# Authorize SSH Host
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    ssh-keyscan github.com > /root/.ssh/known_hosts

# Add the SSH key
ARG SSH_PRIVATE_KEY
RUN echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa

# Clone the repository
RUN git clone https://github.com/dukov777/webcrawler.git

# Switch to the repository directory
WORKDIR /app/webcrawler

# Install your app dependencies inside the container
RUN npm install

# Remove SSH keys
# RUN rm -rf /root/.ssh

# Your application will bind to port 8080, so you'll use the EXPOSE instruction to have it mapped by the docker daemon
EXPOSE 8080

# Define the command to run your app (can be overridden in `docker run`)
CMD [ "bash" ]
