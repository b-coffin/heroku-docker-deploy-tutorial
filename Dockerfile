FROM nginx:latest

WORKDIR /usr/share/nginx/html

COPY src /usr/share/nginx/html
COPY default.conf.template /etc/nginx/conf.d/default.conf.template

# Herokuではポート番号が動的に割り当てられるため、ポート番号をListenするために起動時に $PORT という環境変数を読み込む必要がある。
CMD /bin/sh -c "envsubst '\$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;'
