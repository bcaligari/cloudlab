#!/bin/bash

ANSIBLE_HOST_KEY_CHECKING=false

ansible all -i inventory.yaml -m community.general.shutdown --become
