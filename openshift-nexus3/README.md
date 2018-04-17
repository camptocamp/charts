Setting up Nexus manually with openshift cli

1. Download and deploy the official Nexus3 container image:

```
oc new-app sonatype/nexus3
```

2. Create a route by exposing the newly created Nexus3 service:

```
oc expose svc/nexus3
```

3. Using Probes to Check for Success

```
oc set probe dc/nexus3 \
	--liveness \
	--failure-threshold 3 \
	--initial-delay-seconds 30 \
	-- echo ok
```


```
oc set probe dc/nexus3 \
	--readiness \
	--failure-threshold 3 \
	--initial-delay-seconds 30 \
	--get-url=http://:8081

4. Adding Persistence to Nexus3

oc volumes dc/nexus3 --add \
	--name 'nexus3-volume-1' \
	--type 'pvc' \
	--mount-path '/nexus-data/' \
	--claim-name 'nexus3-pv' \
	--claim-size '50G' \
	--overwrite

