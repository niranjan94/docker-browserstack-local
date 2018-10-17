FROM debian:stable-slim as base

FROM base as source

WORKDIR /data

RUN apt-get update && apt-get install curl unzip -y && curl -O https://www.browserstack.com/browserstack-local/BrowserStackLocal-linux-x64.zip && \
    unzip BrowserStackLocal-linux-x64.zip

FROM base
RUN apt-get update && apt-get install -y procps ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
COPY --from=source /data/BrowserStackLocal /bin/BrowserStackLocal

CMD ["sh", "-c", "BrowserStackLocal --key $KEY"]
