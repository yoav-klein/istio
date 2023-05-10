# Peer Authentication
---

Peer Authentication is used for authentication between workloads within the mesh.
Istio uses mutual TLS for peer authentication.

In this demo, we apply the `httpbin` and `sleep` deployments to 3 namespaces: `foo`, `bar` and `legacy`.
Namesaces `foo` and `bar` are Istio-enabled, so that the workloads will run with Envoy proxies sidecars.
The `legacy` namespace is not Istio-enabled, so there's no sidecar.


## Set the stage


First, source the `functions.sh` file:
```
$ . functions.sh
```
Now, create the namespaces and resources:
```
$ create
```

Now verify that you can access from any `sleep` pod to any `httpbin` pod:
```
$ curl_matrix
sleep.foo to httpbin.foo 200
sleep.foo to httpbin.bar 200
... # All 200
```

## Default behavior
---
By default, all traffic between services with proxies (i.e. which runs with Envoy proxy) use mutual TLS. Traffic between
services with proxy and workloads without proxy use plaintext traffic.

If you look at the headers of the traffic between the `sleep` and `httpbin` in the `foo` namespace, you'll see the
`X-Forwarded-Client-Cert` header:
```
$ kubectl exec "$(kubectl get pod -l app=sleep -n foo -o jsonpath={.items..metadata.name})" -c sleep -n foo -- curl -s http://httpbin.foo:8000/headers -s
```

But if you run from `sleep.foo` to `httpbin.legacy`, there is no such header:
```
$ kubectl exec "$(kubectl get pod -l app=sleep -n foo -o jsonpath={.items..metadata.name})" -c sleep -n foo -- curl -s http://httpbin.legacy:8000/headers -s
```

## Globally enabling mutual TLS in STRICT mode
---
The default mode of proxies is PERMISSIVE - so it can accept both mutual TLS and plain-text traffic. To prevent non-mTLS traffic
on the whole mesh, set a mesh-wide PeerAuthentication policy with the mode set to STRICT.

Apply the `global-strict.yaml` file:
```
$ kubectl apply -f global-strict.yaml
```

This policy souldn't specify a selector, and should be deployed in the root namespace, which is `istio-system` by default.

Now run the `curl_matrix` function again. You'll see that most calls succeed, except from the ones originating
from legacy to `foo` and `bar`. Remember that authentication policies apply to the server side, not the client side, this
is why calls from `foo` and `bar` to legacy succeed.

### Cleanup
```
$ kubectl delete -f global-strict.yaml
```

## Enable mTLS per namespace or workload
---

### Namespace-scoped
If you want to apply Authentication Policy to all workloads in a namespace, just specify
the namespace in the `PeerAuthentication` resource.

Let's apply the Authentication Policy only to `foo`:

```
$ kubectl apply -f namespace-strict.yaml
$ curl_matrix
```

You'll see that this time the call from `sleep.legacy` to `httpbin.bar` succeeds

### Workload-scoped
You can scope the Authentication Policy to specific workload(s) by using the `selector field`.
Now we'll apply the STRICT mode to the `httpbin` workload in `bar` namespace:

```
$ kubectl apply -f workload-strict.yaml
$ curl_matrix
```

You'll see that now the call from `sleep.legacy` to `httpbin.bar` also fails.

### Cleanup
---
```
$ kubectl delete -f namespace-strict.yaml
$ kubectl delete -f workload-strict.yaml
```

## Cleanup
---
```
$ kubectl delete ns foo
$ kubectl delete ns bar
$ kubectl delete ns legacy
```
