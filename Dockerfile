# Use the official Node.js 16 image based on Debian Buster as a parent image
FROM node:16-buster

# Set the working directory in the container to /app
WORKDIR /app

# Install dependencies required for Puppeteer
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    procps \
    libxshmfence-dev \
    libgbm-dev \
    libxss1 \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxi6 \
    libxtst6 \
    libcups2 \
    libxrandr2 \
    libasound2 \
    libpangocairo-1.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libgtk-3-0 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Copy the package.json and package-lock.json (or yarn.lock) files into the container
COPY package*.json ./

# Install your app dependencies inside the container
RUN npm install

# Bundle your app's source code inside the Docker image
COPY . .

# Your application will bind to port 8080, so you'll use the EXPOSE instruction to have it mapped by the docker daemon
EXPOSE 8080

# Define the command to run your app (can be overridden in `docker run`)
CMD [ "node", "scrape.js" ]
