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

USER node

# Install Puppeteer in n8n's node_modules
RUN cd /usr/local/lib/node_modules/n8n && npm install puppeteer

USER root

# Create symlinks
RUN ln -s /usr/bin/chromium-browser /usr/bin/google-chrome

USER node

# Set environment variables
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
