#!/bin/bash
#
# Prepare Vagrant boxes for kubernetes. Most of this it taken directly from kubernetes documentation:
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
#
# Kubernetes version 1.28
#

echo "Getting node ready for kubernetes..."

# Need some stuff to get started
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl


# Dir needs to exist for next command
sudo mkdir -m 755 -p /etc/apt/keyrings/


# k8s repo
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update


# Need a CRI along with k8s tools, I'll use containerd
sudo apt-get install -y kubelet kubeadm kubectl containerd


# Required kernel module and tuning
echo br_netfilter | sudo tee /etc/modules-load.d/k8s.conf
sudo modprobe br_netfilter
echo "net.ipv4.ip_forward=1" | sudo tee /etc/sysctl.d/11-k8s.conf && sudo sysctl -p /etc/sysctl.d/11-k8s.conf
