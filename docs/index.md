# Home Cluster

This repository _is_ my home Kubernetes cluster in a declarative state. [Flux](https://github.com/fluxcd/flux2) watches my [cluster](./cluster/) folder and makes the changes to my cluster based on the YAML manifests.

Feel free to open a [Github issue](https://github.com/onedr0p/home-cluster/issues/new/choose) or join the [k8s@home Discord](https://discord.gg/sTMX7Vh) if you have any questions.

This repository is built off the [k8s-at-home/template-cluster-k3s](https://github.com/k8s-at-home/template-cluster-k3s) repository.


## Cluster components

- [rook-ceph](https://rook.io/): Provides persistent volumes, allowing any application to consume RBD block storage.
- [Mozilla SOPS](https://toolkit.fluxcd.io/guides/mozilla-sops/): Encrypts secrets which is safe to store - even to a public repository.
- [cert-manager](https://cert-manager.io/docs/): Configured to create TLS certs for all ingress services automatically using LetsEncrypt.
- [Kasten](https://www.kasten.io): Data backup and recovery

## Repository structure

The Git repository contains the following directories under `cluster` and are ordered below by how Flux will apply them.

- **base** directory is the entrypoint to Flux
- **crds** directory contains custom resource definitions (CRDs) that need to exist globally in your cluster before anything else exists
- **core** directory (depends on **crds**) are important infrastructure applications (grouped by namespace) that should never be pruned by Flux
- **apps** directory (depends on **core**) is where your common applications (grouped by namespace) could be placed, Flux will prune resources here if they are not tracked by Git anymore

```
./cluster
├── ./apps
├── ./base
├── ./core
└── ./crds
```

## Automate all the things!

- [Github Actions](https://docs.github.com/en/actions) for checking code formatting
- Rancher [System Upgrade Controller](https://github.com/rancher/system-upgrade-controller) to apply updates to k3s
- [Renovate](https://github.com/renovatebot/renovate) with the help of the [k8s-at-home/renovate-helm-releases](https://github.com/k8s-at-home/renovate-helm-releases) Github action keeps my application charts and container images up-to-date

## Hardware

| Device                 | Count | OS Disk Size | Data Disk Size       | Ram  | Purpose                     |
|------------------------|-------|--------------|----------------------|------|-----------------------------|


## Thanks

A lot of inspiration for my cluster came from the people that have shared their clusters over at [awesome-home-kubernetes](https://github.com/k8s-at-home/awesome-home-kubernetes)