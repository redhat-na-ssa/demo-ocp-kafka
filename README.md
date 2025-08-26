# Strimzi Demo

## Prerequisites - Get a cluster

- OpenShift 4.18+
  - role: `cluster-admin`

[Red Hat Demo Platform](https://demo.redhat.com) Options (Tested)

NOTE: The node sizes below are the **recommended minimum** to select for provisioning

- <a href="https://demo.redhat.com/catalog?item=babylon-catalog-prod/sandboxes-gpte.sandbox-ocp.prod&utm_source=webapp&utm_medium=share-link" target="_blank">AWS with OpenShift Open Environment</a>
  - 1 x Control Plane - `m6a.2xlarge`
  - 0 x Workers - `m6a.4xlarge`

## Set up Cluster

```sh
# deploy demo
until oc apply -k gitops; do : ; done
```

```sh
# deploy example
oc apply -k example/kafka

# scale example
oc -n strimzi scale deploy kafka-consumer-perf-test --replicas=1
oc -n strimzi scale deployment kafka-producer-perf-test --replicas=1
```

## Links

- https://github.com/joshdreagan/kafka-load-test

## Mirror maker

Get the TLS cert from the remote/source cluster and save it as ./tls/source-kafka-cluster.crt.

Create a secret containing the certificate.

```sh
oc -n strimzi create secret generic mirror-maker-trusted-certs --from-file=source-kafka-cluster-cert=./tls/source-kafka-cluster.crt
```

Create the Mirror Maker cluster

```sh
oc -n strimzi apply -f ./mirror-maker-metrics-config.yaml
oc -n strimzi apply -f ./mirror-maker-cluster.yaml
```
