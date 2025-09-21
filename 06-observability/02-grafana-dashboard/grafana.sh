#!/bin/bash
#

istio_version=1.27
# Install grafana

kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-${istio_version}/samples/addons/grafana.yaml

# install prometheus
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-${istio_version}/samples/addons/prometheus.yaml



istioctl dashboard grafana --address="0.0.0.0"
