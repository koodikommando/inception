FROM alpine:3.20

RUN apk update && apk add --no-cache nginx openssl

# Copy nginx config file
COPY conf/nginx.conf /etc/nginx/
RUN chmod 644 /etc/nginx/nginx.conf

# Copy entrypoint script
COPY tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 443

ENTRYPOINT [ "sh",  "/usr/local/bin/entrypoint.sh" ]