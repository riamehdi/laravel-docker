FROM php:7.4.28-alpine3.15

ENV NVM_DIR /usr/local
ENV NODE_VERSION="14.18.0"
ENV NPM_FETCH_RETRIES=2
ENV NPM_FETCH_RETRY_FACTOR=10
ENV NPM_FETCH_RETRY_MINTIMEOUT=10000
ENV NPM_FETCH_RETRY_MAXTIMEOUT=60000

# Add docker-php-extension-installer script
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Install dependencies
RUN apk add --no-cache \
    bash \
    curl \
    freetype-dev \
    g++ \
    gcc \
    git \
    icu-dev \
    icu-libs \
    libc-dev \
    libzip-dev \
    make \
    mysql-client \
    oniguruma-dev \
    openssh-client \
    postgresql-libs \
    rsync \
    zlib-dev

# Install php extensions
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions \
    @composer \
    redis-stable \
    imagick-stable \
    xdebug-stable \
    bcmath \
    calendar \
    exif \
    gd \
    intl \
    pdo_mysql \
    pdo_pgsql \
    pcntl \
    soap \
    zip

# Install PHP_CodeSniffer
RUN composer global require "squizlabs/php_codesniffer=*"

# install node
# Install nvm (A Node Version Manager)
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# install node and npm
RUN source $NVM_DIR/nvm.sh \
      && nvm install $NODE_VERSION \
      && nvm alias default $NODE_VERSION \
      && nvm use default \
      && npm config set fetch-retries ${NPM_FETCH_RETRIES} \
      && npm config set fetch-retry-factor ${NPM_FETCH_RETRY_FACTOR} \
      && npm config set fetch-retry-mintimeout ${NPM_FETCH_RETRY_MINTIMEOUT} \
      && npm config set fetch-retry-maxtimeout ${NPM_FETCH_RETRY_MAXTIMEOUT}

# add node and npm to path so the commands are available
ENV NODE_PATH=$NVM_DIR/.nvm/v$NODE_VERSION/lib/node_modules

# Add local and global vendor bin to PATH.
ENV PATH ./vendor/bin:/composer/vendor/bin:/root/.composer/vendor/bin:/usr/local/bin:$NVM_DIR/.nvm/versions/node/v$NODE_VERSION/bin:$PATH

# confirm installation
RUN node -v
RUN npm -v

# Setup working directory
WORKDIR /var/www
