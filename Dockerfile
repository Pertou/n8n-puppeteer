FROM n8nio/n8n:latest

USER root

# Install Chromium and dependencies
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    npm

# Install Puppeteer globally
RUN npm install -g puppeteer

# Create symlinks and directories
RUN ln -s /usr/bin/chromium-browser /usr/bin/google-chrome \
    && mkdir -p /home/node/.cache/puppeteer \
    && chown -R node:node /home/node/.cache

USER node

# Set environment variables
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV CHROME_BIN=/usr/bin/chromium-browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV CHROME_PATH=/usr/bin/chromium-browser
ENV NODE_PATH=/usr/local/lib/node_modules
