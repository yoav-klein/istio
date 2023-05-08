# Control access to external services
---

Here we'll see how to configure access to a HTTP service `httpbin.org`, and to a  HTTPS service `google.com`.

## Istio installation
In order to run this demo, you need to install Istio as such:
```
$ istioctl install <flags-you-used-to-install-Istio> \
                   --set meshConfig.outboundTrafficPolicy.mode=REGISTRY_ONLY
```

## Demo

The `test.sh` script calls `http://httpbin.org` (HTTP) and `https://www.google.com` (HTTPS)

First, try to access some external service, and see that you can't:
```
$ kubectl apply -f deployment.yaml
$ ./test.sh
Error code 35
```

Now, deploy the `service-entry.yaml` file, which creates `ServiceEntry` resources for both these services.
Now run again:
```
$ ./test.sh
```







