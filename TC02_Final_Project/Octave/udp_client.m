function Y = udp_client(server_ip, server_port, data_row_vector)
    % Create a UDP socket
    u = udp(server_ip, server_port, 'LocalPort', 0, 'Timeout', 10);

    row_num = size(data_row_vector)(1);
    col_num = size(data_row_vector)(2);
    
    if row_num == 1 && col_num > 1        
        data_row_vector = data_row_vector; % Ensure it's a row vector
    elseif row_num > 1 && col_num == 1
        % If the input is a column vector, reshape it to a row vector
        data_row_vector = data_row_vector(:).'; % Ensure it's a row vector
    elseif row_num > 1 && col_num > 1
        % If the input is a matrix, reshape it to a row vector
        data_row_vector = reshape(data_row_vector, 1, []);
    end

    disp(size(data_row_vector)(2));

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