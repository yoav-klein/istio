# Ambient mode
---

Ambient mode is an alternative for the older "sidecar mode". In sidecar mode, you have sidecar container running in each pod. In ambient mode, there are central components running in the cluster that enable the istio features.

## Setup
1. Deploy the Gateway API: 
```
kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
kubectl apply --server-side -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.6.1/experimental-install.yaml
```

2. You need to install istio in ambient mode: `istioctl install --set profile=ambient`

## Create the demo application
In this example we create a demo application, `generator`, which generates numbers. There are 2 versions of this application: v1 generates numbers lower than 100, and v2 generates numbers between 100-1000.
We create 2 Deployments, one for each version, and 2 Services accordingly.

Apply the Deploynent and Service objects with `kubectl apply -f deployment.yaml`.
Then, in the `lucky-number-app` namespace (kubens), run: `istioctl waypoint apply --enroll-namespace --wait`.

This creates the waypoint proxy (which is a Deployment and Service) for the namespace. This enables Layer 7 features of Istio in the namespace.

## Create the HTTPRoute
The `HTTPRoute` object in `httproute.yaml` creates the same logic as the VirtualService in the `01-basic` example. Requests to `generator` will distribute traffic to the v1 and v2 in a 90/10 ratio, and requests with the `user=john" header will route to v2.

## Notes
* You must have a Service `generator` for the HTTPRoute to work. This service doesn't have to actually point to any pod, but it must be there.
* Unlike with the VirtualService API, you must have a Service object for each subset of the application. In the VirtualService API, the DestinationRule was enough, you didn't have to have a Service for v1 and v2.

