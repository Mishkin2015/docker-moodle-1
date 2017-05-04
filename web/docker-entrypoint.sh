#!/bin/sh

set +e

MOODLE_SOURCE="/moodle/source"
MOODLE_ROOT="/moodle/web"
MOODLE_DATA="/moodle/data"
MOODLE_CONF="/moodle/conf.d/config.php"
MOODLE_CONF_TEMPLATE="/moodle/config-templates/moodle-config.php"

NGINX_SSL_DIR="/etc/ssl/nginx"
NGINX_CONF="/moodle/config-templates/moodle-nginx.conf"
NGINX_SSL_CONF="/moodle/config-templates/moodle-nginx-ssl.conf"
NGINX_CONF_DIR="/etc/nginx/conf.d"

if [ ! -f "$MOODLE_ROOT/index.php" ]; then
    echo " **** WEB ROOT '$MOODLE_ROOT' is empty, copying source files... **** "
    cp -r $MOODLE_SOURCE/* $MOODLE_ROOT
    rm -r $MOODLE_SOURCE
 
    echo " **** Copying config template '$MOODLE_CONF_TEMPLATE' to '$MOODLE_CONF' **** "
    cp $MOODLE_CONF_TEMPLATE $MOODLE_CONF
 
    sed -i \
        -e "s/{DB_TYPE}/${DB_TYPE:-mysqli}/g" \
        -e "s/{DB_HOST}/${DB_HOST:-mysql}/g" \
        -e "s/{DB_NAME}/${DB_NAME:-moodle}/g" \
        -e "s/{DB_USER}/${DB_USER:-moodle}/g" \
        -e "s/{DB_PASS}/${DB_PASS:-moodle}/g" \
    "$MOODLE_CONF"
fi

cp $MOODLE_CONF $MOODLE_ROOT

rm $NGINX_CONF_DIR/default.conf

if [ -d $NGINX_SSL_DIR ]; then
   if [ ! -f "$NGINX_CONF_DIR/moodle-nginx-ssl.conf" ]; then
       echo " **** Configuring Nginx to use HTTPS **** "

       cp $NGINX_SSL_CONF "$NGINX_CONF_DIR/moodle-nginx-ssl.conf"

       sed -i \
           -e "s/{MOODLE_DOMAIN}/${MOODLE_DOMAIN:-localhost}/g" \
       "$NGINX_CONF_DIR/moodle-nginx-ssl.conf"
 
   fi
else
    if [ ! -f "$NGINX_CONF_DIR/moodle-nginx.conf" ]; then
        echo " **** Cert dir '$NGINX_SSL_DIR' does not exist **** "
        echo " **** Configuring Nginx for HTTP only **** "

        cp $NGINX_CONF "$NGINX_CONF_DIR/moodle-nginx.conf"

	sed -i \
            -e "s/{MOODLE_DOMAIN}/${MOODLE_DOMAIN:-localhost}/g" \
	"$NGINX_CONF_DIR/moodle-nginx.conf"
    fi
fi


chown -R nginx:nginx $MOODLE_ROOT
chown -R nginx:nginx $MOODLE_DATA

exec nginx -g "daemon off;"
