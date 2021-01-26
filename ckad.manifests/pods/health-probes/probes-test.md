### Probes

* `startupProbe` - other probes disabled until this one succeeds
* `readinessProbe` - while this fails, endpoint is removed
* `livenessProbe` - when this fails, the container will be killed

### Notes

* Maximum wait time would be `failureThreshold` * `periodSeconds`.
* `startupProbe`, as of 1.17, is still in beta and needs to be enabled in the kubelet's feature gates.

### Testing

* `nginx` container will not start until `/srv/scratchpad/started` exists.
* When exposed as a service, the endpoint will be removed if `/srv/scratchpad/full-up` exists.
* Removing `/usr/share/nginx/html/index.html` should get the container killed.

