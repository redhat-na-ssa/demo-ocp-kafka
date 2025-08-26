# Other Notes

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
