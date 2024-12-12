FROM alpine:3.21 AS builder

RUN apk add --no-cache rsync

FROM registry.k8s.io/git-sync/git-sync:v4.3.0

COPY --from=builder /usr/bin/rsync /usr/bin/rsync
COPY --from=builder /lib/ /lib/
COPY --from=builder /usr/lib/ /usr/lib

USER root

COPY rsync-airflow-dags-and-dbt /usr/local/bin/rsync-airflow-dags-and-dbt
RUN chmod +x /usr/local/bin/rsync-airflow-dags-and-dbt

USER git-sync
