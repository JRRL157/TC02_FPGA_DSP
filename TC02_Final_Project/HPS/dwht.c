#include "dwht.h"

// Function to generate Hadamard matrix
int* hadamard(int n) {
    if (n <= 0 || (n & (n - 1)) != 0) {
        printf("Error: n must be a power of 2 and greater than 0.\n");
        return NULL;
    }

    int* H = (int*)malloc(n * n * sizeof(int));
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

int* transpose(int *matrix, int N, int M) {
    int *transposed = (int *)malloc(N * M * sizeof(int));

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            transposed[j * N + i] = matrix[i * M + j];
        }
    }

    return transposed;
}

int* diff(int *matrixA, int* matrixB, int N, int M) {
    int *result = (int *)malloc(N * M * sizeof(int));
    if (result == NULL) {
        perror("Failed to allocate memory for result matrix");
        return NULL;
    }

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            result[i * M + j] = matrixA[i * M + j] - matrixB[i * M + j];
        }
    }

    return result;
}

void __fwht_1D(int* vec_ptr, int N) {
    if (N == 1) {
        return; // Base case, nothing to do
    }

    if (N <= 0 || (N & (N - 1)) != 0) {
        printf("Error: N must be a power of 2 and greater than zero.\n");
        return;
    }

    int aux[N];

    for (int i = 0; i < N; i++) {
        aux[i] = vec_ptr[i];
    }

    // Current stage
    int N_half = N / 2;
    for(int i = 0; i < N_half; i++) {
        vec_ptr[i] = aux[i] + aux[i + N_half];
        vec_ptr[i + N_half] = aux[i] - aux[i + N_half];
    }

    // Next (log2(N) - 1) stages
    __fwht_1D(vec_ptr, N_half);
    __fwht_1D(vec_ptr + N_half, N_half);
}

int* fwht_1d(int* vec, int N) {
    if (N <= 0 || (N & (N-1)) != 0) {
        printf("Error: N must be a power of 2 and greater than zero.\n");
        return NULL;
    }

    int* transformed_vec = (int*)malloc(N * sizeof(int));
    if (transformed_vec == NULL) {
        perror("Failed to allocate memory for transformed vector");
        return NULL;
    }
    memcpy(transformed_vec, vec, N * sizeof(int));

    __fwht_1D(transformed_vec, N);

    return transformed_vec;
}

int* __dwht_1d(int* vec, int* H, int N) {
    if (H == NULL) {
        return NULL;
    }

    int* transformed_vec = (int*)malloc(N * sizeof(int));
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
int* dwht_1d(int* vec, int N) {
    int* H = hadamard(N);
    if (H == NULL) {
        return NULL;
    }

    int* transformed_vec = __dwht_1d(vec, H, N);

    return transformed_vec;
}

int* dwht_1d_inverse(int* vec, int N) {
    int* H = hadamard(N);
    int* Ht = transpose(H, N, N);
    free(H);

    if (H == NULL) {
        return NULL;
    }

    int* transformed_vec = __dwht_1d(vec, Ht, N);

    return transformed_vec;
}

// High level 2D DWHT function
// Hm*X*Hn'
int *dwht_2d_octave(int *matrix, int N, int M) {
    if (N <= 0 || M <= 0 || (N & (N - 1)) != 0 || (M & (M - 1)) != 0) {
        printf("Error: N and M must be powers of 2 and greater than 0.\n");
        return NULL;
    }

    int* Hm = hadamard(M);
    int* Hn = hadamard(N);

    if (Hm == NULL || Hn == NULL) {
        if (Hm != NULL) free(Hm);
        if (Hn != NULL) free(Hn);
        return NULL;
    }
    int *HnT = transpose(Hn, N, N);

    int* transformed_matrix = multiply_matrices(matrix, HnT, M, N, N);
    transformed_matrix = multiply_matrices(Hm, transformed_matrix, M, M, N);
    //int* transformed_matrix = multiply_matrices(Hm, matrix, N, N, M);
    //transformed_matrix = multiply_matrices(transformed_matrix, HnT, N, M, N);

    free(Hm);
    free(Hn);
    free(HnT);

    return transformed_matrix;
}

int* dwht_2d_inverse_octave(int* matrix, int N, int M) {
    if (N <= 0 || M <= 0 || (N & (N - 1)) != 0 || (M & (M - 1)) != 0) {
        printf("Error: N and M must be powers of 2 and greater than 0.\n");
        return NULL;
    }

    int* Hm = hadamard(M);

    if (Hm == NULL) {
        return NULL;
    }

    int* HmT = transpose(Hm, M, M);
    
    if (HmT == NULL) {
        free(Hm);
        return NULL;
    }

    int *result_matrix = multiply_matrices(HmT, matrix, M, M, N);

    return result_matrix;
}

// Function for 2D DWHT Low level implementation for
// Hm*X*Hn'
// where Hm and Hn are Hadamard matrices of size N and M respectively
int* dwht_2d_octave_ll(int* matrix, int N, int M) {

    int* transformed_matrix = (int*)malloc(N * M * sizeof(int));
     if (transformed_matrix == NULL) {
        perror("Failed to allocate memory for transformed matrix");        
        return NULL;
    }

    // Perform Hm * X * Hn'
    int temp_matrix[N*M];

    // Apply DWHT to each row
    int row[M];
    for (int i = 0; i < N; i++) {

        for (int j = 0; j < M; j++) {
            row[j] = matrix[i * M + j];
        }

        // Apply 1D DWHT to the row
        //int* transformed_row = dwht_1d(row, M);
        int* transformed_row = fwht_1d(row, M);

        if (transformed_row == NULL) {
            free(transformed_row);
            return NULL;
        }
        for (int j = 0; j < M; j++) {
            temp_matrix[i * M + j] = transformed_row[j];
        }
        // free(row);
        free(transformed_row);
    }

    // Apply DWHT to each column of the temporary matrix
    int col[N];
    for (int j = 0; j < M; j++) {

        for (int i = 0; i < N; i++) {
            col[i] = temp_matrix[i * M + j];
        }
        
        //Apply 1D DWHT to the column
        //int* transformed_col = dwht_1d(col, N);
        int* transformed_col = fwht_1d(col, N);

        if (transformed_col == NULL) {
            free(transformed_col);
            return NULL;
        }
        for (int i = 0; i < N; i++) {
            transformed_matrix[i * M + j] = transformed_col[i];
        }

        free(transformed_col);
    }

    return transformed_matrix;
}

// Function for inverse 2D DWHT (Octave version)
int* dwht_2d_inverse_octave_ll(int* matrix, int N, int M) {

    int* transformed_matrix = (int*)malloc(N * M * sizeof(int));
     if (transformed_matrix == NULL) {
        perror("Failed to allocate memory for transformed matrix");        
        return NULL;
    }

    int column_vector[M];
    for(int i = 0; i < N; i++) {

        for(int j = 0; j < M; j++) {
            column_vector[j] = matrix[j*N + i];
        }

        //int* transformed_column_vector = dwht_1d_inverse(column_vector, M);
        int* transformed_column_vector = fwht_1d(column_vector, M);
        
        if (transformed_column_vector == NULL) {
            free(transformed_column_vector);
            return NULL;
        }
        
        for (int j = 0; j < M; j++) {
            transformed_matrix[j*N + i] = transformed_column_vector[j];
        }
        free(transformed_column_vector);
    }

    return transformed_matrix;
}
int* multiply_matrices(int* matrixA, int* matrixB, int N, int M, int K) {
    int* result = (int*)malloc(N * M * sizeof(int));
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