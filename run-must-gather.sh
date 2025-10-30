#!/bin/bash

rm -rf must-gather-output
docker run --rm -it   --privileged  --network=host   -v ${KUBECONFIG}:/root/.kube/config:ro \
   -v $(pwd)/must-gather-output:/must-gather:z   -e KUBECONFIG=/root/.kube/config \
  docker.io/aussie4005/must-gather:ubi \
  oc adm must-gather --image=docker.io/aussie4005/must-gather:ubi --dest-dir=/must-gather
sudo chown -R $USER:$USER must-gather-output
