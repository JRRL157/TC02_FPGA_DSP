clear;
clc;
pkg load instrument-control

%function [Y_tf, Y] = udp_client(server_ip, server_port, data)
Y_tf = udp_client("127.0.0.1", 5005, [1, 0, 1, 0, 0, 1, 1, 0]);

disp("Received data:");
disp(Y_tf);