#!/bin/bash -x
PATH=${HOME}/miniconda3/condabin:${HOME}/bin:/usr/local/bin:/usr/bin:/bin
source ${HOME}/miniconda3/etc/profile.d/conda.sh
conda activate dev
rm -rf artifacts
rm -rf packer_cache
sudo ip neigh flush dev br0
packer build -machine-readable leap152.pkr.hcl
