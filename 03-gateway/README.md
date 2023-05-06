# Gateway
---

A Gateway is a "Load balancer operating at the edge of your mesh".

Basically, if you install istio using the standard way, you have the `istio-ingressgateway` Deployment and Service,
which is kind of like an Ingress Controller just for Gateway resources.

A Gateway resource specifies a list of `servers`, each specifies a port, protocol, and host(s). 
You can use a Gateway to define TLS configuration, redirecting, stuff like that.

Than, you bind VirtualServices to the Gateway so that routing rules will be applied to traffic entering the mesh.

If you're running in a cloud environment, the `istio-ingressgateway` should be exposed as a Load Balancer
Run:
```
$ kubectl -n istio-system get svc istio-ingressgateway
```

You'll be using this IP/DNS name to communicate with your Gateway.

