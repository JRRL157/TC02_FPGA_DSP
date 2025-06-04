clear;
clc;
pkg load instrument-control

%function [Y_tf, Y] = udp_client(server_ip, server_port, data)
Y_tf = udp_client_matrix("127.0.0.1", 5005, a = [1 3 5; 2 4 6; 7 8 10]);

disp("Received data:");
disp(Y_tf);