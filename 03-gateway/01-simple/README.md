# Gateway - simple example
---

In this example we run the `httpbin` application using a Deployment and Service.
We want this to be accessible from outside the cluster. For this, we create a 
`Gateway` resource, that is configured to listen for connections to host `httpbin.example.com`
on port 80.
The Gateway specifies the labels of the deafult `istio-ingressgateway` so that the later will apply
the configuration of this Gateway.

Then, we have a `VirtualService` which speicifies our Gateway in its `gateways` field, so that 
the routes configured in it will be applied to the Envoy proxy of our Gateway.


## Usage
---
Apply the configurations:
```
$ kubectl apply -f .
```

## Test
---

Run from any machine:
```
$ curl -H "Host: httpbin.example.com" -s -I <lb-domain-name>:80/status/203
```


