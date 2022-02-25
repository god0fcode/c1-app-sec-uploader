FROM php:7.2-apache

COPY wp /var/www/html/
COPY main.sh /main.sh
RUN chmod +x /main.sh

RUN rm -rf /var/www/index.html

COPY config.php /var/www/html/config.php
COPY phpinfo.php /var/www/html/phpinfo.php

COPY ./trend_app_protect/trend_app_protect-x86_64-Linux-gnu-4.2.1-20170718.so /usr/local/lib/php/extensions/no-debug-non-zts-20170718/
COPY trend_app_protect.ini /usr/local/etc/php/conf.d
RUN mkdir /log && php -v

EXPOSE 80

ENTRYPOINT ["/main.sh"]

CMD ["default"]
