# Observability research
---

This client and server deployments help us to investigate how Istio publishes metrics.
The `spring-boot-demo` app is from https://github.com/yoav-klein/docker-images/tree/main/spring-boot-app.

NOTE: there are also annotations for Datadog agent to scrape OpenMetrics metrics published by Spring, but you can ignore that.

## Usage
---

Deploy:
```
$ kubectl apply -f .
```

Run
```
$ kubectl get po -l app=client-pod
$ kubectl exec -it <pod_name> -- bash
$ curl spring-boot-demo-svc/delay?ms=200
```

Deliberately split the names of the Deployment, the pod labels and the Service, to see how it affects the 
different tags like `source_workload`, `source_app`, stuff like that.

