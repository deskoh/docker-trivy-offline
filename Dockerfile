FROM aquasec/trivy

RUN apk upgrade \
  && apk add --no-cache su-exec \
  && rm -rf /var/cache/apk/*

ENV TRIVY_CACHE_DIR=/.cache/trivy

RUN trivy --download-db-only \
  # Support other uid
 && find /.cache -type d -exec chmod 777 {} \; \
 && find /.cache -type f -exec chmod 666 {} \;

ENV TRIVY_SKIP_UPDATE=true

ADD docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["-h"]
