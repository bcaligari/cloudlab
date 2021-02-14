#!/bin/bash -x

. cluster.conf

SNAPSHOT="sudo"

for k8sdom in $(cat ${KVM_DOMAINS}); do
	virsh snapshot-revert \
		--domain $k8sdom \
		$SNAPSHOT
done

