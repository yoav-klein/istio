#!/bin/bash

export SOURCE_POD=$(kubectl -n demo get pod -l app=sleep -o jsonpath='{.items..metadata.name}')

kubectl exec "$SOURCE_POD" -c sleep -- time curl -o /dev/null -sS -w "%{http_code}\n" http://httpbin.org/delay/5


