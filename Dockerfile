FROM docker:24

RUN apk update \
    && apk add --no-cache docker-cli make bash git curl coreutils \
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
