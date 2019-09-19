#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage $0 <chart name>"
  exit 1
fi

if [ ! -d $1 ]; then
  echo "Cannot find a sub directory called '$1', you need to be at root level of the repo to run this script"
  exit 2
fi

CHART=$1
helm package $CHART -d docs
helm repo index docs --url https://camptocamp.github.io/charts

echo "Chart $CHART updated, you can now commit the diff:"
echo "git add docs/"
echo "git commit -m \"updated $CHART\""
echo "git push origin master"
