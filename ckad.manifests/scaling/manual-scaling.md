## ReplicaSets

* `kubectl create -f simplest-replicaset.yaml`
* `kubectl edit rs my-app`
* `kubectl patch rs my-app -p '{"spec":{"replicas":4}}'`
* `kubectl scale rs my-app --replicas=2`


## Deployments

* `kubectl create -f simplest-deployment.yaml`
* `kubectl scale deployment --replicas=4 my-app`
* `kubectl get deployments.apps my-app -o jsonpath='{.metadata.generation}'`


## Notes

* `generation` field will be updated
* `kubectl get rs my-app -o jsonpath='{.metadata.generation}'`
