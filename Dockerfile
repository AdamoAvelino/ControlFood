FROM php:7.3-apache
SHELL ["/bin/bash", "-c"]
COPY .docker/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
WORKDIR /var/www/html
RUN apt-get update && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev
RUN apt-get install -y nano iputils-ping net-tools nano
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install pdo pdo_mysql mysqli gd
RUN pecl install xdebug-2.8.1 && docker-php-ext-enable xdebug
RUN a2enmod rewrite
RUN service apache2 restart
