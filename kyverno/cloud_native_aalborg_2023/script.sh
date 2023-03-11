pushd kyverno
k create ns kyverno
k apply -f secret-demo.yaml
helm install -f values.yaml -f values-demo.yaml kyverno -n kyverno .
popd

# cosign
k apply -f cosign/verify-image-signature.yaml
k run bad-busy --image=ghcr.io/jbrejnholt/cosign-demo/busybox-unsigned:1.34.1
k run good-busy --image=ghcr.io/jbrejnholt/cosign-demo/busybox-signed:1.36.0

# sync secret
pushd postgres-operator
helm install -f values.yaml postgres-operator .
popd

k create secret generic psql-backup-creds --from-literal=postgres-user=super-user --from-literal=password=abcdef12345 -n default
k apply -f sync-secret/sync-postgres-cluster-secrets.yml
k apply -f sync-secret/p-cluster.yaml

pushd pdb-validation
# pdb validation
k apply -f verify-pdb-configuration.yaml
k apply -f pdbs.yaml
k apply -f bad-busybox-min.yaml
k apply -f good-busybox-max.yaml

popd
