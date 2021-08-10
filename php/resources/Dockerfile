FROM php:7.4.22-apache

RUN apt-get update && \
    apt-get install -y libmcrypt-dev zlib1g-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libtidy-dev libldap2-dev libxml2-dev && \
    apt-get clean && \
    printf "\n" | pecl install mcrypt && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install bcmath gd ldap mysqli pdo pdo_mysql soap tidy && \
    docker-php-ext-enable mcrypt
RUN /usr/sbin/a2disconf other-vhosts-access-log