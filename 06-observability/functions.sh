#!/bin/bash

function send_request() {
    kubectl exec client -- curl httpbin-service/delay/1
}

function get_metrics() {
    pod_name=$(kubectl get po -l app=httpbin -ojsonpath={.items[0].metadata.name})
    kubectl exec $pod_name -c istio-proxy -- curl -s localhost:15020/stats/prometheus
}

function reset() {
    kubectl delete -f httpbin.yaml
    kubectl apply -f httpbin.yaml
}
