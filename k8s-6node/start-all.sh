#!/bin/bash

KVM_DOMAINS=$(cat ./kvm-domains)

for k8sdom in ${KVM_DOMAINS}; do
	virsh start --domain $k8sdom
done

