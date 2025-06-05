#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

#define PORT 5005
#define MAX_MATRIX_DIMENSION 128
#define MAX_BUFFER_SIZE ((MAX_MATRIX_DIMENSION * MAX_MATRIX_DIMENSION * sizeof(double)) + sizeof(double) * 2)

void print_matrix(const double *matrix, int rows, int cols) {
    printf("Received matrix (%d x %d): \n", rows, cols);

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

    printf("UDP Matrix Server listening on port %d for binary double data...\n", PORT);

    while (1) {
        n_bytes = recvfrom(sockfd, buffer, MAX_BUFFER_SIZE, 0, (struct sockaddr *)&client_addr, &client_addr_len);

        if (n_bytes < 0) {
            perror("Receive failed");
            continue;
        }

        printf("Received %d bytes from %s:%d\n", n_bytes,inet_ntoa(client_addr.sin_addr), ntohs(client_addr.sin_port));

        double *received_data = (double *)buffer;

        // First two doubles sent by Octave are the dimensions (rows and columns) of the matrix
        int rows = (int)received_data[0];
        int cols = (int)received_data[1];

        // Validate matrix dimensions
        if (rows <= 0 || cols <= 0 ||
            rows > MAX_MATRIX_DIMENSION || cols > MAX_MATRIX_DIMENSION ||
            (rows * cols * sizeof(double) + 2 * sizeof(double)) > n_bytes) {
            fprintf(stderr, "Invalid matrix dimensions received: %dx%d or data size mismatch.\n", rows, cols);
            continue;
        }

        //Getting matrix data        
        double *matrix = (double *)(buffer + 2 * sizeof(double)); // Equivalent to &received_data[2] in C

        print_matrix(matrix, rows, cols);

        //TODO: Apply some operation over the matrix as you wish
        
        if (sendto(sockfd, matrix, n_bytes, 0, (const struct sockaddr *)&client_addr, client_addr_len) < 0) {
            perror("Send failed");
        } else {
            printf("Sent %d bytes back to %s:%d\n", n_bytes, inet_ntoa(client_addr.sin_addr), ntohs(client_addr.sin_port));
        }        
    }

    close(sockfd);
    return 0;
}