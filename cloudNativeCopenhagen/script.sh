#!/bin/bash
cd /Users/JINB/git/demos/kyverno
k create ns kyverno
helm install -f values.yaml -f values-demo.yaml kyverno -n kyverno .

# pdb validation
cd /Users/JINB/git/demos/cloudNativeCopenhagen/pdb-validation
k apply -f verify-pdb-configuration.yaml
k apply -f pdbs.yaml
k apply -f bad-busybox.yaml
k apply -f good-busybox.yaml

# bare pod clean up
cd /Users/JINB/git/demos/cloudNativeCopenhagen/cleanup
k apply -f cleanup-bare-pod.yaml
k apply -f nginx-bare.yaml
