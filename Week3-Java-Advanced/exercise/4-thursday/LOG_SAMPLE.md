Before changing the threshold, logger `pair.b.tasks` was set to `WARN`, so only the warning line from `TaskQueueApp` was visible while INFO/DEBUG remained filtered. After changing `pair.b.tasks` to `DEBUG` and rerunning, lifecycle INFO and loop DEBUG lines appeared, confirming level filtering works as expected.

```text
17:32:47.238 [main] INFO  pair.a.words - WordFrequencyApp started
17:32:47.242 [main] DEBUG pair.a.words - Processing token: java
17:32:47.244 [main] INFO  pair.a.words - Computed 8 unique words and 8 total entries
17:32:47.246 [main] INFO  pair.a.words - WordFrequencyApp finished
17:32:47.539 [main] WARN  pair.b.tasks - Task queue drained completely
17:32:55.389 [main] INFO  pair.b.tasks - TaskQueueApp started
17:32:55.393 [main] DEBUG pair.b.tasks - Drained task: Task [priority=3, description=cooking]
17:32:55.394 [main] DEBUG pair.b.tasks - Drained task: Task [priority=2, description=guitar]
17:32:55.394 [main] DEBUG pair.b.tasks - Drained task: Task [priority=1, description=walk dog]
17:32:55.394 [main] WARN  pair.b.tasks - Task queue drained completely
```
