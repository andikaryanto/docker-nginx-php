FROM nginx:1.25-alpine-slim

# Install bash
RUN apk update && apk add bash

#RUN adduser -D -H -u 1000 -s /bin/bash www-data -G www-data
# ensure www-data user exists
RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]