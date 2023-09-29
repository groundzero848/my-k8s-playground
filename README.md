# my-k8s-playground

Using vagrant and virtualbox on an ubuntu 20.04 micropc to build up a test k8s environment. I'm a n00b to vagrant and will keep this as simple as possible as my time is to be spent on k8s rather than the underlying infrastructure.

```
On host, install virtual box and vagrant:

$ sudo apt update && sudo apt upgrade
$ sudo apt install virtualbox vagrant -y

...

Bring up control plane node, initialize, and install CNI

$ cd k8s-clu1-cp1
$ vagrant up
$ vagrant ssh
$ sudo kubeadm init --cri-socket=unix:///var/run/containerd/containerd.sock --apiserver-advertise-address=192.168.60.101
$ kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s-1.11.yaml

...

Bring up worker node

$ cd k8s-clu1-wk1
$ vagrant up

Follow kubernetes docs to join the cluster.
```

SSH Port Forwarding

```
My host is on another computer on the network, so I use this for convenience to ssh into my cluster nodes.

k8s-clu1-cp1 is forwarded to 2022 on the host.
k8s-clu1-wk1 is forwarded to 2122 on the host.
```
