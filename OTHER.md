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

Test kustomize

```sh
oc kustomize example/streams/ > scratch/streams
oc kustomize example/strimzi/ > scratch/strimzi
diff -u scratch/{streams,strimzi} > scratch/diff.k
```

AWS [On Prem] - Strimzi
OSD [Cloud] - Streams
