# Set alpine version
ARG ALPINE_VERSION=3.15.7

# Build
FROM alpine:${ALPINE_VERSION}

WORKDIR /server

RUN echo '@community http://nl.alpinelinux.org/alpine/v3.15/community' >> /etc/apk/repositories && \
  apk add --no-cache \
    curl \
    php7 \
    php7-opcache \
    php7-pdo \
    php7-pdo_pgsql \
    php7-session && \
  curl -L https://raw.githubusercontent.com/pereorga/minimalist-web-notepad/refs/heads/master/index.php -o index.php && \
  curl -L https://raw.githubusercontent.com/pereorga/minimalist-web-notepad/refs/heads/master/favicon.ico -o favicon.ico && \
  curl -L https://raw.githubusercontent.com/pereorga/minimalist-web-notepad/refs/heads/master/favicon.svg -o favicon.svg && \
  apk del curl && \
  rm -rf /var/cache/apk/*

EXPOSE 8080

CMD /usr/bin/php \
    -S 0.0.0.0:8080 \
    -t /server
