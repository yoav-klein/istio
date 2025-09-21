# Java Spring
---

This is an example of zero-code instrumentation with Java Spring.
So we run a Java Spring application (client and server), and we zero-code-instrument it using the OTEL Java agent.
Spring automatically emits spans.

Run:
```
$ docker compose up -d [--build]
```

Connect to the Jaeger UI, and you'll see the spans like unicorns in your dreams
