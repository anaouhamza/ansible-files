#!/bin/bash

echo "=== Arrêt et suppression des VMs ==="
for vm in $(virsh list --name); do
  echo "Stopping and undefining VM: $vm"
  virsh destroy "$vm"
  virsh undefine "$vm" --remove-all-storage
done

echo "=== Suppression des réseaux sauf 'default' ==="
for net in $(virsh net-list --name | grep -v '^default$'); do
  echo "Destroying and undefining network: $net"
  virsh net-destroy "$net"
  virsh net-undefine "$net"
done

echo "=== Suppression des fichiers dans le rep /var/lib/libvirt/images  ==="
sudo rm -rf /var/lib/libvirt/images/{bastion,bastion-node,compute,compute-node,controller,controller-node,network,network-node,storage,storage-node}

echo "=== Suppression des xml de networks  ==="
sudo rm /home/anaou/virbr1.xml /home/anaou/virbr2.xml /home/anaou/virbr3.xml /home/anaou/virbr4.xml


echo "=== Terminé ==="
