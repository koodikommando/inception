FROM alpine:3.20

RUN apk update && apk add --no-cache mariadb-client \
    php82 php82-fpm php82-mysqli php82-phar php82-mbstring

# Download and install wp-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/bin/wp

# Copy php-fmp config file
COPY conf/www.conf /etc/php82/php-fpm.d/

# Copy entrypoint script
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Create user and group
RUN adduser -S www-data -G www-data

RUN ln -s /usr/bin/php82 /usr/bin/php
RUN php82 -v

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT [ "sh", "/usr/local/bin/entrypoint.sh" ]