# Observability
---

Istio exposes metrics about your application.

If you curl to the istio-proxy container and run curl `localhost:15020/stats/prometheus` you'll get a bunch of prometheus metrics.

In this directory we show how to use the Telemetry API to customize these metrics - remove metrics, customize their labels.

See in our Google Docs all about it
