## HorizontalPodAutoscaler

### MiniKube

* Has to be started with `metrics-server` in `--addons=` list.

### hpa-deployment.yaml

* Starts 3 replicas
* hpa brings that down to 2 
* Scales when cpu > 70%

To increase load inside a pod:
```{text}
$ kubectl exec -it my-app-695f465b98-hmr9d /bin/sh
/ # while :; do echo $((98765*43210)) > /dev/null; done
```

### Monitoring events

```{text}
kubectl describe hpa my-app
```

```{text}
kubectl get events --sort-by='{.metadata.creationTimestamp}'
```
