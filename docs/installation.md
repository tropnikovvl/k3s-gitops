## :construction: Installation

Create namespace
```bash
kubectl create namespace flux-system
```

Add SOPS private key
```bash
cat ~/.config/sops/age/keys.txt |
    kubectl -n flux-system create secret generic sops-age \
    --from-file=age.agekey=/dev/stdin
```

Install Flux
```bash
kubectl apply --kustomize=./cluster/base/flux-system
```

Enable k3s upgrades (if not already done by ansible)
```bash
kubectl label node --all k3s-upgrade=true
```