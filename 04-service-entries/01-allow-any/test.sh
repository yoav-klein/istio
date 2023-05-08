#!/bin/bash

export SOURCE_POD=$(kubectl -n demo get pod -l app=sleep -o jsonpath='{.items..metadata.name}')

echo $SOURCE_POD

kubectl exec -n demo "$SOURCE_POD" -c sleep -- curl -sSI https://www.google.com | grep  "HTTP/"
kubectl exec -n demo "$SOURCE_POD" -c sleep -- curl -sI https://edition.cnn.com | grep "HTTP/"

