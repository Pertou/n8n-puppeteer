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
    python3 \
    make \
    g++ \
    && rm -rf /var/cache/apk/*

# Install puppeteer globally so n8n can access it
RUN npm install -g puppeteer

# Create Chrome symlink
RUN ln -s /usr/bin/chromium-browser /usr/bin/google-chrome

# Set Puppeteer environment variables
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# Switch back to node user
USER node
