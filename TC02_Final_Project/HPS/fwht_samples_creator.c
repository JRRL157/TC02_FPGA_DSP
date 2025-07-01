#include "dwht.h"

void fp_samples_creator(int32_t *vec, int32_t *vec_copy, uint32_t N) {
    if (N <= 0 || (N & (N - 1)) != 0) {
        printf("Error: N must be a power of 2 and greater than zero.\n");
        return;
    }

    for (uint32_t i = 0; i < N; ++i) {
        float random_value = (float)(rand() % 2001 - 1000); // Random values between -1000 and 1000                
        int32_t random_value_fp = float_to_fp(random_value);

        vec[i] = random_value_fp;
        vec_copy[i] = random_value_fp; // Copy the original vector
    }
}
void testbench(uint32_t N, uint32_t iter_number, char* input_file_name, char* output_file_name) {
    FILE *input_file;
    FILE *output_file;
    srand((uint32_t)time(NULL));

    if (N <= 0 || (N & (N - 1)) != 0) {
        printf("Error: N must be a power of 2 and greater than zero.\n");
        return;
    }

    input_file = fopen(input_file_name, "w");
    if (input_file == NULL) {
        perror("Error opening input file");
        fclose(input_file);
        return;
    }

    output_file = fopen(output_file_name, "w");
    if (output_file == NULL) {
        perror("Error opening output file");
        fclose(output_file);
        return;
    }

    int32_t vec[N], vec_copy[N];
    for(uint32_t i = 0;i < iter_number; ++i) {
        fp_samples_creator(vec, vec_copy, N);
        __fwht_1D(vec, N);

        // Write all N values from vec_copy and vec to the input file
        for(uint32_t j = 0; j < N; ++j) {
            if (j == N -1){
                fprintf(input_file, "%08X\n", (int32_t)vec_copy[j]);
                fprintf(output_file, "%08X\n", (int32_t)vec[j]);
            }
            else {
                fprintf(input_file, "%08X ", (int32_t)vec_copy[j]);
                fprintf(output_file, "%08X ", (int32_t)vec[j]);
            }
        }
    }
    fclose(input_file);
    fclose(output_file);
    printf("Testbench completed successfully. Input and output files created.\n");
}
int main() {
    testbench(4, 100, "samples/input_samples.txt", "samples/output_samples.txt");
    return 0;
}