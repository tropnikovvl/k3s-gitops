#/bin/bash

# cleanup old image
qm destroy 9000
rm -rf /tmp/bionic-server-cloudimg-amd64.img
# get cloud image
wget -P /tmp https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img

# Inject qemu-guest-agents
virt-customize -a /tmp/bionic-server-cloudimg-amd64.img --install qemu-guest-agent

# Create Image
qm create 9000 --name "ubuntu-2004-cloudinit-template" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk 9000 /tmp/bionic-server-cloudimg-amd64.img nvme02
qm set 9000 --scsihw virtio-scsi-pci --scsi0 nvme02:vm-9000-disk-0
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --ide2 nvme02:cloudinit
qm set 9000 --serial0 socket --vga serial0
qm set 9000 --agent enabled=1

# Convert to template
qm template 9000
