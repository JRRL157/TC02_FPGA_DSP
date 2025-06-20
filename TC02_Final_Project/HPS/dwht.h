#ifndef DWHT_H
#define DWHT_H

#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#endif

/**
 * @brief Calculates the difference between two matrices.
 *
 * @param matrixA A pointer to the first matrix (N x M).
 * @param matrixB A pointer to the second matrix (N x M).
 * @param N The number of rows in the matrices.
 * @param M The number of columns in the matrices.  
 * @return A result of the subtraction of matrixB from matrixA (N x M).
 */
int* diff(int *matrixA, int* matrixB, int N, int M);

int* multiply_matrices(int* matrixA, int* matrixB, int N, int M, int K);


/**
 * @brief Performs a 1-dimensional Discrete Walsh-Hadamard Transform (DWHT) on the input data.
 *
 * This function computes the DWHT of the input array using an iterative approach.
 * The DWHT is a transform used in signal processing and data compression.
 *
 * @param data Pointer to the input array containing the data to be transformed.
 *             The array is modified in-place to contain the transformed data.
 * @param n The size of the input array. Must be a power of 2.
 *
 * @note The input array size must be a power of 2 for the transform to work correctly.
 *       Ensure that the input data is properly allocated and initialized before calling this function.
 */
int* dwht_1d(int* vec, int N);

/**
 * @brief Performs a 1-dimensional Fast Walsh-Hadamard Transform (FWHT) on the input data.
 *
 * This function computes the DWHT of the input array using an iterative approach.
 * The FWHT is a fast transform used in signal processing and data compression.
 *
 * @param data Pointer to the input array containing the data to be transformed.
 *             The array is modified in-place to contain the transformed data.
 * @param n The size of the input array. Must be a power of 2.
 *
 * @note The input array size must be a power of 2 for the transform to work correctly.
 *       Ensure that the input data is properly allocated and initialized before calling this function.
 */
int* fwht_1d(int* vec, int N);
int* dwht_1d_inverse(int* vec, int N);

/**
 *
 * @brief Function for 2D DWHT for the High level implementation for Hm*X*Hn',
 *  where Hm and Hn are Hadamard matrices of size N and M respectively
 * @param matrix A pointer to the input matrix (represented as a 1D array in row-major order).
 * @param N The number of rows in the matrix. Must be a power of 2.
 * @param M The number of columns in the matrix. Must be a power of 2.
 * @return A pointer to the modified matrix (same as the input pointer).
 *
 * @note The function modifies the input matrix directly. Ensure that the matrix is properly allocated and contains valid data before calling this function.
 * @note The dimensions N and M should be powers of 2 for optimal DWHT performance.
 */
int* dwht_2d_octave(int* matrix, int N, int M);

/**
 *
 * @brief Function for 2D DWHT for the High level implementation for Hm' * X_tf',
 *  where Hm is the Hadamard matrix of size M
 * @param matrix A pointer to the input matrix (represented as a 1D array in row-major order).
 * @param N The number of columns in the matrix. Must be a power of 2.
 * @param M The number of rows in the matrix. Must be a power of 2.
 * @return A pointer to the modified matrix (same as the input pointer).
 *
 * @note The function modifies the input matrix directly. Ensure that the matrix is properly allocated and contains valid data before calling this function.
 * @note The dimensions N and M should be powers of 2 for optimal DWHT performance.
 */
int* dwht_2d_inverse_octave(int* matrix, int N, int M);

/**
 *
 * @brief Function for 2D DWHT Low level implementation for Hm*X*Hn',
 *  where Hm and Hn are Hadamard matrices of size N and M respectively
 * @param matrix A pointer to the input matrix (represented as a 1D array in row-major order).
 * @param N The number of rows in the matrix. Must be a power of 2.
 * @param M The number of columns in the matrix. Must be a power of 2.
 * @return A pointer to the modified matrix (same as the input pointer).
 *
 * @note The function modifies the input matrix directly. Ensure that the matrix is properly allocated and contains valid data before calling this function.
 * @note The dimensions N and M should be powers of 2 for optimal DWHT performance.
 */
int* dwht_2d_octave_ll(int* matrix, int N, int M);


/**
 *
 * @brief Function for 2D DWHT for the Low level implementation for Hm' * X_tf',
 *  where Hm is the Hadamard matrix of size M
 * @param matrix A pointer to the input matrix (represented as a 1D array in row-major order).
 * @param N The number of columns in the matrix. Must be a power of 2.
 * @param M The number of rows in the matrix. Must be a power of 2.
 * @return A pointer to the modified matrix (same as the input pointer).
 *
 * @note The function modifies the input matrix directly. Ensure that the matrix is properly allocated and contains valid data before calling this function.
 * @note The dimensions N and M should be powers of 2 for optimal DWHT performance.
 */
int* dwht_2d_inverse_octave_ll(int* matrix, int N, int M);

/**
 * @brief This function multiplies two matrices, matrixA and matrixB, and returns the resulting matrix.
 *
 * @param matrixA A pointer to the first matrix (N x M).
 * @param matrixB A pointer to the second matrix (M x K).
 * @param N The number of rows in matrixA.
 * @param M The number of columns in matrixA and the number of rows in matrixB.
 * @param K The number of columns in matrixB.
 *
 * @return A pointer to the resulting matrix (N x K), or NULL if an error occurred.  The caller is responsible for freeing the allocated memory.
 */
int* multiply_matrices(int* matrixA, int* matrixB, int N, int M, int K);

/**
 * @brief Transposes a given matrix.
 * 
 * This function transposes a matrix of size N x M, where N is the number of rows and M is the number of columns.
 * The function allocates memory for the transposed matrix, so the caller is responsible for freeing the allocated memory.
 *
 * @param matrix A pointer to the input matrix (N x M). The matrix is assumed to be stored in row-major order.
 * @param N The number of rows in the input matrix.
 * @param M The number of columns in the input matrix.
 * @return A pointer to the transposed matrix (M x N). Returns NULL if memory allocation fails.
 */
int* transpose(int *matrix, int N, int M);