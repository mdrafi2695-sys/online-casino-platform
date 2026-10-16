FROM php:8.2-apache

# Copy project files
COPY . /var/www/html/

# Enable Apache Rewrite module
RUN a2enmod rewrite

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

EXPOSE 80
