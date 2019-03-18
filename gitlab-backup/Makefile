help:
	echo 'init: create connection to openshift and launches loclal tiller , connect with export HELM_HOST=localhost:44134'
	echo 'deploy: calls init and deploy all objects'
	echo 'backup-list: need aws cli connection, show all gitlab backups in s3'

init:
	export HELM_HOST=localhost:44134
	oc status  || oc login  https://openshift.bgdi.ch
	oc project gitlab
	helm tiller stop || exit 0
	helm tiller start-ci gitlab


secrets-delete:
	# calls summon with gopass (using the secrets.yaml file) to get the gitlabpostgress password from gopass base64 encore and envsubst it to create a oc secret using oc_secrets.yml
	# need an active oc login session
	oc delete secret postgres-secret
	oc delete secret s3-storage
	oc delete secret s3cmd-config
	oc delete secret ldap-password
	oc delete secret smtp-password
	oc delete secret gitlab-rails-storage
	oc delete secret freeipa-ca
	oc delete secret gitlab-minio-secret

secrets-create:
	# calls summon with gopass (using the secrets.yaml file) to get the gitlabpostgress password from gopass base64 encore and envsubst it to create a oc secret using oc_secrets.yml
	# need an active oc login session
	summon -p gopass bash -c 'oc create -f <(envsubst < oc_secrets_postgress.yaml)'
	summon -p gopass bash -c 'oc create secret generic s3-storage --from-file=config=<(envsubst < s3.yaml)'
	summon -p gopass bash -c 'oc create secret generic s3cmd-config --from-file=config=<(envsubst <s3cmd.config)'
	summon -p gopass bash -c 'oc create -f <(envsubst < oc_secrets_ldap.yaml)'
	summon -p gopass bash -c 'oc create -f <(envsubst < oc_secrets_mail.yaml)'
	summon -p gopass bash -c 'oc create secret generic gitlab-rails-storage --from-file=connection=<(envsubst < rails.s3.yaml)'
	oc create secret generic freeipa-ca --from-file=freepipa-ca.crt=./freeipa_ca.crt
	oc create -f minio_empty.yaml


secrets:
	secrets-delete
	secret-create

backups-list:
	aws s3 ls chtopo-gitlab-443130343732-backup

backup-restore-secrets
	echo 'gopass c2c/chtopo_mgmtsrv/aws_gitlab_rails_secret_key | kubectl create secret generic gitlab-rails-secret -f -'

clean:
	#oc get pv | awk ' /Released/ { print $1 } ' | xargs oc delete pv
