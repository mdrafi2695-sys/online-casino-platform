
FROM php:8.2-apache

# Install git, unzip and composer
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy project files
COPY . /var/www/html/

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Install composer dependencies if composer.json exists
RUN if [ -f composer.json ]; then composer install --no-dev --optimize-autoloader; fi

EXPOSE 80
