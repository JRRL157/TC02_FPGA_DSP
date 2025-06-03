function Y = udp_client(server_ip, server_port, data_row_vector)
    % Create a UDP socket
    u = udp(server_ip, server_port, 'LocalPort', 0, 'Timeout', 10);

    % Open the UDP socket
    fopen(u);

    % Send data to the server
    fwrite(u, data_row_vector, 'double');
    
    % Wait for the response from the server
    response = fread(u, length(data_row_vector), 'double');    

    % Close the UDP socket
    fclose(u);
    
    % Reshape the response to match the expected output
    Y = reshape(response, size(response));
end
