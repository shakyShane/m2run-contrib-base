FROM wearejh/m2-php-70:travis-14

ARG version="2.2-develop"
RUN apt-get install -y unzip

ADD https://github.com/magento/magento2/archive/${version}.zip /var/www
#ADD test/${version}.zip /var/www
RUN unzip -q ${version}.zip -d .

FROM wearejh/m2-php-70:travis-14

ARG version="2.2-develop"
COPY --from=0 /var/www/magento2-${version}/. /var/www

# Magento
RUN chsh -s /bin/bash www-data \
    && chown -R www-data:www-data ./

RUN su - www-data -c "COMPOSER_CACHE_DIR=.docker/composer-cache composer install --no-interaction --prefer-dist -o"
