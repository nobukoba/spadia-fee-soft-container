ENV LC_ALL=C.UTF-8

LABEL org.opencontainers.image.source="https://github.com/nobukoba/spadia-fee-soft-container"

RUN dnf -y update && \
    dnf -y install \
      gcc gcc-c++ \
      make cmake ninja-build \
      git \
      python3 \
      tar gzip xz unzip \
      which file hostname procps-ng && \
    dnf clean all && \
    rm -rf /var/cache/dnf

COPY scripts/setup_hul.sh /usr/local/bin/setup-hul.sh
COPY scripts/smoke_test.sh /usr/local/bin/hul-smoke-test.sh

RUN chmod +x /usr/local/bin/setup-hul.sh /usr/local/bin/hul-smoke-test.sh

CMD ["/bin/bash"]
