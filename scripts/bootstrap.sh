#!/bin/sh
# set -x

SCRIPT=$(basename "$0")

which oc > /dev/null || { echo "missing: oc cli"; exit; }

# shellcheck disable=SC2015
[ -d .git ] && [ -d scripts ] || { echo "run: ${SCRIPT} from root of git repo"; exit; }

demo_uninstall(){
  # remove kafka cluster
  oc -n kafka delete kafkatopic demo.topic01
  oc delete ns kafka

  # remove demo
  oc delete -k demo/streams
  oc delete -k demo/strimzi

  # remove CRDs
  oc delete crd -l app=strimzi

  # cleanup CSV
  oc delete csv -l operators.coreos.com/amq-streams.openshift-operators -A
  oc delete csv -l operators.coreos.com/strimzi-kafka-operator.strimzi-kafka-operator -A  
}

demo_bootstrap(){

  oc apply -k demo/web-terminal
  oc apply -k gitops/instance/autoscale

  until oc apply -k demo/streams 
  do
    sleep 3
  done
}

if [ "${SCRIPT}" = "uninstall.sh" ]; then
  demo_uninstall
fi
if [ "${SCRIPT}" = "bootstrap.sh" ]; then
  demo_bootstrap
fi
