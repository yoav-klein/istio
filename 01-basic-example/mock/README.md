# Mock
---

This example is a result of some investigation.

Think about it, how the flow of traffic routing works?

The `debug` pod sends a request to `generator`. The Envoy proxy of the debug pod looks
at the VirtualService say "oh, this is for the one of the hosts in the VirtualService. Let's apply the rules
of this VirtualService on this request". Then, it applies the rules of the VirtualService to whatever destination.

In this case, we create a mock service, called `mock`, which doesn't route traffic to anywhere, and change
the `hosts` field in the virtual service to `mock.lucky-numberapp.svc.cluster.local`. Now what will happen?
The same ! The Envoy proxy will capture the traffic, look at the request and say: "Oh, this is for mock.lucky-number-app..
so I need to apply the rules on it" and will route the traffic to the `generator` service.
