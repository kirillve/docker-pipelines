FROM docker:24

ENV CRYPTOGRAPHY_DONT_BUILD_RUST=1
ENV VERIFY_CHECKSUM=false

RUN apk update \
    && apk add --no-cache docker-cli python3 py3-pip make bash git curl coreutils gettext \
    && apk add --no-cache --virtual .docker-compose-deps python3-dev libffi-dev openssl-dev gcc libc-dev \
    && pip3 install --upgrade pip \
    && pip3 install --no-cache-dir awscli \
    && apk add py3-pip jq \
    && pip3 install yq \
    && apk del .docker-compose-deps \
    && rm -rf /var/cache/apk/* \
    && wget -qO - https://get.helm.sh/helm-v3.12.3-linux-amd64.tar.gz | tar -xzvf - \
    && chmod +x linux-amd64/helm \
    && mv linux-amd64/helm /usr/bin/helm \
    && wget -q https://releases.hashicorp.com/terraform/1.5.6/terraform_1.5.6_linux_amd64.zip \
    && unzip -q terraform_1.5.6_linux_amd64.zip \
    && mv terraform /usr/local/bin \
    && chmod 0755 /usr/local/bin/terraform

COPY bin/gitlab-terraform.sh /usr/local/bin/gitlab-terraform
RUN chmod +x /usr/local/bin/gitlab-terraform
