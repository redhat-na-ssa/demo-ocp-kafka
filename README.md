# AMQ Streams Demo

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

## Quick Start

```sh
scripts/bootstrap.sh
```

## Run AMQ Streams Demo

```sh
# deploy demo
until oc apply -k demo/streams; do : ; done
```

## Scale Consumer / Producer

```sh
# scale generator
oc -n kafka scale deployment kafka-consumer-perf-test --replicas=1
oc -n kafka scale deployment kafka-producer-perf-test --replicas=1
```

## Remove Demo

See [uninstall.sh](scripts/uninstall.sh)

```sh
scripts/uninstall.sh
```

## Links

- https://github.com/joshdreagan/kafka-load-test
