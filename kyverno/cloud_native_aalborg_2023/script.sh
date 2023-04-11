cd /Users/jinhong_brejnholt/Git/GitHub/demos/kyverno/cloud_native_aalborg_2023/kyverno
# k create ns kyverno
k apply -f secret-demo.yaml
helm install -f values.yaml -f values-demo.yaml kyverno -n kyverno .

# cosign
cd /Users/jinhong_brejnholt/Git/GitHub/demos/kyverno/cloud_native_aalborg_2023/cosign
k apply -f verify-image-kv.yaml
k run bad-busy --image=jinbcr.azurecr.io/bad-busy:1.34.0
k run good-busy --image=jinbcr.azurecr.io/good-busy:1.34.0 --command sleep 30

# sync secret
cd /Users/jinhong_brejnholt/Git/GitHub/demos/kyverno/cloud_native_aalborg_2023/postgres-operator
helm install -f values.yaml postgres-operator .

k create secret generic psql-backup-creds --from-literal=postgres-user=super-user --from-literal=password=abcdef12345 -n default
k apply -f sync-secret/sync-postgres-cluster-secrets.yml
k apply -f sync-secret/p-cluster.yaml

# pdb validation
cd /Users/jinhong_brejnholt/Git/GitHub/demos/kyverno/cloud_native_aalborg_2023/pdb-validation
k apply -f verify-pdb-configuration.yaml
k apply -f pdbs.yaml
k apply -f bad-busybox-min.yaml
k apply -f good-busybox-max.yaml

# bare pod clean up
cd /Users/jinhong_brejnholt/Git/GitHub/demos/kyverno/cloud_native_aalborg_2023/cleanup
k apply -f cleanup-bare-pod.yaml
k apply -f nginx-bare.yaml
