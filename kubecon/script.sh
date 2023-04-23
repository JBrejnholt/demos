#!/bin/bash

cd /Users/jinhong_brejnholt/Git/GitHub/demos/kyverno
# k create ns kyverno
k apply -f secret-demo.yaml
helm install -f values.yaml -f values-demo.yaml kyverno -n kyverno .

# cosign
cd /Users/jinhong_brejnholt/Git/GitHub/demos/kubecon
k apply -f verify-image-kv.yaml
k run bad-busy --image=jinbcr.azurecr.io/bad-busy:1.34.0 --command sleep 30
k run good-busy --image=jinbcr.azurecr.io/good-busy:1.34.0 --command sleep 30
