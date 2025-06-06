import numpy as np
from scipy.linalg import hadamard

'''
def dwht(x: np.ndarray, N: int):
    """
    Perform the Discrete Walsh-Hadamard Transform (DWHT) on a 1D array.

    Args:
        x (np.ndarray): Input array of shape (N,).
        N (int): Length of the input array, must be a power of 2.

    Returns:
        np.ndarray: Transformed array of shape (N,).
    """
    if N <= 0 or (N & (N - 1)) != 0:
        raise ValueError("N must be a positive power of 2.")

    if x.shape[0] != N:
        raise ValueError(f"Input array must have length {N}.")

    print(f"X = {x}")
    print(f"Hadamard matrix for N={N}:\n{hadamard(N)}")

    # Base case
    if N == 1:
        return x    
    if x.ndim == 2:
        return dwht_2d(x, N)
    elif x.ndim == 1:
        return dwht_1d(x, N)
'''
def dwht_2d(matrix: np.ndarray, N: int, M: int):
    """
    Perform the Discrete Walsh-Hadamard Transform (DWHT) on a matrix.

    Args:
        matrix (np.ndarray): Input 2D array of shape (N, M).
        N (int): Length of each dimension, must be a power of 2.
        M (int): Length of each dimension, must be a power of 2.

    Returns:
        np.ndarray: Transformed 2D array of shape (N, N).
    """
    if matrix.shape[0] != N or matrix.shape[1] != M:
        raise ValueError(f"Input matrix must have shape ({N}, {M}).")

    # Apply DWHT to each row
    transformed_rows = np.array([dwht_1d(row, M) for row in matrix])

    # Apply DWHT to each column
    transformed_matrix = np.array([dwht_1d(col, N) for col in transformed_rows.T]).T

    return transformed_matrix

def dwht_1d(vec: np.array, N: int):
    print(N)
    H = hadamard(N)
    print(vec)
    if vec.shape[0] != N:
        raise ValueError(f"Input array must have length {N}.")

    # Ensure vec is a column vector
    vec = vec.reshape(N, 1)

    # Perform the DWHT
    transformed_vec = np.dot(H, vec)
    print(transformed_vec)
    print(transformed_vec.flatten())
    return transformed_vec.flatten()
