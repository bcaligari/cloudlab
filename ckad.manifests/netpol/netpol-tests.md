## NwtworkPolicy


### API Resource

```{text}
$ kubectl api-resources
NAME                              SHORTNAMES     APIGROUP                       NAMESPACED   KIND
...
networkpolicies                   netpol         extensions                     true         NetworkPolicy
...
networkpolicies                   netpol         networking.k8s.io              true         NetworkPolicy
...
```

```{text}
$ kubectl api-versions
...
networking.k8s.io/v1
networking.k8s.io/v1beta1
...
```

```{text}
$ kubectl explain --api-version=networking.k8s.io/v1 netpol.[...]
```


## Alpha-Beta-Gamma

### Deployment alpha

* Listens on three ports: 5000, 5001, & 5002
* Simple TCP connection, not HTTP
* Service 

### Test Pods, beta and gamma

* Expose a TCP listen on port 6000
* Carrying out tests from within a running container avoids the startup and teardown waits of the `kubectl run -it --restart=Never --rm` idiom.


### Pre-flight


```{text}
kubectl create -f alpha-deployment.yaml
```

```{text}
kubectl create -f alpha-service.yaml
```

```{text}
kubectl create -f alpha-netpol.yaml
```

```{text}
$ kubectl get svc -o wide
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE    SELECTOR
alpha        ClusterIP   10.100.129.131   <none>        5000/TCP,5001/TCP,5002/TCP   3d2h   app=alpha
...
```

```{text}
kubectl create -f beta-gamma-testpods.yaml
```

```{text}
$ kubectl get pods -o wide --show-labels
NAME                     READY   STATUS    RESTARTS   AGE     IP             NODE      NOMINATED NODE   READINESS GATES   LABELS
...
beta                     1/1     Running   1          18h     10.244.1.87    worker0   <none>           <none>            radiation=beta
gamma                    1/1     Running   1          18h     10.244.1.203   worker0   <none>           <none>            radiation=gamma
```

### Tests

These should work:

```{text}
kubectl exec -it beta -- nc -w 1 alpha.default.svc 5001
```

```{text}
kubectl exec -it gamma -- nc -w 1 alpha.default.svc 5002
```

```{text}
kubectl run alpha --restart=Never -it --rm --image=alpine --labels=radiation=alpha -- /bin/sh -c 'echo $(nc -w 1 10-244-1-87.default.pod 5000)'
```

These should fail:

```{text}
kubectl exec -it beta -- nc -w 1 alpha.default.svc 5000
```

```{text}
kubectl exec -it beta -- nc -w 1 alpha.default.svc 5002
```

```{text}
kubectl exec -it gamma -- nc -w 1 alpha.default.svc 5001
```

```{text}
kubectl run alpha --restart=Never -it --rm --image=alpine --labels=radiation=alpha -- /bin/sh -c 'echo $(nc -w 1 10-244-1-203.default.pod 5000)'
```

