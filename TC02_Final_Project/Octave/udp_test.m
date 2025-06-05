clear;
clc;
pkg load instrument-control

Y = udp_client_matrix_C("127.0.0.1", 5005, a = [1 3 5; 2 4 6; 7 8 10]);

disp("Received data:");
disp(Y);