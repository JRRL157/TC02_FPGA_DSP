import numpy as np

def radix2(x: np.ndarray) -> np.ndarray:    
    N = x.shape[0]

    even = x[0]
    odd = x[1]

    plus = even + odd
    minus = even - odd

    return np.concatenate((plus, minus))

