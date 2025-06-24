FROM n8nio/n8n:latest

USER root

# Install Chromium and build tools
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    python3 \
    make \
    g++

# Switch to node user and install puppeteer in home directory
USER node

# Create a local node_modules in the user directory
RUN mkdir -p /home/node/node_modules && \
    cd /home/node && \
    npm init -y && \
    npm install puppeteer

# Set NODE_PATH so n8n can find the modules
ENV NODE_PATH=/home/node/node_modules:/usr/local/lib/node_modules

USER root

# Create Chrome symlink
RUN ln -s /usr/bin/chromium-browser /usr/bin/google-chrome

USER node

# Set Puppeteer environment variables
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
