#!/bin/bash

KVM_DOMAINS=$(cat ./kvm-domains)

if [ -z "$1" ]
then
	echo Usage: $0 SNAPSHOT
	exit 1
fi

SNAPSHOT="$1"

for k8sdom in ${KVM_DOMAINS}; do
	virsh -d 1 snapshot-revert \
		--domain $k8sdom \
		$SNAPSHOT
done

