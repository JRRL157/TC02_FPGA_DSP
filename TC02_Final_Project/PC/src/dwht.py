import numpy as np
from scipy.linalg import hadamard

def dwht(x, N) -> np.ndarray:
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

    return np.dot(hadamard(N), x);