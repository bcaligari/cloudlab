#!/bin/bash

ANSIBLE_HOST_KEY_CHECKING=false

ansible all -i inventory.yaml -m shell -a "cat /sys/class/dmi/id/product_uuid" --become
