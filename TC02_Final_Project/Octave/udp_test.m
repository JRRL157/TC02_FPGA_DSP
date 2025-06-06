clear;
clc;
pkg load instrument-control

Y = udp_client_matrix_C("127.0.0.1", 5005, a = [1 0 0 0 0 0 0 0; 1 0 0 0 0 3 2 0]);
disp("Received data:");
disp(Y);