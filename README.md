# Strimzi Demo

## Prerequisites - Get a cluster

- OpenShift 4.18+
  - role: `cluster-admin`

[Red Hat Demo Platform](https://demo.redhat.com) Options (Tested)

NOTE: The node sizes below are the **recommended minimum** to select for provisioning

- <a href="https://demo.redhat.com/catalog?item=babylon-catalog-prod/sandboxes-gpte.sandbox-ocp.prod&utm_source=webapp&utm_medium=share-link" target="_blank">AWS with OpenShift Open Environment</a>
  - 3 x Control Plane - `m6a.2xlarge`
  - 0 x Workers - `m6a.4xlarge`
- <a href="https://catalog.demo.redhat.com/catalog?item=babylon-catalog-prod/sandboxes-gpte.ocp-wksp.prod&utm_source=webapp&utm_medium=share-link" target="_blank">Red Hat OpenShift Container Platform Cluster (AWS)</a>
  - 3 x Control Plane

## Set up Cluster

```sh
# deploy demo
until oc apply -k demo/on-osd; do : ; done
```

```sh
# deploy example
oc apply -k example/overlays/kafka

# scale example
oc -n strimzi scale deployment kafka-consumer-perf-test --replicas=1
oc -n strimzi scale deployment kafka-producer-perf-test --replicas=1
```

## Links

- https://github.com/joshdreagan/kafka-load-test
