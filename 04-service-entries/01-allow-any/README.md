# Allow outbound traffic
---

In this example, Istio should be configured with the `.meshConfig.outboundTrafficPolicy.mode` to `ALLOW_ANY`.

This allows any outbound traffic.

Make sure Istio is configured as such:

```
$ kubectl get istiooperator installed-state -n istio-system -o jsonpath='{.spec.meshConfig.outboundTrafficPolicy.mode}'
```

Now try accessing external services:
```
$ test.sh
```

