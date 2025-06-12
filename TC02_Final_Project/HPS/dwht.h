#ifndef DWHT_H
#define DWHT_H

#include <math.h>
#include <stdlib.h>
#include <stdio.h>
struct  complex {
    float R;
    float I;
};
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
double* diff(double *matrixA, double* matrixB, int N, int M);

double* dwht_1d(double* vec, int N);
double* dwht_1d_inverse(double* vec, int N);

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
double* dwht_2d_octave(double* matrix, int N, int M);

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
double* dwht_2d_inverse_octave(double* matrix, int N, int M);

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
double* dwht_2d_octave_ll(double* matrix, int N, int M);


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
double* dwht_2d_inverse_octave_ll(double* matrix, int N, int M);

/**
 * @brief Multiplies two matrices.
 *
 * This function multiplies two matrices, matrixA and matrixB, and returns the resulting matrix.
 *
 * @param matrixA A pointer to the first matrix (N x M).
 * @param matrixB A pointer to the second matrix (M x K).
 * @param N The number of rows in matrixA.
 * @param M The number of columns in matrixA and the number of rows in matrixB.
 * @param K The number of columns in matrixB.
 *
 * @return A pointer to the resulting matrix (N x K), or NULL if an error occurred.  The caller is responsible for freeing the allocated memory.
 */
double* multiply_matrices(double* matrixA, double* matrixB, int N, int M, int K);

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
double* transpose(double *matrix, int N, int M);