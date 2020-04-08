# build helm push plugin because it is no available for ARM
FROM golang:1.14-buster AS helm-push-builder

ENV CGO_ENABLED=0
ENV GO111MODULE=on
#ENV GOPROXY=https://gocenter.io
ENV HELM_PUSH_VERSION=v0.8.1

RUN git clone --single-branch --branch ${HELM_PUSH_VERSION} https://github.com/chartmuseum/helm-push.git && \
    cd helm-push && \
    go build -v --ldflags="-w -X main.Version=$HELM_PUSH_VERSION -X main.Revision=$HELM_PUSH_VERSION" \
    		-o bin/helmpush cmd/helmpush/main.go

RUN ls -la /go/helm-push/bin/helmpush

FROM alpine:3.11

ENV HELM_VERSION v3.1.2

COPY LICENSE README.md /

COPY entrypoint.sh /entrypoint.sh

RUN apk add bash curl openssl git

RUN curl https://raw.githubusercontent.com/helm/helm/$HELM_VERSION/scripts/get-helm-3 | DESIRED_VERSION=$HELM_VERSION bash

COPY --from=helm-push-builder /go/helm-push /usr/local/bin/helm-push
#RUN helm plugin install helm-push/

ENTRYPOINT ["/entrypoint.sh"]
