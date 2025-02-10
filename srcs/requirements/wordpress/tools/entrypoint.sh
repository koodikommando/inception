#!/bin/sh

while ! mysqladmin -h mariadb -u "$DB_USER" -p"$DB_PASS" ping --silent; do
    echo "Waiting for MariaDB database..."
    sleep 5
done

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Installing WordPress..."
    wp core download --allow-root

    wp core config --dbname=${DB_NAME} --dbuser=${DB_USER} \
      --dbpass=${DB_PASS} --dbhost=${DB_HOST} --allow-root

    wp core install --url=${DOMAIN_NAME} --title=${WP_TITLE} \
      --admin_user=${WP_ADMIN} --admin_password=${WPA_PASS} \
      --admin_email=${WPA_MAIL} --allow-root

    wp user create "${WP_USER}" "${WP_MAIL}" --role=author \
      --user_pass="${WP_PASS}" --allow-root
else
    echo "WordPress is already setup."
fi

chown -R www-data:www-data /var/www/html
chmod -R 775 /var/www/html

echo "Starting the wordpress"
php-fpm82 -F