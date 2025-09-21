# Distributed Tracing
---

We have a `client`, `frontend` and `backend` applications.
The client calls frontend, and frontend calls backend.

We want to see how Istio publishes distributed tracing.

## Configuration
---

### Deploy jaeger
---

```
$ kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.27/samples/addons/jaeger.yaml
```

### Run Jaeger dashboard
---

```
$ istioctl dashboard jaeger
```

### MeshConfig
We need to configure the jaeger service as the tracing backend (as type OpenTelemetry)

```
data:
  mesh: |-
    defaultConfig:
      discoveryAddress: istiod.istio-system.svc:15012
    defaultProviders:
      metrics:
      - prometheus
    enablePrometheusMerge: true
    rootNamespace: istio-system
    trustDomain: cluster.local
    enableTracing: true
    defaultConfig:
      tracing: {} # disable legacy MeshConfig tracing options
    extensionProviders:
    - name: jaeger
      opentelemetry:
        port: 4317
        service: jaeger-collector.istio-system.svc.cluster.local

```

### Telemetry API

Tell Istio to send traces to the Jaeger backend
```
kubectl apply -f - <<EOF
apiVersion: telemetry.istio.io/v1
kind: Telemetry
metadata:
  name: mesh-default
  namespace: istio-system
spec:
  tracing:
  - providers:
    - name: jaeger
EOF
```

## Usage

Run the application

```
$ kubectl apply -f deployment.yaml
```

You should see the traces in jaeger

## Notes

Note that in order for the backend to combine the spans into traces, there are headers that needs to be passed around your services.
Note that in the frontend we read the `x-request-id`, `traceparent` and `tracestate` headers and pass them.

See https://istio.io/latest/docs/tasks/observability/distributed-tracing/overview/

