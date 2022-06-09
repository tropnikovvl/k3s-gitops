#/bin/bash
echo "Create flux-system namespace"
kubectl create ns flux-system

echo "Create flux secret"
cat ~/.config/sops/age/keys.txt | kubectl -n flux-system create secret generic sops-age \
    --from-file=age.agekey=/dev/stdin

echo "Deploy Cluster"
kubectl apply --kustomize=~/devops/k3s-gitops/cluster/base/flux-system
