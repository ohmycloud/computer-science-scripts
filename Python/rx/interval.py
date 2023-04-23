import rx
from rx import operators as ops
import time
import random

def intense_calculation(value):
    # sleep for a random short duration between 0.5 to 2.0 seconds to simulate a long-running calculation
    time.sleep(random.randint(5, 20) * 0.1)
    return value

# Create Process 3, which is infinite
rx.interval(1).pipe(
    ops.map(lambda i: i),
    # ops.map(lambda s: intense_calculation(s)),
).subscribe(
    on_next=lambda i: print("count = {0}".format(i)),
    on_error=lambda e: print(e),
)

input("Press any key to exit\n")