# Gateway - 2 servers
---

In this example, we have a Gateway configuration with two servers: one for the `numbers` app
and one for the `names` app.

We then have 2 VirtualServices which bind to this Gateway.

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
$ curl -H "Host: numbers.example.com" <lb-domain-name>/number
45
$ curl -H "Host: names.example.com" <lb-domain-name>/name
Bob
```


