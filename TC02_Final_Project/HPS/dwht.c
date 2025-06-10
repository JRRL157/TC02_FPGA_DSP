#include "dwht.h"

// Function to generate Hadamard matrix
double* hadamard(int n) {
    if (n <= 0 || (n & (n - 1)) != 0) {
        printf("Error: n must be a power of 2 and greater than 0.\n");
        return NULL;
    }

    double* H = (double*)malloc(n * n * sizeof(double));
    if (H == NULL) {
        perror("Failed to allocate memory for Hadamard matrix");
        return NULL;
    }

    // Initialize H[0][0] to 1
    H[0] = 1.0;

    int size = 1;
    while (size < n) {
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                H[(i + size) * n + j] = H[i * n + j];
                H[i * n + (j + size)] = H[i * n + j];
                H[(i + size) * n + (j + size)] = -H[i * n + j];
            }
        }
        size <<= 1;
    }
    return H;
}

double* transpose(double *matrix, int N, int M) {
    double *transposed = (double *)malloc(N * M * sizeof(double));

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            transposed[j * N + i] = matrix[i * M + j];
        }
    }

    return transposed;
}

double* __dwht_1d(double* vec, double* H, int N) {
    if (H == NULL) {
        return NULL;
    }

    double* transformed_vec = (double*)malloc(N * sizeof(double));
    if (transformed_vec == NULL) {
        perror("Failed to allocate memory for transformed vector");
        free(H);
        return NULL;
    }

    for (int i = 0; i < N; i++) {
        transformed_vec[i] = 0.0;
        for (int j = 0; j < N; j++) {
            transformed_vec[i] += H[i * N + j] * vec[j];
        }
    }

    free(H);
    return transformed_vec;
}

// Function for 1D DWHT
double* dwht_1d(double* vec, int N) {
    double* H = hadamard(N);
    if (H == NULL) {
        return NULL;
    }

    double* transformed_vec = __dwht_1d(vec, H, N);

    return transformed_vec;
}

double* dwht_1d_inverse(double* vec, int N) {
    double* H = hadamard(N);
    double* Ht = transpose(H, N, N);
    free(H);
    
    if (H == NULL) {
        return NULL;
    }

    double* transformed_vec = __dwht_1d(vec, Ht, N);

    return transformed_vec;
}

// High level 2D DWHT function
// Hm*X*Hn'
double *dwht_2d_octave(double *matrix, int N, int M) {
    if (N <= 0 || M <= 0 || (N & (N - 1)) != 0 || (M & (M - 1)) != 0) {
        printf("Error: N and M must be powers of 2 and greater than 0.\n");
        return NULL;
    }

    double* Hm = hadamard(M);
    double* Hn = hadamard(N);

    if (Hm == NULL || Hn == NULL) {
        if (Hm != NULL) free(Hm);
        if (Hn != NULL) free(Hn);
        return NULL;
    }
    double *HnT = transpose(Hn, N, N);

    double* transformed_matrix = multiply_matrices(matrix, HnT, M, N, N);
    transformed_matrix = multiply_matrices(Hm, transformed_matrix, M, M, N);
    //double* transformed_matrix = multiply_matrices(Hm, matrix, N, N, M);
    //transformed_matrix = multiply_matrices(transformed_matrix, HnT, N, M, N);

    free(Hm);
    free(Hn);
    free(HnT);

    return transformed_matrix;
}

double* dwht_2d_inverse_octave(double* matrix, int N, int M) {
    if (N <= 0 || M <= 0 || (N & (N - 1)) != 0 || (M & (M - 1)) != 0) {
        printf("Error: N and M must be powers of 2 and greater than 0.\n");
        return NULL;
    }

    double* Hm = hadamard(M);

    if (Hm == NULL) {
        return NULL;
    }

    double* HmT = transpose(Hm, M, M);
    
    if (HmT == NULL) {
        free(Hm);
        return NULL;
    }
    
    double *result_matrix = multiply_matrices(HmT, matrix, M, M, N);

    return result_matrix;
}

// Function for 2D DWHT Low level implementation for
// Hm*X*Hn'
// where Hm and Hn are Hadamard matrices of size N and M respectively
double* dwht_2d_octave_ll(double* matrix, int N, int M) {
    double* Hm = hadamard(N);
    double* Hn = hadamard(M);

    if (Hm == NULL || Hn == NULL) {
        if (Hm != NULL) free(Hm);
        if (Hn != NULL) free(Hn);
        return NULL;
    }

    double* transformed_matrix = (double*)malloc(N * M * sizeof(double));
     if (transformed_matrix == NULL) {
        perror("Failed to allocate memory for transformed matrix");
        free(Hm);
        free(Hn);
        return NULL;
    }

    // Perform Hm * X * Hn'
    double* temp_matrix = (double*)malloc(N * M * sizeof(double));
    if (temp_matrix == NULL) {
        perror("Failed to allocate memory for temporary matrix");
        free(Hm);
        free(Hn);
        return NULL;
    }

    // Apply DWHT to each row
    for (int i = 0; i < N; i++) {
        double* row = (double*)malloc(M * sizeof(double));
        if (row == NULL) {
            perror("Failed to allocate memory for row");
            free(Hm);
            free(Hn);
            free(temp_matrix);
            return NULL;
        }
        for (int j = 0; j < M; j++) {
            row[j] = matrix[i * M + j];
        }
        double* transformed_row = dwht_1d(row, M);
        if (transformed_row == NULL) {
            free(Hm);
            free(Hn);
            free(temp_matrix);
            free(row);
            return NULL;
        }
        for (int j = 0; j < M; j++) {
            temp_matrix[i * M + j] = transformed_row[j];
        }
        free(row);
        free(transformed_row);
    }

    // Apply DWHT to each column of the temporary matrix
    for (int j = 0; j < M; j++) {
        double* col = (double*)malloc(N * sizeof(double));
        if (col == NULL) {
            perror("Failed to allocate memory for column");
            free(Hm);
            free(Hn);
            free(temp_matrix);
            return NULL;
        }
        for (int i = 0; i < N; i++) {
            col[i] = temp_matrix[i * M + j];
        }
        double* transformed_col = dwht_1d(col, N);
        if (transformed_col == NULL) {
            free(Hm);
            free(Hn);
            free(temp_matrix);
            free(col);
            return NULL;
        }
        for (int i = 0; i < N; i++) {
            transformed_matrix[i * M + j] = transformed_col[i];
        }
        free(col);
        free(transformed_col);
    }

    free(temp_matrix);

    free(Hm);
    free(Hn);
    return transformed_matrix;
}

// Function for inverse 2D DWHT (Octave version)
double* dwht_2d_inverse_octave_ll(double* matrix, int N) {
    double* Hm = hadamard(N);
    if (Hm == NULL) {
        return NULL;
    }

    double* transformed_matrix = (double*)malloc(N * N * sizeof(double));
    if (transformed_matrix == NULL) {
        perror("Failed to allocate memory for transformed matrix");
        free(Hm);
        return NULL;
    }

    // Perform Hm' * X
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            transformed_matrix[i * N + j] = 0.0;
            for (int k = 0; k < N; k++) {
                transformed_matrix[i * N + j] += Hm[k * N + i] * matrix[k * N + j];
            }
        }
    }

    free(Hm);
    return transformed_matrix;
}
double* multiply_matrices(double* matrixA, double* matrixB, int N, int M, int K) {
    double* result = (double*)malloc(N * M * sizeof(double));
    if (result == NULL) {
        perror("Failed to allocate memory for result matrix");
        return NULL;
    }

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            result[i * M + j] = 0.0;
            for (int k = 0; k < K; k++) {
                result[i * M + j] += matrixA[i * K + k] * matrixB[k * M + j];
            }
        }
    }

    return result;
}