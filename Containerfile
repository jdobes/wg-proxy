FROM docker.io/library/nginx:1.31.8-alpine@sha256:1ef7ca94d7879df82421428ce13bd1eaa412404953859cf7a5b6512c25e67a60

COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

USER nginx

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
