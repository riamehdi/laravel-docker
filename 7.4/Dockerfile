FROM php:7.4.28-alpine3.15

ENV NVM_DIR /home/.nvm
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

# Add local and global vendor bin to PATH.
ENV PATH ./vendor/bin:/composer/vendor/bin:/root/.composer/vendor/bin:/usr/local/bin:$PATH

# Install PHP_CodeSniffer
RUN composer global require "squizlabs/php_codesniffer=*"

# install node
# Install nvm (A Node Version Manager)
RUN mkdir -p $NVM_DIR && \
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash \
      && . $NVM_DIR/nvm.sh \
      && nvm install ${NODE_VERSION} \
      && nvm use ${NODE_VERSION} \
      && nvm alias ${NODE_VERSION} \
      && npm config set fetch-retries ${NPM_FETCH_RETRIES} \
      && npm config set fetch-retry-factor ${NPM_FETCH_RETRY_FACTOR} \
      && npm config set fetch-retry-mintimeout ${NPM_FETCH_RETRY_MINTIMEOUT} \
      && npm config set fetch-retry-maxtimeout ${NPM_FETCH_RETRY_MAXTIMEOUT} \
      && ln -s `npm bin --global` $HOME/.node-bin

RUN node --version
RUN npm --version

# Setup working directory
WORKDIR /var/www
