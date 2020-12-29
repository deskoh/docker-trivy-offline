# Trivy in Air-gapped environment

[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/deskoh/trivy)](https://hub.docker.com/r/deskoh/trivy)
[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/deskoh/trivy)](https://hub.docker.com/r/deskoh/trivy/builds)

[Trivy](https://github.com/aquasecurity/trivy) with offline DB for use in air-gapped environment.

## Build

```sh
# Requires internet access
docker build . -t trivy
```

## Quick Start

```sh
# Scan image (e.g. nginx:alpine)
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  trivy nginx:alpine

# Scan filesystem / app dependencies (e.g. /path/to/project)
docker run --rm \
  -v /path/to/project:/src \
  trivy fs /src

# CI Example
docker run --rm \
  -v /path/to/project:/src \
  trivy --skip-update fs \
  -f json -o /src/trivy.json \
  --exit-code 1 --severity CRITICAL,HIGH \
  /src
```

## `Jenkinsfile` Example

> Jenkins agent is running as docker container with volume mount to `/var/run/docker.sock`.

```groovy
pipeline {
  stage('Scan Image') {
    environment {
      // If using non-secure registry
      TRIVY_NON_SSL = 'true'
    }
    agent {
      docker {
        image: 'trivy:latest'
        args '--group-add docker'
        reuseNode true
      }
    }
    steps {
      // Generate scan results in JSON
      sh 'trivy -f json -o trivy.json ${DOCKER_REGISTRY}/${DOCKER_IMAGE}'
      sh 'trivy --severity UNKNOWN,LOW,MEDIUM,HIGH ${DOCKER_REGISTRY}/${DOCKER_IMAGE}'
      // Fail stage with CRITICAL vulnerability
      sh 'trivy --exit-code 1 --severity CRITICAL ${DOCKER_REGISTRY}/${DOCKER_IMAGE}'
    }
  }
}
```

## References

[Trivy](https://github.com/aquasecurity/trivy)

[Air-gapped environment](https://github.com/aquasecurity/trivy/blob/master/docs/air-gap.md)
