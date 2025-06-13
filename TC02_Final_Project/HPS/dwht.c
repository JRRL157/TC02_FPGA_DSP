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

double* diff(double *matrixA, double* matrixB, int N, int M) {
    double *result = (double *)malloc(N * M * sizeof(double));
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

void __dwht_1D_radix2(double* vec, int N) {
    if (N != 2) {
        printf("Error: N must be 2 for this function. \n");
        return NULL;
    }

    double temp = vec[0];
    vec[0] = vec[0] + vec[1];
    vec[1] = temp - vec[1];
}

void __dwht_1D_N4(double *vec, int N) {
    if (N != 4) {
        printf("Error: N must be 4!\n");
        return NULL;
    }

    double* aux = (double*)malloc(N * sizeof(double));
    if (aux == NULL) {
        perror("Failed to allocate memory for transformed vector");
        return NULL;
    }

    for (int i = 0; i < N; i++) {
        aux[i] = vec[i];
    }

    // First layer
    vec[0] = aux[0] + aux[2];
    vec[2] = aux[0] - aux[2];
    vec[1] = aux[1] + aux[3];
    vec[3] = aux[1] - aux[3];

    // Second layer
    __dwht_1D_radix2(vec, 2);
    __dwht_1D_radix2((double*)(vec + 2*(sizeof(double))), 2);
}

void __dwht_1D_N8(double *vec, int N) {
    if (N != 8) {
        printf("Error: N must be 8!\n");
        return NULL;
    }
    
    double* aux = (double*)malloc(N * sizeof(double));
    if (aux == NULL) {
        perror("Failed to allocate memory for auxiliary vector");
        return NULL;
    }
    for (int i = 0; i < N; i++) {
        aux[i] = vec[i];
    }

    // First layer
    vec[0] = aux[0] + aux[4];
    vec[4] = aux[0] - aux[4];
    vec[1] = aux[1] + aux[5];
    vec[5] = aux[1] - aux[5];
    vec[2] = aux[2] + aux[6];
    vec[6] = aux[2] - aux[6];
    vec[3] = aux[3] + aux[7];
    vec[7] = aux[3] - aux[7];

    // Next layers 
    __dwht_1D_N4(vec, 4);
    __dwht_1D_N4((double*)(vec + 4*sizeof(double)), 4);
}

void __dwht_1D_N16(double *vec, int N) {
    if (N != 16) {
        printf("Error: N must be 16!\n");
        return NULL;
    }

    double* aux = (double*)malloc(N * sizeof(double));
    if (aux == NULL) {
        perror("Failed to allocate memory for auxiliary vector");
        return NULL;
    }
    for (int i = 0; i < N; i++) {
        aux[i] = vec[i];
    }

    // First layer
    vec[0] = aux[0] + aux[8];
    vec[8] = aux[0] - aux[8];
    vec[1] = aux[1] + aux[9];
    vec[9] = aux[1] - aux[9];
    vec[2] = aux[2] + aux[10];
    vec[10] = aux[2] - aux[10];
    vec[3] = aux[3] + aux[11];
    vec[11] = aux[3] - aux[11];
    vec[4] = aux[4] + aux[12];
    vec[12] = aux[4] - aux[12];
    vec[5] = aux[5] + aux[13];
    vec[13] = aux[5] - aux[13];
    vec[6] = aux[6] + aux[14];
    vec[14] = aux[6] - aux[14];
    vec[7] = aux[7] + aux[15];
    vec[15] = aux[7] - aux[15];

    // Next layers 
    __dwht_1D_N8(vec, 8);
    __dwht_1D_N8((double*)(vec + 8*sizeof(double)), 8);
}

void __dwht_1D_N32(double *vec, int N) {
    if (N != 32) {
        printf("Error: N must be 32!\n");
        return NULL;
    }

    double* aux = (double*)malloc(N * sizeof(double));
    if (aux == NULL) {
        perror("Failed to allocate memory for auxiliary vector");
        return NULL;
    }
    for (int i = 0; i < N; i++) {
        aux[i] = vec[i];
    }

    // First layer
    vec[0] = aux[0] + aux[16];
    vec[16] = aux[0] - aux[16];
    vec[1] = aux[1] + aux[17];
    vec[17] = aux[1] - aux[17];
    vec[2] = aux[2] + aux[18];
    vec[18] = aux[2] - aux[18];
    vec[3] = aux[3] + aux[19];
    vec[19] = aux[3] - aux[19];
    vec[4] = aux[4] + aux[20];
    vec[20] = aux[4] - aux[20];
    vec[5] = aux[5] + aux[21];
    vec[21] = aux[5] - aux[21];
    vec[6] = aux[6] + aux[22];
    vec[22] = aux[6] - aux[22];
    vec[7] = aux[7] + aux[23];
    vec[23] = aux[7] - aux[23];
    vec[8] = aux[8] + aux[24];
    vec[24] = aux[8] - aux[24];
    vec[9] = aux[9] + aux[25];
    vec[25] = aux[9] - aux[25];
    vec[10] = aux[10] + aux[26];
    vec[26] = aux[10] - aux[26];
    vec[11] = aux[11] + aux[27];
    vec[27] = aux[11] - aux[27];
    vec[12] = aux[12] + aux[28];
    vec[28] = aux[12] - aux[28];
    vec[13] = aux[13] + aux[29];
    vec[14] = aux[14] + aux[30];
    vec[30] = aux[14] - aux[30];
    vec[15] = aux[15] + aux[31];
    vec[31] = aux[15] - aux[31];

    // Next layers
    __dwht_1D_N16(vec, 16);
    __dwht_1D_N16((double*)(vec + 16*sizeof(double)), 16);
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

    double* transformed_matrix = (double*)malloc(N * M * sizeof(double));
     if (transformed_matrix == NULL) {
        perror("Failed to allocate memory for transformed matrix");        
        return NULL;
    }

    // Perform Hm * X * Hn'
    double* temp_matrix = (double*)malloc(N * M * sizeof(double));
    if (temp_matrix == NULL) {
        perror("Failed to allocate memory for temporary matrix");        
        return NULL;
    }

    // Apply DWHT to each row
    for (int i = 0; i < N; i++) {
        double* row = (double*)malloc(M * sizeof(double));
        if (row == NULL) {
            perror("Failed to allocate memory for row");
            free(temp_matrix);
            return NULL;
        }

        for (int j = 0; j < M; j++) {
            row[j] = matrix[i * M + j];
        }

        // Apply 1D DWHT to the row
        double* transformed_row = dwht_1d(row, M);

        if (transformed_row == NULL) {
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
            free(temp_matrix);
            return NULL;
        }
        for (int i = 0; i < N; i++) {
            col[i] = temp_matrix[i * M + j];
        }
        
        //Apply 1D DWHT to the column
        double* transformed_col = dwht_1d(col, N);

        if (transformed_col == NULL) {
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
    return transformed_matrix;
}

// Function for inverse 2D DWHT (Octave version)
double* dwht_2d_inverse_octave_ll(double* matrix, int N, int M) {

    double* transformed_matrix = (double*)malloc(N * M * sizeof(double));
    if (transformed_matrix == NULL) {
        perror("Failed to allocate memory for transformed matrix");        
        return NULL;
    }

    for(int i = 0; i < N; i++) {
        double* column_vector = (double*)malloc(M * sizeof(double));

        if (column_vector == NULL) {
            perror("Failed to allocate memory for column vector");
            return NULL;
        }
        for(int j = 0; j < M; j++) {
            column_vector[j] = matrix[j*N + i];
        }

        double* transformed_column_vector = dwht_1d_inverse(column_vector, M);
        
        if (transformed_column_vector == NULL) {
            free(column_vector);
            return NULL;
        }
        
        for (int j = 0; j < M; j++) {
            transformed_matrix[j*N + i] = transformed_column_vector[j];
        }
        free(transformed_column_vector);
        free(column_vector);
    }
    
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