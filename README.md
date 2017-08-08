# CampToCamp Help Charts Repo

This is the camptocamp charts repository.

### How It Works

GitHub Pages points to the `docs` folder.

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
