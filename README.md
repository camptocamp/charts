# CampToCamp Helm Charts Repo

This is the camptocamp charts repository.

### Helm Documentation

https://github.com/kubernetes/helm/blob/master/docs/index.md

### How It Works

We use the master branch to store our charts code, and gh-pages branch as the charts repository.

GitHub Pages points to the `docs` folder and our repository is accessible on https://camptocamp.github.io/charts

### Add a chart

```bash
CHART=hello-world
helm create $CHART
helm package $CHART -d docs
helm repo index docs --url https://camptocamp.github.io/charts
git add .
git commit -m "add chart $CHART"
git push origin master
```

### Update a chart

```bash
CHART=hello-world
helm package $CHART -d docs
helm repo index docs --url https://camptocamp.github.io/charts
git add .
git commit -m "add chart $CHART"
git push origin master
```

### Add repo to helm

```
helm repo add c2c https://camptocamp.github.io/charts
```

### Hello-world chart

The hello-world chart was created from a [tutorial](https://hackernoon.com/the-missing-ci-cd-kubernetes-component-helm-package-manager-1fe002aac680) on charts. It's here as an example to understand basic concepts of charts.
