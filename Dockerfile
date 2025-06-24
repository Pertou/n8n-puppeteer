FROM n8nio/n8n:latest

USER root

# Install Chromium
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# Create Chrome symlink and cache directory
RUN ln -s /usr/bin/chromium-browser /usr/bin/google-chrome \
    && mkdir -p /home/node/.cache/puppeteer \
    && chown -R node:node /home/node/.cache

USER node

# Set all possible environment variables
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV CHROME_BIN=/usr/bin/chromium-browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV CHROME_PATH=/usr/bin/chromium-browser
ENV PUPPETEER_CACHE_DIR=/home/node/.cache/puppeteer
