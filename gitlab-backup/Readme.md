# usage

creates a cronjob that backups gitlab to s3 using the task-runner backup utility

todo monitoring

todo backup life-cycle


# openshift 3.11 client
docker pull docker pull ebits/openshift-client
docker run --rm -it ebits/openshift-client sh -c "oc login https://openshift.bgdi.ch && oc project gitlab"

# trial to login with token of a serivce aacount

oc login --token=$(oc get secret deployer-token-2zjvw -o jsonpath="{.data.token}" | base64 -d)

#get token.name
oc get sa deployer -o jsonpath="{.secrets.*.name}" | sed 's/\([[:alnum:]/]*-token-[[:alnum:]/]*\).*/\1/'

#get pods
oc get pod  -o jsonpath='{.items.*.metadata.name}' | sed 's/ /\n/g' | grep 'gitlab-task-runner-'

#backup
oc exec $(oc get pod  -o jsonpath='{.items.*.metadata.name}' | sed 's/ /\n/g' | grep 'gitlab-task-runner-') -it backup-utility

