from rx import create
from rx import operators as ops

def push_five_strings(observer, scheduler):
    observer.on_next('Alpha')
    observer.on_next('Beta')
    observer.on_next('Gamma')
    observer.on_next('Delta')
    observer.on_next('Epsilon')
    observer.on_completed()

source = create(push_five_strings)

# 映射和过滤操作
composed = source.pipe(
  ops.map(lambda x: x * x),
  ops.filter(lambda x: x % 2 == 0)
)

# 订阅
source.subscribe(
    on_next = lambda x: print("Receive from {0}".format(x)),
    on_error = lambda e: print("Error Occurred: {0}".format(e)),
    on_completed = lambda: print("Done!"),
)