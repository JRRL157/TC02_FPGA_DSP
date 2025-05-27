from scipy.linalg import hadamard

H2 = hadamard(2, dtype=complex)
H4 = hadamard(4, dtype=float)
H8 = hadamard(8, dtype=float)

print(H2)
print(H4)
print(H8)
