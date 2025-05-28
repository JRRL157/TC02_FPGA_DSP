from scipy.linalg import hadamard
import numpy as np

H8 = hadamard(8, dtype=float)

vector = np.array([1, 0, 1, 0, 0, 1, 1, 0])
vector_col = vector.reshape(-1, 1)

# Example: multiplying H2 with the column vector
result = np.dot(H8, vector_col)
print("H8:", H8)
print("Product (H2 * vector_col): \n", result)

