# Docker file to run Hashicorp Vault (vaultproject.io)
FROM alpine
MAINTAINER Sam Barham <s.barham@adinstruments.com>

# Enviroment vars
ENV VAULT_VERSION 0.4.1
ENV VAULT_TMP /tmp/vault.zip
ENV VAULT_HOME /usr/local/bin
ENV PATH $PATH:${VAULT_HOME}

# Install
RUN apk --no-cache add bash ca-certificates wget && \
    wget --quiet --output-document=${VAULT_TMP} https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip && \
    unzip ${VAULT_TMP} -d ${VAULT_HOME} && \
    rm -f ${VAULT_TMP}

# Configure
COPY ["./config", "/config"]
COPY ["./drunner", "/drunner"]

RUN adduser -S vault && \
    chmod a+rwx /usr/local/bin/vault && \
    chmod a+r -R /config && \
    chmod a-w -R /config && \
    chmod a+r -R /drunner && \
    chmod a-w -R /drunner && \
    mkdir /data && \
    chmod a+rw -R /data

VOLUME /data

USER vault

# Listener API tcp port
EXPOSE 8200
ENV VAULT_ADDR "http://127.0.0.1:8200"

# Run
CMD ["/usr/local/bin/vault", "server", "-config=/config"]
