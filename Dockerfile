FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . /var/www/html/

# Apache configuration to allow overrides and set DocumentRoot properly
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && sed -i 's/DocumentRoot \/var/www\/html/DocumentRoot \/var\/www\/html/g' /etc/apache2/sites-available/000-default.conf \
    && echo "<Directory /var/www/html/>\n\tOptions Indexes FollowSymLinks\n\tAllowOverride All\n\tRequire all granted\n</Directory>" >> /etc/apache2/apache2.conf

RUN docker-php-ext-install pdo pdo_mysql

RUN if [ -f composer.json ]; then composer install --no-dev --optimize-autoloader; fi

EXPOSE 80
