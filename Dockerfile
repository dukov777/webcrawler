# Use an official Node.js runtime as a parent image with the target platform specified
FROM --platform=linux/amd64 node:16-buster

# Set environment variables for headless chrome
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Install dependencies required for headless Chrome
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    apt-transport-https \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# If you're using Puppeteer, install it globally
# WORKDIR /node_modules
# RUN npm install puppeteer
# # Add Puppeteer to PATH
# ENV PATH="/node_modules/.bin:$PATH"

# If you're installing Chrome manually, uncomment and use the following lines
# RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
# RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
# RUN apt-get update && apt-get install -y google-chrome-stable && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in package.json
RUN npm install

# Make port 80 available to the world outside this container
EXPOSE 80

CMD [ "bash" ]

