FROM ghcr.io/ahappypie/superset-databricks:1.4.2

USER root

RUN pip install --no-cache \
    flower==1.0.0

USER superset