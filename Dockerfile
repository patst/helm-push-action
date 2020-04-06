FROM alpine:3.11

ENV HELM_VERSION v3.1.2

COPY LICENSE README.md /

COPY entrypoint.sh /entrypoint.sh

RUN apk add bash curl openssl git

RUN curl https://raw.githubusercontent.com/helm/helm/$HELM_VERSION/scripts/get-helm-3 | DESIRED_VERSION=$HELM_VERSION bash
RUN helm plugin install https://github.com/chartmuseum/helm-push.git

ENTRYPOINT ["/entrypoint.sh"]
