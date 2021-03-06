FROM php:5.6-apache
MAINTAINER ssikyou "ssikyou@gmail.com"
ENV REFRESHED_AT 2017-1-18

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY sources-jessie.aliyun /etc/apt/sources.list

RUN apt-get update && apt-get install -y --no-install-recommends \
    vim \
	ntp \
    cron \
    unzip \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libxslt1-dev \
&& rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure \
    gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install \
    gd \
    intl \
    mbstring \
    mcrypt \
    pdo_mysql \
    soap \
    xsl \
    zip \
    mysqli

RUN yes | pecl install xdebug \
    && docker-php-ext-enable xdebug 

COPY conf/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/

#RUN curl -sS https://getcomposer.org/installer | \
#  php -- --install-dir=/usr/local/bin --filename=composer
 
ARG DOMAIN_NAME
COPY conf/php.ini /usr/local/etc/php/
COPY scripts/* /usr/local/bin/
COPY conf/base.conf /etc/apache2/sites-available/
COPY conf/${DOMAIN_NAME}.conf /etc/apache2/sites-available/
COPY files/* /tmp/
COPY robots.txt /tmp/

RUN a2dissite 000-default.conf
RUN a2ensite ${DOMAIN_NAME}.conf
RUN a2enmod rewrite

WORKDIR /var/www/html

CMD ["/usr/local/bin/start"]
