#!/bin/bash

create() {
    kubectl create ns foo
    kubectl label namespace/foo istio-injection=enabled
    kubectl create ns bar
    kubectl label namespace/bar istio-injection=enabled
    kubectl -n foo apply -f deployment.yaml
    kubectl -n bar apply -f deployment.yaml
    kubectl create ns legacy
    kubectl -n legacy apply -f deployment.yaml
}

destroy() {
    kubectl delete ns foo
    kubectl delete ns bar
    kubectl delete ns legacy
}

curl_matrix() {
    for from in "foo" "bar" "legacy"; do 
        for to in "foo" "bar" "legacy"; do
            pod=$(kubectl get pod -l app=sleep -n ${from} -o jsonpath={.items..metadata.name})
            kubectl exec $pod -c sleep -n ${from} -- curl -s "http://httpbin.${to}:8000/ip" -s -o /dev/null -w "sleep.${from} to httpbin.${to}: %{http_code}\n"; 
        done; 
    done

}
