#!/bin/bash

export source_namespace=tiller
export target_namespace=management-infra

helm tiller run ${target_namespace} -- bash -c "helm list -q > /tmp/.helm-list-${target_namespace}"
for release in $(cat /tmp/.helm-list-${target_namespace}); do
#for release in $(echo "bivac"); do
  echo "-------------------------------------------------------"
  echo "${release}"
  echo "-------------------------------------------------------"
  # get last configmap
  cm=$(oc -n "${source_namespace}" get cm |  grep "^${release}.v.*$" | sort --version-sort | tail -1 | awk '{ print $1 }')

  # decode/gunzip
  oc get -n ${target_namespace} cm ${cm} -o jsonpath="{.data.release}" | \
    gbase64 -d | gunzip | \
    protoc -I ~/src/github/kubernetes/helm/_proto/ -I ~/src/github/google/protobuf/src/ --plugin=grpc --decode hapi.release.Release ~/src/github/kubernetes/helm/_proto/hapi/**/*  \
    > /tmp/${cm}.orig

  # replace Namespace
  sed "s|namespace: \"${source_namespace}\"|namespace: \"${target_namespace}\"|g" \
  /tmp/${cm}.orig > /tmp/${cm}.patched

  # Show diffs
  diff /tmp/${cm}.orig /tmp/${cm}.patched

  # gzip/encode new hash
  hash="$(cat /tmp/${cm}.patched | protoc -I ~/src/github/kubernetes/helm/_proto/ -I ~/src/github/google/protobuf/src/ --encode hapi.release.Release ~/src/github/kubernetes/helm/_proto/hapi/**/* | gzip | gbase64 -w0)"

  # update cm
  oc -n "${target_namespace}" patch cm ${cm} -p "{\"data\":{\"release\": \"${hash}\"}}"

  # Verify changes
  helm tiller run ${target_namespace} -- bash -c "helm list ${release}"

done

