## DNS Examples

### SUSE CaaSP 4.1

Cluster is a 1 master with 2 workload nodes.

```{text}
$ kubectl -n kube-system get all -l k8s-app=kube-dns -o wide --show-labels
NAME                           READY   STATUS    RESTARTS   AGE   IP             NODE      NOMINATED NODE   READINESS GATES   LABELS
pod/coredns-69c4947958-9v2h9   1/1     Running   7          12d   10.244.0.34    master0   <none>           <none>            k8s-app=kube-dns,pod-template-hash=69c4947958
pod/coredns-69c4947958-vxqdz   1/1     Running   7          12d   10.244.0.115   master0   <none>           <none>            k8s-app=kube-dns,pod-template-hash=69c4947958

NAME               TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE   SELECTOR           LABELS
service/kube-dns   ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   12d   k8s-app=kube-dns   k8s-app=kube-dns,kubernetes.io/cluster-service=true,kubernetes.io/name=KubeDNS

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS   IMAGES                                     SELECTOR           LABELS
deployment.apps/coredns   2/2     2            2           12d   coredns      registry.suse.com/caasp/v4/coredns:1.3.1   k8s-app=kube-dns   k8s-app=kube-dns

NAME                                 DESIRED   CURRENT   READY   AGE   CONTAINERS   IMAGES                                     SELECTOR                                        LABELS
replicaset.apps/coredns-69c4947958   2         2         2       12d   coredns      registry.suse.com/caasp/v4/coredns:1.3.1   k8s-app=kube-dns,pod-template-hash=69c4947958   k8s-app=kube-dns,pod-template-hash=69c4947958
```

```{text}
$ kubectl -n kube-system get ep kube-dns
NAME       ENDPOINTS                                                    AGE
kube-dns   10.244.0.115:53,10.244.0.34:53,10.244.0.115:53 + 3 more...   12d
```

### Testing Pod

`testpod.yaml` defines a Pod `testpod` in the default namespace containing a `busybox`, `alpine`, and
an `nginx` containers.  The shell containers share an `emptyDir` at `/srv/scratchpad` which is also
mounted at `/usr/share/nginx/html` within the `nginx` container.

```{text}
$ kubectl exec -it testpod -c busybox -- cat /etc/resolv.conf
search default.svc.cluster.local svc.cluster.local cluster.local
nameserver 10.96.0.10
options ndots:5
```

### ClusterIP Services

`exposed-deployment.yaml` provides a Deployment `my-app` running three Pods exposing port 80 behind
a service `my-app` all inside the defined Namespace `testverse`.

```{text}
$ kubectl -n testverse get pods -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP            NODE      NOMINATED NODE   READINESS GATES
my-app-6dc85749cf-7z6vt   1/1     Running   0          74m   10.244.2.40   worker1   <none>           <none>
...
```

#### Services

* `my-app.testverse`
* `my-app.testverse.svc`
* `my-app.testverse.svc.cluster.local`

#### Pods

* `10-244-2-40.testverse.pod`
* `10-244-2-40.testverse.pod.cluster.local`

### Headless Services

TODO
