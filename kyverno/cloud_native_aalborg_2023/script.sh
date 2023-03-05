k create ns kyverno
k apply -f secret-demo.yaml
helm install -f values.yaml -f values-demo.yaml kyverno -n kyverno .
k run bad-busy --image=ghcr.io/jbrejnholt/cosign-demo/busybox-unsigned:1.34.1
k run good-busy --image=ghcr.io/jbrejnholt/cosign-demo/busybox-signed:1.36.0