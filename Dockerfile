FROM aquasec/trivy

RUN mkdir -p /root/.cache/trivy/db/ && \
    cd /root/.cache/trivy/db/ && \
    wget https://github.com/aquasecurity/trivy-db/releases/latest/download/trivy-offline.db.tgz && \
    tar xvf trivy-offline.db.tgz && \
    rm -f trivy-offline.db.tgz

ENTRYPOINT ["trivy", "--skip-update"]
