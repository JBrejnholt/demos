# From Policy definition to live enforcement

## Create a cluster

```shell
kind create cluster --image "kindest/node:v1.26.0" --config - <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
  - role: worker
  - role: worker
EOF
```

## Deploy kyverno

```shell
helm upgrade --install --wait --timeout 15m --atomic \
  --version 3.0.0-alpha.2 \
  --namespace kyverno --create-namespace \
  --repo https://kyverno.github.io/kyverno kyverno kyverno
```

## Create a policy

```shell
kubectl apply -f - <<EOF
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
 name: require-labels
spec:
 validationFailureAction: Enforce
 background: true
 rules:
   - name: require-team
     match:
       any:
         - resources:
             kinds:
               - Pod
     validate:
       message: 'The label `team` is required.'
       pattern:
         metadata:
           labels:
             team: '?*'
EOF
```

## Create a pod without the team label

```shell
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
  - name: nginx
    image: nginx
EOF
```

## Create the same pod with the team label

```shell
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: mypod
  labels:
    team: myteam
spec:
  containers:
  - name: nginx
    image: nginx
EOF
```
