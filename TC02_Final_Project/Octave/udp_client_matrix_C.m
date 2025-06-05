function Y = udp_client_matrix_C(server_ip, server_port, data_matrix)
    u = udp(server_ip, server_port, 'LocalPort', 0, 'Timeout', 10);

    fopen(u);

    [rows, cols] = size(data_matrix);
    
    flattened_data = data_matrix'; % Transpose
    flattened_data = flattened_data(:).'; % Flatten row-wise by flattening the transposed matrix

    data_to_send = [double(rows), double(cols), flattened_data];

    disp("Size of data_to_send:");
    disp(size(data_to_send));
    disp("Data being sent (first few elements):");
    disp(data_to_send(1: min(10, numel(data_to_send))));

    fwrite(u, data_to_send, 'double');

    try
        response_data = fread(u, (rows * cols), 'double');
    catch ME
        warning("Error during data transmission: %s", ME.message);
        response_data = [];
    end

    fclose(u);

    %Reshape to match the original matrix dimensions
    if ~isempty(response_data)        
        Y = reshape(response_data, cols, rows).';
    else
        Y = [];
        disp("No data received or an error occurred.");
    end