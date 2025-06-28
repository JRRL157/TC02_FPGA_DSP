#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "dwht.h"

int compare_int_arrays(const int *a, const int *b, int n) {
    for (int i = 0; i < n; ++i) {
        if (a[i] != b[i]) return 0;
    }
    return 1;
}

int compare_float_arrays(const float *a, const float *b, int n, float tol) {
    for (int i = 0; i < n; ++i) {
        if (fabsf(a[i] - b[i]) > tol) return 0;
    }
    return 1;
}

// Test function for __dwht_1d and __dwht_1d_float
void test_dwht_1d(const int *input, uint32_t n) {
    float input_float[n];

    for (int i = 0; i < n; ++i) {
        input_float[i] = (float)input[i];
    }

    float* float_output_float = fwht_1d_float(input_float, n);
    float* float_output_fp = fwht_1d(input_float, n);

    // Compare outputs (with tolerance for float)
    int pass = compare_float_arrays(float_output_float, float_output_fp, n, 1e-3);

    printf("Test input: ");
    for (uint32_t i = 0; i < n; ++i){
        printf("%d ", input[i]);
    }
    printf("\n");

    printf("float_output_fp:   ");
    for (uint32_t i = 0; i < n; ++i){
        printf("%.3f ", float_output_fp[i]);
    }
    printf("\n");

    printf("float_output_float: ");
    for (uint32_t i = 0; i < n; ++i) {
        printf("%.3f ", float_output_float[i]);
    }
    printf("\n");

    printf("Result: %s\n\n", pass ? "PASS" : "FAIL");

    free(float_output_fp);
    free(float_output_float);
}

int main() {
    // Test 1: All zeros
    int test1[] = {0, 0, 0, 0};
    test_dwht_1d(test1, 4);

    // Test 2: Impulse
    int test2[] = {1, 0, 0, 0};
    test_dwht_1d(test2, 4);

    // Test 3: Increasing sequence
    int test3[] = {1, 2, 3, 4};
    test_dwht_1d(test3, 4);

    // Test 4: Negative values
    int test4[] = {-1, -2, -3, -4};
    test_dwht_1d(test4, 4);

    // Test 5: Mixed values
    int test5[] = {5, -3, 2, -1};
    test_dwht_1d(test5, 4);

    // Test 6: Larger input
    int test6[] = {1, 2, 3, 4, 5, 6, 7, 8};
    test_dwht_1d(test6, 8);

    // Test 7: Random values
    int test7[] = {7, 0, -2, 4, 1, -5, 3, 2};
    test_dwht_1d(test7, 8);

    // Test 8: Random values
    int test8[] = {0, 1, 2, 3, 3, 2, 1, 0};
    test_dwht_1d(test8, 8);

    // Test 9: Random values
    int test9[] = {7, 4, -5, 10};
    test_dwht_1d(test9, 4);

    return 0;
}