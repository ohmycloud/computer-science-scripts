import rx
from rx import operators as ops

source = rx.of("Alpha", "Beta", "Gamma", "Delta", "Epsilon")

# 过滤器
composed = source.pipe(
    ops.map(lambda s: len(s)),
    ops.filter(lambda i: i >= 5)
)

composed.subscribe(
    lambda value: print("Received {0}".format(value))
)

print("-----------")

rx.of("Alpha", "Beta", "Gamma", "Delta", "Epsilon").pipe(
    ops.map(lambda s: len(s)),
    ops.filter(lambda i: i >= 5)
).subscribe(lambda value: print("Received {0}".format(value)))