#include "dwht.h"
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

#define PORT 5016
#define MAX_MATRIX_DIMENSION 128
#define MAX_BUFFER_SIZE ((MAX_MATRIX_DIMENSION * MAX_MATRIX_DIMENSION * sizeof(float) * 2) + sizeof(float) * 3)

void print_matrix(const float *matrix, int rows, int cols, char *name) {
    printf("%s matrix (%d x %d): \n", name, rows, cols);

    for(int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            printf("%.2f\t", matrix[i * cols + j]);
        }
        printf("\n");
    }
}
int main() {
    int sockfd;
    struct sockaddr_in server_addr, client_addr;
    socklen_t client_addr_len = sizeof(client_addr);
    char buffer[MAX_BUFFER_SIZE];
    int n_bytes;

    sockfd = socket(AF_INET, SOCK_DGRAM, 0);

    if (sockfd < 0) {
        perror("Socket creation failed");
        exit(EXIT_FAILURE);
    }

    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(PORT);

    if (bind(sockfd, (const struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
        perror("Bind failed");
        close(sockfd);
        exit(EXIT_FAILURE);
    }

    printf("UDP Matrix Server listening on port %d for binary float data...\n", PORT);

    while (1) {
        n_bytes = recvfrom(sockfd, buffer, MAX_BUFFER_SIZE, 0, (struct sockaddr *)&client_addr, &client_addr_len);

        if (n_bytes < 0) {
            perror("Receive failed");
            continue;
        }

        printf("Received %d bytes from %s:%d\n", n_bytes, inet_ntoa(client_addr.sin_addr), ntohs(client_addr.sin_port));

        double *received_data = (double *)buffer;

        // First two floats sent by Octave are the dimensions (rows and columns) of the matrix
        int cmd = (int)received_data[0];
        int cols = (int)received_data[1];
        int rows = (int)received_data[2];

        // Validate matrix dimensions
        if (rows <= 0 || cols <= 0 || rows > MAX_MATRIX_DIMENSION || cols > MAX_MATRIX_DIMENSION || (rows * cols * sizeof(double) + 3 * sizeof(double)) > n_bytes) {
            fprintf(stderr, "Invalid matrix dimensions received: %dx%d or data size mismatch.\n", rows, cols);
            continue;
        }

        //Getting matrix data
        //float *matrix = (float *)(received_data + 3 * sizeof(double));
        float matrix[rows*cols];

        for(int i = 0;i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                matrix[i * cols + j] = (float)received_data[3 + i * cols + j];
            }
        }

        print_matrix(matrix, rows, cols, "UDP Received matrix");

        float* processed_matrix = NULL;
        switch(cmd) {
            case 0: // DWHT 1D
                processed_matrix = dwht_2d_inverse_octave(matrix, rows, cols);
                break;
            case 1: // DWHT 2D
                processed_matrix = dwht_2d_octave(matrix, rows, cols);
                break;
            case 2: // DWHT 1D Low Level
                processed_matrix = dwht_2d_inverse_octave_ll(matrix, rows, cols);
                //float* debug_matrix = dwht_2d_inverse_octave(matrix, rows, cols);
                //float* error_matrix = diff(processed_matrix, debug_matrix, rows, cols);
                //char *error_matrix_name = "Error Matrix";
                //print_matrix(error_matrix, rows, cols, error_matrix_name);
                //free(debug_matrix);
                break;
            case 3: // DWHT 2D Low Level
                processed_matrix = dwht_2d_octave_ll(matrix, rows, cols);                
                break;
            default:
                fprintf(stderr, "Unknown command received: %d\n", cmd);
                break;
        }

        if (processed_matrix == NULL) {
            fprintf(stderr, "Error applying DWHT into matrix.\n");
            continue;
        }

        //print_matrix(p_matrix, rows, cols);
        // Convert the processed matrix to double
        double processed_matrix_double[rows * cols];

        for(int i = 0;i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                processed_matrix_double[i * cols + j] = (double)processed_matrix[i * cols + j];
            }
        }

        if (sendto(sockfd, processed_matrix_double, n_bytes, 0, (const struct sockaddr *)&client_addr, client_addr_len) < 0) {
            perror("Send failed");
        } else {
            printf("Sent %d bytes back to %s:%d\n", n_bytes, inet_ntoa(client_addr.sin_addr), ntohs(client_addr.sin_port));
        }
    }

    close(sockfd);
    return 0;
}
