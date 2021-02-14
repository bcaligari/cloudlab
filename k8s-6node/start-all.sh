#!/bin/bash

. cluster.conf

for k8sdom in $(cat ${KVM_DOMAINS}); do
	virsh start --domain $k8sdom
done

