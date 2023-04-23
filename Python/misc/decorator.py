import time
import random

def time_calc(func):
    def wrapper(*args, **kargs):
        start_time = time.time()
        f = func(*args, **kargs)
        exec_time = time.time() - start_time
        print("exec time = ", exec_time)
        return f
    return wrapper

# 使用装饰器
@time_calc
def add(a, b):
    time_to_sleep = random.randint(1,3)
    time.sleep(time_to_sleep)
    return a + b;

@time_calc
def sub(a, b):
    time_to_sleep = random.randint(1,3)
    time.sleep(time_to_sleep)
    return a - b;  


if __name__ == '__main__':
    add(1,2)
    sub(1,2)