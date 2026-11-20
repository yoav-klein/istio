# Ambient mode
---

Ambient mode is an alternative for the older "sidecar mode". In sidecar mode, you have sidecar container running in each pod. In ambient mode, there are central components running in the cluster that enable the istio features.

## Setup
Use the terraform code to install Istio in ambient mode.
It will also install the Gateway API CRDs, and a waypoint.


## Create the demo application
In this example we create a demo application, `generator`, which generates numbers. There are 2 versions of this application: v1 generates numbers lower than 100, and v2 generates numbers between 100-1000.
We create 2 Deployments, one for each version, and 2 Services accordingly.

We label the namespace with the following labels:
```
istio.io/dataplane-mode: ambient
istio.io/use-waypoint: waypoint
```

The first label will enroll all the workloads in the namespace to be part of the ambient mesh. The second will configure all the services in the namespace to use the waypoint we created using terraform.

Apply the Deploynent and Service objects with `kubectl apply -f deployment.yaml`.

## Create the HTTPRoute
The `HTTPRoute` object in `httproute.yaml` creates the same logic as the VirtualService in the `01-basic` example. Requests to `generator` will distribute traffic to the v1 and v2 in a 90/10 ratio, and requests with the `user=john" header will route to v2.

## Test
Apply the `debug-pod.yaml`, and run:
```
$ kubectl exec -it debug -- bash
$ curl generator
# run many times, you'll should have a >100 number every ~10 times

$curl -Huser:john generator
# you should get a >100 every time

```


## Notes
* You must have a Service `generator` for the HTTPRoute to work. This service doesn't have to actually point to any pod, but it must be there.
* Unlike with the VirtualService API, you must have a Service object for each subset of the application. In the VirtualService API, the DestinationRule was enough, you didn't have to have a Service for v1 and v2.

