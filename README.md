# CampToCamp Helm Charts Repo

This is the camptocamp charts repository.

### Helm Documentation

https://github.com/kubernetes/helm/blob/master/docs/index.md

### Install helm on minishift

https://blog.openshift.com/deploy-helm-charts-minishifts-openshift-local-development/

### How It Works

We use the master branch to store our charts code, and gh-pages branch as the charts repository.

GitHub Pages points to the `docs` folder and our repository is accessible on https://camptocamp.github.io/charts

### Add this repo to helm

```
helm repo add c2c https://camptocamp.github.io/charts
```

### Add a chart

```bash
CHART=s3-exporter
helm create $CHART
helm package $CHART -d docs
helm repo index docs --url https://camptocamp.github.io/charts
git add .
git commit -m "add chart $CHART"
git push origin master
```

### Update a chart

```bash
CHART=gitlab-backup
helm package $CHART -d docs
helm repo index docs --url https://camptocamp.github.io/charts
git add .
git commit -m "updated $CHART"
git push origin master
```

### Hello-world chart

The hello-world chart was created from a [tutorial](https://hackernoon.com/the-missing-ci-cd-kubernetes-component-helm-package-manager-1fe002aac680) on charts. It's here as an example to understand basic concepts of charts.

### Migrate from openshift-projects to openshift namespaces

The original openshift-projects is broken, as we create projects with the project object.
This object is basically a view of a namespace and is immutable on some settings.

Please use the openshift-namespaces chart from now.

In case of a migration from openshift-projects to openshift-namespaces, be carefull as the project will be deleted (with all content) and a new (empty) project will be recreated.

To avoid this situation, you have to update the state file of your deployement, by changing kind and apiVersion of your release. This will then just update your deployed project and not delete it.

Following hack worked for me to change the state files before upgrading to the new chart:

#### Update helm state config map before upgrading to openshift-namespace

Caution:
Please note that this is working on OSX. You have to adapt 'gbase64' to 'base64' on Linux.
Maybe also some options for sed.

Grab the protobuf definitions used by helm and their dependencies & install `protoc`:
- https://google.github.io/proto-lens/installing-protoc.html
- git clone https://github.com/kubernetes/helm ~/src/github/kubernetes/helm
- git clone https://github.com/google/protobuf ~/src/github/google/protobuf

Get your releases

```
namespace=tiller
helm tiller run ${namespace} -- helm list
```

Set the release name

```
release=<release_name>
```

Modify the release definition

```
# alias the include path to cut down on the length
alias protoc="protoc -I ~/src/github/kubernetes/helm/_proto/ -I ~/src/github/google/protobuf/src/"

# get last configmap
cm=$(oc -n "${namespace}" get cm | grep ${release} | sort --version-sort | tail -1 | awk '{ print $1 }')
echo $cm

# decode/gunzip
oc get cm ${cm} -o jsonpath="{.data.release}" | \
  gbase64 -d | gunzip | \
  protoc --plugin=grpc --decode hapi.release.Release ~/src/github/kubernetes/helm/_proto/hapi/**/*  \
  > /tmp/${cm}.orig

# replace Project apiVersion & kind to Namespace apiVersion & kind
sed 's|apiVersion: project.openshift.io/v1|apiVersion: v1|g; s|kind: Project|kind: Namespace|g' \
/tmp/${cm}.orig > /tmp/${cm}.patched

# Show diffs
diff /tmp/${cm}.orig /tmp/${cm}.patched

# gzip/encode new hash
hash="$(cat /tmp/${cm}.patched | protoc --encode hapi.release.Release ~/src/github/kubernetes/helm/_proto/hapi/**/* | gzip | gbase64 -w0)"

# update cm
oc -n "${namespace}" patch cm ${cm} -p "{\"data\":{\"release\": \"${hash}\"}}"

# Verify changes
helm tiller run ${namespace} -- helm get ${release}

```
