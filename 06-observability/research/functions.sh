#!/bin/bash

function send_requests_constant() {
    while $true; do send_request; done
}

function send_request() {
    kubectl exec client -- curl server/delay/200
}

function get_metrics() {
    pod_name=$(kubectl get po -l app=httpbin -ojsonpath={.items[0].metadata.name})
    kubectl exec $pod_name -c istio-proxy -- curl -s localhost:15020/stats/prometheus
}

function reset() {
    kubectl delete -f httpbin.yaml
    kubectl apply -f httpbin.yaml
}

function scenario() {
    
}
