import rx
from rx import operators as ops

def length_more_than_five():
    return rx.pipe(
        ops.map(lambda s: len(s)),
        ops.filter(lambda i: i >= 5)
    )

rx.of("Alpha", "Beta", "Gamma", "Delta", "Epsilon").pipe(
    length_more_than_five()
).subscribe(lambda value: print("Received {0}".format(value)))