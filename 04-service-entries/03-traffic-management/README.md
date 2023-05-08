# Traffic management for external services
---

Just as for internal services, you can apply traffic management rules to external services that 
are defined as `ServiceEntry`s.

In this example, we define a timeout rule for `httpbin.org`.

First, apply the YAMLs except the `virtual-service.yaml` file.
Then, run the `test.sh` file. You should get a response after about 4 seconds:

```
$ ./run.sh
200
real    0m 8.92s
user    0m 0.00s
sys     0m 0.00s
```

Now, apply the Virtual Service:
```
$ kubectl apply -f virtualservice.yaml
```

Now, you'll get a timeout (status 504):
```
$ ./test.sh
504
real    0m 3.04s
user    0m 0.00s
sys     0m 0.00s

```


