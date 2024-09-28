FROM centralx/clash:latest

RUN echo "$SUB_URL"

COPY entrypoint.sh /entrypoint.sh
COPY clash /usr/local/bin/clash

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]