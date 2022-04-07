ARG SUPERSET_VERSION=1.4.2
FROM apache/superset:$SUPERSET_VERSION

USER root

RUN apt update

RUN apt install --no-install-recommends -y g++ unixodbc-dev

RUN pip install --no-cache \
    psycopg2==2.9.3 \
    redis==4.1.4 \
    databricks-dbapi[odbc,sqlalchemy]==0.6.0 \
    gevent==21.12.0 \
    authlib==0.15.5

RUN apt remove -y g++ && \
    apt autoremove -yqq --purge && \
    apt clean && \
    rm -r /var/lib/apt/lists/*

RUN wget -q https://databricks-bi-artifacts.s3.us-east-2.amazonaws.com/simbaspark-drivers/odbc/2.6.19/SimbaSparkODBC-2.6.19.1033-Debian-64bit.zip && \
    unzip SimbaSparkODBC-2.6.19.1033-Debian-64bit.zip -d /tmp/sparkodbcdriver && \
    dpkg -i /tmp/sparkodbcdriver/simbaspark_2.6.19.1033-2_amd64.deb && \
    rm -r /tmp/sparkodbcdriver/ && \
    rm SimbaSparkODBC-2.6.19.1033-Debian-64bit.zip

USER superset