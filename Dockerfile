FROM php:8.2-apache

# Install git, unzip and composer
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy project files
COPY . /var/www/html/

# Enable Apache Rewrite module
RUN a2enmod rewrite

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Run composer install to generate vendor folder
RUN cd /var/www/html && composer install --no-dev --optimize-autoloader || true

EXPOSE 80
