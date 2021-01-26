## Rollouts

Create deployment

```{text}
kubectl create -f simple-app.yaml
```

Get rollout history

```{text}
kubectl rollout history deployment.apps/my-app
```

Make some changes, such as to sleep delay

```{text}
kubectl edit deployment.apps/my-app
```

or, to update the 'change cause'

```{text}
kubectl edit deployment.apps/my-app --record
```

Check rollout changes

```{text}
kubectl rollout history deployment.apps/my-app
```

```{text}
kubectl rollout history deployment.apps/my-app --revision=2
```

To rollback

```{text}
kubectl rollout undo deployment.apps/my-app --to-revision=2
```
