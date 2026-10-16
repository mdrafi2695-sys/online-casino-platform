FROM php:8.2-apache

# Install git, unzip, and composer
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy all project files to Apache root
COPY . /var/www/html/

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install necessary PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Install composer dependencies properly inside the web root
WORKDIR /var/www/html
RUN composer install --no-dev --no-interaction --optimize-autoloader

EXPOSE 80
