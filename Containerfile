FROM docker.io/library/nginx:1.31.8-alpine

COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

USER nginx

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
