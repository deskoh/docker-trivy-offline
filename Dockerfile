FROM aquasec/trivy

RUN apk upgrade \
  && apk add --no-cache su-exec \
  && rm -rf /var/cache/apk/*

RUN mkdir -p /root/.cache/trivy/db/ && \
    cd /root/.cache/trivy/db/ && \
    wget https://github.com/aquasecurity/trivy-db/releases/latest/download/trivy-offline.db.tgz && \
    tar xvf trivy-offline.db.tgz

ADD docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["-h"]