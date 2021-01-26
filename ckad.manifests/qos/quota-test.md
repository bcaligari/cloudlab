
Clear namespace and contents.
```{text}
kubectl delete ns testverse
```

Create Namespace, ResourceQuota, and Deployment.
```{text}
kubectl create -f quota-test.yaml
```

List Pods in Namespace.  Only 3 of 5 should be running.
```{text}
kubectl -n testverse get deployments.apps,pods
```

The ResourceQuota should show that the Pods quota limit has been reached.

```{text}
kubectl -n testverse describe resourcequotas austerity
```

The Events and Deployment status should show that attempts were made to create more Pods than allowed.

```{text}
kubectl -n testverse get deployments.apps my-app -o yaml
```

```{text}
kubectl -n testverse get events --field-selector=type!=Normal --sort-by='{.metadata.creationTimestamp}'
```

Patch the ResourceQuota from 3 to 10 Pods.  It may take a while for the Deployment and ReplicaSet controllers to pick up the change and increase the running pods from 3 to 5.

```{text}
kubectl -n testverse patch resourcequotas austerity -p '{"spec":{"hard":{"pods":10}}}'
```

```{text}
kubectl -n testverse describe resourcequotas austerity
```

```{text}
kubectl -n testverse get deployments.apps,pods
```

Scale Deployment to 10 replicas.  Only 9 replicas should be created as a memory as the 10th Pod creation attempt hits memory quota limits.

```{text}
kubectl -n testverse scale deployment.apps my-app --replicas=10
```

```{text}
kubectl -n testverse get deployments.apps,pods
```

```{text}
kubectl -n testverse get events --field-selector=type!=Normal --sort-by='{.metadata.creationTimestamp}'
```

```{text}
kubectl -n testverse get deployments.apps my-app -o yaml
```

```{text}
kubectl -n testverse describe resourcequotas austerity
```

