function Y = udp_client_matrix(server_ip, server_port, data)
    % Create a UDP socket
    u = udp(server_ip, server_port, 'LocalPort', 0, 'Timeout', 10);    

    % Open the UDP socket
    fopen(u);

    % Send data to the server
    fwrite(u, data, 'double');
    
    disp("Size of data:");
    disp(size(data));
    % Wait for the response from the server
    response = fread(u, size(data), 'double');

    % Close the UDP socket
    fclose(u);
    
    % Reshape the response to match the expected output
    Y = reshape(response, size(response));
end