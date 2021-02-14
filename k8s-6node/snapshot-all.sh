#!/bin/bash -x

. cluster.conf

SNAPSHOT="sudo"

for k8sdom in $(cat ${KVM_DOMAINS}); do
	virsh snapshot-create-as \
		--domain $k8sdom \
		--name $SNAPSHOT
done

