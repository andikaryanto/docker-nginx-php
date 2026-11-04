FROM nginx:1.25-alpine-slim

# Install bash
RUN apk update && apk add bash

# Install Git
RUN apk add --no-cache git

# install cloudflared (dev only)
ARG TARGETARCH
RUN apk add --no-cache curl ca-certificates ffmpeg \
    && curl -fsSL --retry 10 --retry-all-errors --retry-delay 3 -o /usr/local/bin/cloudflared \
        "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-${TARGETARCH}" \
    && chmod +x /usr/local/bin/cloudflared


#RUN adduser -D -H -u 1000 -s /bin/bash www-data -G www-data
# ensure www-data user exists
RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]