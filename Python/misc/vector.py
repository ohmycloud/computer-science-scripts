import time
import numpy as np
import matplotlib.pyplot as plt

def numpy_function(total_vector_size: int) -> float:
    t1 = time.time()
    first_vector = np.arange(total_vector_size)
    second_vector = np.arange(total_vector_size)
    sum_vector = first_vector + second_vector
    return time.time() - t1

def python_function(total_vector_size: int) -> float:
    t1 = time.time()
    first_vector = range(total_vector_size)
    second_vector = range(total_vector_size)
    sum_vector = [first_vector[i] + second_vector[i] for i in range(len(second_vector))]
    return time.time() - t1

print(python_function(1000))
print(numpy_function(1000))
python_results = [python_function(i) for i in range(0, 10000)]
numpy_results = [numpy_function(i) for i in range(0, 10000)]

plt.plot(python_results, linestyle='solid')
plt.plot(numpy_results, linestyle='dashdot')
plt.show()