### Getting Started

Ensure you have docker installed on your host and KUBECONFIG env variable is set to the file location for
your cluster's kubeconfig.

Now run ./run-must-gather.sh

A must-gather will be pulled from your cluster and stored in ./must-gather-output

Now to access the cluster as if you were on it, install this tool:

pip3 install o-must-gather --user

You can now set the tool to use the must-gather you just obtained:

omg use ./must-gather-output/must-gather

Example:

```bash
trozet@yard73:~/go/src/github.com/must-gather$ omg use ./must-gather-output/must-gather/
Using:  /home/trozet/go/src/github.com/must-gather/must-gather-output/must-gather
trozet@yard73:~/go/src/github.com/must-gather$ omg get nodes -o wide
NAME               STATUS  ROLES          AGE  VERSION  INTERNAL-IP            EXTERNAL-IP  OS-IMAGE                        KERNEL-VERSION           CONTAINER-RUNTIME
ovn-worker         Ready                  1d   v1.33.1  fc00:f853:ccd:e793::4  <none>       Debian GNU/Linux 12 (bookworm)  6.16.11-200.fc42.x86_64  containerd://2.1.1
ovn-worker2        Ready                  1d   v1.33.1  fc00:f853:ccd:e793::2  <none>       Debian GNU/Linux 12 (bookworm)  6.16.11-200.fc42.x86_64  containerd://2.1.1
ovn-control-plane  Ready   control-plane  1d   v1.33.1  fc00:f853:ccd:e793::3  <none>       Debian GNU/Linux 12 (bookworm)  6.16.11-200.fc42.x86_64  containerd://2.1.1
trozet@yard73:~/go/src/github.com/must-gather$ 
```

You can now interact using most kubectl commands by substituting "kubectl" with "omg":

```bash
trozet@yard73:~/go/src/github.com/must-gather$ omg get pods -n ovn-kubernetes
NAME                                    READY  STATUS   RESTARTS  AGE
ovnkube-control-plane-6d96f68f47-cv995  1/1    Running  0         1d
ovnkube-identity-6qr75                  1/1    Running  0         1d
ovnkube-node-hpvwv                      6/6    Running  0         1d
ovnkube-node-z99sf                      6/6    Running  0         1d
ovnkube-node-zmqg6                      6/6    Running  0         1d
ovs-node-8w8dd                          1/1    Running  0         1d
ovs-node-9xvcs                          1/1    Running  0         1d
ovs-node-cwqdp                          1/1    Running  0         1d
```

You can also view logs of a pod:

```bash
trozet@yard73:~/go/src/github.com/must-gather$ omg logs -n ovn-kubernetes ovs-node-cwqdp | tail -n 5
2025-10-29T16:37:11.653703580Z 2025-10-29T16:37:11.653Z|84230|connmgr|INFO|breth0<->unix#40176: 1 flow_mods in the last 0 s (1 deletes)
2025-10-29T16:37:11.674145662Z 2025-10-29T16:37:11.673Z|84231|connmgr|INFO|breth0<->unix#40179: 1 flow_mods in the last 0 s (1 adds)
2025-10-29T16:37:11.689611196Z 2025-10-29T16:37:11.689Z|84232|connmgr|INFO|breth0<->unix#40182: 1 flow_mods in the last 0 s (1 deletes)
2025-10-29T16:37:11.705568979Z 2025-10-29T16:37:11.705Z|84233|connmgr|INFO|breth0<->unix#40185: 1 flow_mods in the last 0 s (1 adds)
```

To access OVN databases, go to './must-gather-output/must-gather/network_logs':

```bash
trozet@yard73:~/go/src/github.com/must-gather$ ls must-gather-output/must-gather/network_logs/
cluster_scale  ippools.whereabouts.cni.cncf.io  multi-networkpolicy  net-attach-def  overlappingrangeipreservations.whereabouts.cni.cncf.io  ovnk_database_store.tar.gz  ovn_kubernetes_top_pods
```

Here you can find the databases tarball. You can extract them and them launch them on your own host.
Additionally, there are other useful files here. cluster_scale shows how many objects were active at the time
of the must-gather collection:

```bash
trozet@yard73:~/go/src/github.com/must-gather$ cat  must-gather-output/must-gather/network_logs/cluster_scale 
endpoints amount: 2
network policies amount: 0
services amount: 2
pods amount: 18
```

