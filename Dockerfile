FROM alpine:3.5
ENV CONFIG_JSON=none
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
 && apk add --no-cache --virtual .build-deps ca-certificates curl \
 && mkdir /usr/bin/v2ray /etc/v2ray \
 && touch /etc/v2ray/config.json \
 && echo -E "cat <<-EOF > /etc/v2ray/config.json" >/configure.sh \
 && echo -E "\$OCNFIG_JSON" >> /configure.sh\
 && echo -E "EOF">> /configure.sh \
 && chmod +x /configure.sh \
 && curl -L -H "Cache-Control: no-cache" -o /v2ray.zip https://github.com/v2ray/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
 && unzip /v2ray.zip -d /usr/bin/v2ray \
 && rm -rf /v2ray.zip /usr/bin/v2ray/*.sig /usr/bin/v2ray/doc /usr/bin/v2ray/*.json /usr/bin/v2ray/*.dat /usr/bin/v2ray/sys* \
 && chgrp -R 0 /etc/v2ray \
 && chmod -R g+rwX /etc/v2ray 
ENTRYPOINT ["sh", "/configure.sh"]
EXPOSE 8080
