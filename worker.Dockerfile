FROM ghcr.io/ahappypie/superset-databricks:1.4.2

USER root

RUN apt update && \
    apt install --no-install-recommends -y firefox-esr && \
    apt autoremove -yqq --purge && \
    apt clean && \
    rm -r /var/lib/apt/lists/*

ENV GECKODRIVER_VERSION=0.29.1
RUN wget -q https://github.com/mozilla/geckodriver/releases/download/v${GECKODRIVER_VERSION}/geckodriver-v${GECKODRIVER_VERSION}-linux64.tar.gz && \
    tar -x geckodriver -zf geckodriver-v${GECKODRIVER_VERSION}-linux64.tar.gz -O > /usr/bin/geckodriver && \
    chmod 755 /usr/bin/geckodriver && \
    rm geckodriver-v${GECKODRIVER_VERSION}-linux64.tar.gz

USER superset