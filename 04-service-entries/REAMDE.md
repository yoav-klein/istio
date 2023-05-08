
# Service Entry
---

You can control how your mesh services access external services with Istio.
The default configuration of Istio is to allow any outbound traffic.

Using a `ServiceEntry` resource, you can apply Istio features to external services
which are not part of your service mesh.

This examples here are based on the Docs page:
https://istio.io/latest/docs/tasks/traffic-management/egress/egress-control/


