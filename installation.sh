#!/bin/bash

curl -L https://istio.io/downloadIstio | bash -

# make sure istioctl is in your PATH

# you don't have to use the demo profile, but its good for testing
istioctl install --set profile=demo

# label the default namespace so that the Envoy proxy containers
# will be injected to each pod

kubectl label namespace default istio-injection=enabled
