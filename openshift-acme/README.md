# helm chart for openshift-acme

This chart is based on the deploy yaml files from the main project at https://github.com/tnozicka/openshift-acme

Documentation of available settings (values) are explainied in the main project.

openshift-acme is ACME Controller for OpenShift and Kubernetes clusters. It will automatically provision certficates using ACME protocol and manage their lifecycle (like automatic renewals).

CAUTION: Please note that this chart was only tested on openshift

## Enabling ACME certificates for your object

Once openshift-acme controller is running on your cluster all you have to do is annotate your Route or other supported object like this:

```yaml
metadata:
  annotations:
    kubernetes.io/tls-acme: "true"
```

## Warning

Whenever you need to switch between those two environments you need to delete the Secret acme-account created on your behalf in the same namespace as you've deployed the controller. (Those environments are totally separate making your account invalid when used with the other one.)