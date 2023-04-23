# -*- coding: utf-8 -*-
import rx
from rx import operators as ops
import random
import time

def message_map(s):
    return s * 2

def message_handle():
    return rx.pipe(
        ops.map(lambda s: int(s) + 100),
        ops.filter(lambda i: i >= 5)
    )

# 读取文件为 generator
def read_file_content(file):
    with open(file) as f:
        for line in f.readlines():
            yield line

# 响应式发射消息
def reactive_emit(lines):
    #source = rx.of(*list(lines)).pipe(message_handle())
    source = rx.from_iterable(lines).pipe(message_handle())

    source.subscribe(
        on_next = lambda i: print("Received {0}".format(i)),
        on_error = lambda e: print("Error Occurred: {0}".format(e)),
        on_completed = lambda: print("Done!"),
    )
    
    #source.subscribe(lambda value: print("Received {0}".format(value)))

def interval_emit(lines):
    #l = list(lines)
    rx.interval(0.5).pipe(
        ops.map(lambda i: lines.__next__()),
        #ops.map(lambda s: message_map(s)),
    ).subscribe(
        on_next=lambda i: print("ook = {0}".format(i)),
        on_error=lambda e: print(e),
        on_completed=lambda: print("Done"),
    )
    input("Press any key to exit\n")  

if __name__ == '__main__':
    file = 'data/test.txt'
    lines = read_file_content(file)
    #reactive_emit(lines)
    interval_emit(lines)