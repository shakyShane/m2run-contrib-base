FROM wearejh/m2-php-70:travis-14

RUN apt-get install -y unzip

ADD https://github.com/magento/magento2/archive/2.2-develop.zip /var/www
#ADD test/2.2-develop.zip /var/www
RUN unzip 2.2-develop.zip -d .

FROM wearejh/m2-php-70:travis-14
COPY --from=0 /var/www/magento2-2.2-develop/. /var/www

# Magento
RUN chsh -s /bin/bash www-data \
    && chown -R www-data:www-data ./

RUN su - www-data -c "COMPOSER_CACHE_DIR=.docker/composer-cache composer install --no-interaction --prefer-dist -o"
