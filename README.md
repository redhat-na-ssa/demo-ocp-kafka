# Strimzi Demo

## Pre-requisites

Install the Strimzi operator. This can be done within your target namespace(s) (ie, 'strimzi''), or globally across all namespaces.

Install the Prometheus operator. This can be done within your target namespace (ie, 'strimzi-metrics'), or globally across all namespaces.

Install the Grafana operator. This can be done within your target namespace (ie, 'strimzi-metrics'), or globally across all namespaces.

## Set up Cluster

__Environment__

```
#
# Set your env variables.
export PROJECT_ROOT="$(pwd)"
export PATH="${PROJECT_ROOT}/bin:${PATH}"
```

__Prometheus/Grafana__

```
#
# Create the metrics project. Do this as a regular user.
oc new-project strimzi-metrics

#
# Create/configure the Prometheus server. These steps must be completed as cluster-admin.
cd "${PROJECT_ROOT}/prometheus"
oc -n strimzi-metrics apply -f ./prometheus-additional-scrape-secret.yaml
oc -n strimzi-metrics apply -f ./prometheus.yaml
oc -n strimzi-metrics apply -f ./prometheus-strimzi-pod-monitor.yaml
# End cluster-admin steps.


#
# Create/configure the Grafana server.
cd "${PROJECT_ROOT}/grafana"
oc -n strimzi-metrics apply -f ./grafana.yaml
oc -n strimzi-metrics expose service grafana-service
oc -n strimzi-metrics apply -f ./grafana-datasource.yaml
oc -n strimzi-metrics apply -f './*-dashboard.yaml'
```

__Strimzi/Kafka__

```
#
# Create the strimzi project. Do this as a regular user.
oc new-project strimzi

#
# Create the Kafka cluster.
cd "${PROJECT_ROOT}/strimzi
oc -n strimzi apply -f ./kafka-metrics-config.yaml
oc -n strimzi apply -f ./kafka-cluster.yaml
```

__Mirror Maker__

```
cd "${PROJECT_ROOT}/strimzi

#
# Get the TLS cert from the remote/source cluster and save it as ./tls/source-kafka-cluster.crt.

#
# Create a secret containing the certificate.
oc -n strimzi create secret generic mirror-maker-trusted-certs --from-file=source-kafka-cluster-cert=./tls/source-kafka-cluster.crt

#
# Create the Mirror Maker cluster
oc -n strimzi apply -f ./mirror-maker-metrics-config.yaml
oc -n strimzi apply -f ./mirror-maker-cluster.yaml
```
