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

# Fix Apache document root for Single Page Application routing if needed
RUN sed -ri -s 's!/var/www/html!/var/www/html!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -s 's!/var/www/!/var/www/html!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Install necessary PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Set working directory
WORKDIR /var/www/html

# Run composer install
RUN composer install --no-dev --no-interaction --optimize-autoloader || true

EXPOSE 80
