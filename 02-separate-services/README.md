# Separate Services
---
In this example, we demonstrate how one VirtualService can route traffic to completely different services.
The Service `content-generator` is the user-addressable address that the user uses, and the VirtualService routes
the traffic based on the URL to two services (each with 2 versions) - names generator and numbers generator.
