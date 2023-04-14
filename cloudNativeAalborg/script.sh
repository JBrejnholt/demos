cd /Users/jinhong_brejnholt/Git/GitHub/demos/kyverno
# k create ns kyverno
helm install -f values.yaml -f values-demo.yaml kyverno -n kyverno .

# sync secret
cd /Users/jinhong_brejnholt/Git/GitHub/demos/cloudNativeAalborg/postgres-operator
helm install -f values.yaml postgres-operator .

k create secret generic psql-backup-creds --from-literal=postgres-user=super-user --from-literal=password=abcdef12345 -n default
k apply -f sync-secret/sync-postgres-cluster-secrets.yml
k apply -f sync-secret/p-cluster.yaml

# pdb validation
cd /Users/jinhong_brejnholt/Git/GitHub/demos/cloudNativeAalborg/pdb-validation
k apply -f verify-pdb-configuration.yaml
k apply -f pdbs.yaml
k apply -f bad-busybox-min.yaml
k apply -f good-busybox-max.yaml

# bare pod clean up
cd /Users/jinhong_brejnholt/Git/GitHub/demos/cloudNativeAalborg/cleanup
k apply -f cleanup-bare-pod.yaml
k apply -f nginx-bare.yaml
