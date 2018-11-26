# Varnish

This will provide a varnish installation with, by default, a toy configuration not intended for anything except making varnish start without error.

## Installing

`helm install . --namespace test`

## Varnish Configuration

The varnish configuration used by default in this chart, is a dummy one, that needs to be customized.
To avoid the helm chart destroying your custom configuration each time you deploy, add a new key to the ConfigMap.
This new key will be a file in */etc/varnish/* and will be usable by setting helm chart value *varnishConfigFile*.

If you do not want helm to manage the ConfigMap at all, you can also set *varnishConfigMapName* to the name
of a preexisting ConfigMap, this will be used as the configuration source for varnish.

The best way to use this mechanism, is to have a git repository for VCL with CI/CD process to test the VCL and update the ConfigMap on changes.

The changes in configuration will be loaded automatically by the chart.

## Varnishkafka Configuration

The helm chart is made to restart the pod on change of varnishkafka configuration. If you use a varnishkafka configuration unmanaged by the chart,
you need to manually restart varnishkafka so that the new configuration is used. As such you should not edit the configmap if it is managed by the helm chart.
