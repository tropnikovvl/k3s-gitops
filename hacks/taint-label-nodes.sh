#/bin/bash

echo "Label Node for system-upgrade-controller"
kubectl label node --all k3s-upgrade=true

echo "Taint node for NoSchedule"
kubectl taint --overwrite node k3s-01 node-role.kubernetes.io/master=true:NoSchedule
kubectl taint --overwrite node k3s-02 node-role.kubernetes.io/master=true:NoSchedule
kubectl taint --overwrite node k3s-rpi-01 arch=arm64:NoSchedule
kubectl taint --overwrite node k3s-rpi-02 arch=arm64:NoSchedule
kubectl taint --overwrite node k3s-rpi-03 arch=arm64:NoSchedule

echo "Label worker nodes"
kubectl label --overwrite node k3s-04 node-role.kubernetes.io/worker=true
kubectl label --overwrite node k3s-05 node-role.kubernetes.io/worker=true
kubectl label --overwrite node k3s-rpi-01 node-role.kubernetes.io/worker=true
kubectl label --overwrite node k3s-rpi-02 node-role.kubernetes.io/worker=true
kubectl label --overwrite node k3s-rpi-03 node-role.kubernetes.io/worker=true
