### Init Containers

* They are executed in sequence.
* `initContainers` *should* be idempotent.
* Pod placement resource requirements is the highest amongst the individual `initContainers` and the aggregate of the `containers`.
