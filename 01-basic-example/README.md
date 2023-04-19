# Basic example
---

In this basic example, we have the `lucky-number` application, which receives 
requests from the user, and calls the `generator` application to receive a number,
and returns a message such as "Your lucky number is 12"

The `generator` application has 2 version: v1 and v2. v1 returns numbers between 1-100
and v2 returns numbers between 100-1000.

In this example we demonstrate the use of `VirtualService` and `DestinationRule`.

We create a `DestinationRule` for the `generator` service, which defines two _subsets_,
one for each version.

The virtual service splits the traffic so that 90% will go to v1, and 10% to v2.
However, requests with the header: `cookie: user=dev-123` will be routed to v2.

## Usage
Apply the `deployment.yaml` file, which will create a namespace and all the basic
kubernetes objects - Deployments and Services.

Then, apply the `destinationrule.yaml` and `virtaulservice.yaml` files to deploy the Istio
configuration.

Also, apply the `debug-pod.yaml`

## Test
Log in to the `debug` pod:

```
$ kubectl exec -it -n lucky-number-app debug
$ curl lucky-number
Your lucky number is.. 1

# if you run it a lot of times, you'll notice that only once in about 10 times
# you'll get a number between 100-1000

$ curl -H "cookie: user=dev-123" generator:5000
234

# with this header, you'll always get a three-digit number
```

## Cleanup

```
$ kubectl delete ns lucky-number-app
```

