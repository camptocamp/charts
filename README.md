# CamptToCamp Help Charts Repo

This is the camptocamp charts repository.

### How It Works

GitHub Pages points to the `docs` folder.

### Add a chart

```bash
$ helm create newchart
$ helm package newchart -d docs
$ helm repo index docs --url https://camptocamp.github.io/charts
$ git add .
$ git commit -m 'update charts'
$ git push origin master
```

From there, we can add the repo to helm if not already done

```
helm repo add c2c https://camptocamp.github.io/charts
```