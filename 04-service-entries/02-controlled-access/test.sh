#!/bin/bash

export SOURCE_POD=$(kubectl -n demo get pod -l app=sleep -o jsonpath='{.items..metadata.name}')

echo "Accessing HTTP service..."
kubectl exec -n demo "$SOURCE_POD" -c sleep -- curl  -sS http://httpbin.org/headers

echo "Accessing HTTPS service..."
kubectl exec -n demo "$SOURCE_POD" -c sleep -- curl -sSI https://www.google.com | grep  "HTTP/"


