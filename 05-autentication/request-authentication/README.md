# Request Authentication
---

Request Authentication is used to authenticat end-users. Istio uses JSON Web Tokens (JWTs) to
authenticate requests.

For this, we'll need a valid JWT and a JWT Key Set URL (JWKS). We'll use the Istio's demo JWT and JWKS.

In this demo, we apply the `httpbin` app, and expose it using a Gateway resource.

First, deploy the `deployment.yaml`. Then, test the connection:
```
$ test_connection_no_jwt
```

Now, let's deploy the `RequestAuthentication` resource that requires JWT authentication on the ingress gateway:
```
$ kubectl apply -f request-authentication.yaml
```

Now, we can issue a request with no JWT at all, or with a valid JWT:
```
$ test_connection_no_jwt
200
$ test_connection_invalid_jwt
401
$ test_connection_valid_jwt
200
```

## Require a valid token
---
To reject requests without valid tokens, add an AuthorizationPolicy with a DENY action for requests without
request principals. Request principals are available only when valid JWT tokens are provided.

Now try to access without a token:
```
$ test_connection_no_jwt
403
```

## Require valid token per path
---
You can refine you Authorization Policy so that valid JWTs are required only for certain paths, host or methods.
Let's change our Authorization Policy so that only requests to `/headers` require valid JWTs, while to other paths not.

```
$ kubectl apply -f authorization-request-path.yaml
```

```
$ curl "$INGRESS_HOST:$INGRESS_PORT/headers" -s -o /dev/null -w "%{http_code}\n"
403
$ curl "$INGRESS_HOST:$INGRESS_PORT/ip" -s -o /dev/null -w "%{http_code}\n"
200
```

## Cleanup
---
```
$ kubectl delete ns foo
```
