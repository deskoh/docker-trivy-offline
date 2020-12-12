# Trivy in Air-gapped environment

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
  trivy fs \
  -f json -o /src/trivy.json \
  --exit-code 1 --severity CRITICAL,HIGH \
  /src
```

## References

[Trivy](https://github.com/aquasecurity/trivy)

[Air-gapped environment](https://github.com/aquasecurity/trivy/blob/master/docs/air-gap.md)
