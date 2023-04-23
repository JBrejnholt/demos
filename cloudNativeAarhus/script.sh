#!/bin/bash
cd /Users/jinhong_brejnholt/Git/GitHub/demos/kyverno
k create ns kyverno
helm install -f values.yaml -f values-demo.yaml kyverno -n kyverno .

# pdb validation
cd /Users/jinhong_brejnholt/Git/GitHub/cloudNativeAarhus/pdb-validation
k apply -f verify-pdb-configuration.yaml
k apply -f pdbs.yaml
k apply -f bad-busybox-min.yaml
k apply -f good-busybox-max.yaml

# bare pod clean up
cd /Users/jinhong_brejnholt/Git/cloudNativeAarhus/cleanup
k apply -f cleanup-bare-pod.yaml
k apply -f nginx-bare.yaml
