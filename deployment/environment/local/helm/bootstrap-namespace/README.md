# Appcket Bootstrap Namespace Helm Chart

Anytime a new team/project needs its own namespace for their app, DevOps can run this chart (helm install bootstrap-namespace -n my-new-namespace) to plug the new app and its components into the existing k8s infrastructure.

New teams/projects will need to create a values-project.yaml file with the desired namespace defined inside.

See a full example of the command in `deployment/environment/local/bootstrap.sh`.

Please see the [Appcket Documentation website](https://docs.appcket.org) for more information on how to configure and use this Helm chart.