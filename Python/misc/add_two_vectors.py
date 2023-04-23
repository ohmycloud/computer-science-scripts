import time
import matplotlib.pyplot as plt
import numpy as np
from flitton_fib_rs import time_add_vectors

def rust_function(total_vector_size: int) -> float:
    t1 = time.time()
    sum_vector = time_add_vectors(total_vector_size)
    result = time.time() - t1

    if result > 0.00001:
        result = 0.00001
    return result

def numpy_function(total_vector_size: int) -> float:
    t1 = time.time()
    first_vector = np.arange(total_vector_size)
    second_vector = np.arange(total_vector_size)
    sum_vector = first_vector + second_vector
    result = time.time() - t1

    if result > 0.00001:
        result = 0.00001
    return result

def python_function(total_vector_size: int) -> float:
    t1 = time.time()
    first_vector = range(total_vector_size)
    second_vector = range(total_vector_size)
    sum_vector = [first_vector[i] + second_vector[i] for
    i in range(len(second_vector))]
    result = time.time() - t1

    if result > 0.0001:
        result = 0.0001
    return result

numpy_results = [numpy_function(i) for i in range(0, 300)]
rust_results = [rust_function(i) for i in range(0, 300)]
python_results = [python_function(i) for i in range(0,300)]
plt.plot(rust_results, linestyle='solid', color="green")
plt.plot(python_results, linestyle='solid', color="red")
plt.plot(numpy_results, linestyle='solid', color="blue")
plt.show()