% First of all, install the 'octave-communications' package from AUR

% Main procedure
clc;
clear;
pkg load communications;
pkg load instrument-control

% Prefixo
directory = "images/";

% Simulation type (0 for OFDM, 1 for OTFS)
optimized = 0;

file_suffix = 'simulação.png';

% 3GPP Standard channel
delays_EVA = [0, 30, 150, 310, 370, 710, 1090, 1730, 2510] * 1e-9;
pdp_EVA = [0.0, -1.5, -1.4, -3.6, -0.6, -9.1, -7.0, -12.0, -16.9];

delays_EPA = [0, 30, 70, 90, 110, 190, 410]*1e-9;
pdp_EPA = [0.0, -1.0, -2.0, -3.0, -8.0, -17.2, -20.8];

delays_ETU = [0, 50, 120, 200, 230, 500, 1600, 2300, 5000]*1e-9;
pdp_ETU = [-1.0, -1.0, -1.0, 0.0, 0.0, 0.0, -3.0, -5.0, -7.0];

channel_model_name = ["EVA", "EPA", "ETU"];

%Multicarrier modulation schemes
otfs_hadamard_str = "otfs_hadamard";
otfs_walsh_str = "otfs_walsh";

mod_schemes = {'OTFS-Hadamard', 'OTFS-Walsh'};

MOD_SIZE = 4;

% SNR
SNR_step = 10; % Incremento de SNR em dB
SNR_values = 10:SNR_step:20; % Vetor de valores de SNR

% Number of Iterations
num = 1000;

% Initialize BER_values object for all modulation types
BER_values = zeros(length(mod_schemes), length(SNR_values));


%[1]Low-Complexity VLSI Architecture for OTFS Transceiver Under Multipath Fading Channel
%[2]Performance Evaluation of OTFS Over Measured V2V Channels at 60 GHz
%[3]A Robust and Low-Complexity Walsh-Hadamard Modulation for Doubly-Dispersive Channels

% Define selected (N, M, spd, fc, delta_f) tuples
simulation_params = [
    16, 16, 500, 6e9, 30e3; %[1]

    8, 8, 50, 60e9, 625000;%BW=5MHz, [2]
    %8, 64, 50, 60e9, 78125;%BW=5MHz, [2]
    8, 8, 50, 60e9, 5e6;%BW=40MHz, [2]
    %8, 64, 50, 60e9, 625e3;%BW=40MHz, [2]
    8, 8, 50, 60e9, 15e6; %BW=120MHz, [2]
    %8, 64, 50, 60e9, 1.875e6; %BW=120MHz, [2]

    %16, 64, 300, 5.9e9, 78.125e3;%BW=5MHz [3]
    %4, 128, 300, 5.9e9, 78.125e3;%BW=10MHz [3]
];

for idx = 1:size(simulation_params)
    N = simulation_params(idx, 1);
    M = simulation_params(idx, 2);
    spd = simulation_params(idx, 3);
    fc = simulation_params(idx, 4);
    delta_f = simulation_params(idx, 5);

    %Título do plot
    plot_title = sprintf('Iterações=%d,N=%d,M=%d,spd(km/h)=%d,delta_f(KHz)=%.2f, f_c(GHz)=%.2f', num, N, M, spd, (delta_f/1e3), (fc/1e9));

    for channel_model_selector = 1:1
        delays_arr = [];
        pdp_arr = [];
        channel_model_name = "";
        switch(channel_model_selector)
            case 1
                delays_arr = delays_EVA;
                pdp_arr = pdp_EVA;
                channel_model_name = "EVA";
            case 2
                delays_arr = delays_EPA;
                pdp_arr = pdp_EPA;
                channel_model_name = "EPA";
            case 3
                delays_arr = delays_ETU;
                pdp_arr = pdp_ETU;
                channel_model_name = "ETU";
        end

        mod_size = MOD_SIZE;
        for type = 1:length(mod_schemes) % Loop over modulation schemes
          % Loop sobre os valores de SNR
          for snr_idx = 1:length(SNR_values)
              SNR_db = SNR_values(snr_idx);
              total_errors = 0;
              total_bits = 0;

              % Simule para o valor atual de SNR
              for i = 1:num
                  disp(['Type = ', num2str(type), ', SNR #',num2str(SNR_db), ', Iteration #', num2str(i)]);
                  if (type == 1)
                    [x, x_hat] = otfs_hadamard(N, M, spd, fc, delta_f, SNR_db, mod_size, delays_arr, pdp_arr);
                  elseif (type == 2)
                    [x, x_hat] = otfs_walsh(N, M, spd, fc, delta_f, SNR_db, mod_size, delays_arr, pdp_arr);
                  end

                  % Verifique se x e x_hat têm o mesmo comprimento
                  if length(x) ~= length(x_hat)
                      %disp(['Temperature is:' num2str(UU(90)) 'After: ' num2str(timeInMinutes) ' minutes']);
                      disp('x e x_hat devem ter o mesmo comprimento.');
                      disp(['size(x):' num2str(length(x))]);
                      disp(['size(x_hat)' num2str(length(x_hat))]);
                      continue;
                  end

                  % Calcule o número de erros para esta execução
                  errors = sum(x ~= x_hat);

                  % Atualize os contadores totais
                  total_errors = total_errors + errors;
                  total_bits = total_bits + length(x);
              end

              % Calcule o BER para o valor atual de SNR
              BER_values(type, snr_idx) = total_errors / total_bits;

              % Write BER values to a file
              filename = 'ber_values.txt';
              file = fopen(filename, 'a'); % Open file in append mode
              if file == -1
                  error('Could not open file for writing.');
              end
              dateAndTime = datestr(now(), 'yyyy_mmmm_dd_HH-MM-SS');
              fprintf(file, 'Date: %s: Type: %d, Modulation: %d-QAM, SNR: %f, BER: %e\n', dateAndTime, type, mod_size, SNR_db, BER_values(type, snr_idx));
              fclose(file);
          end
        end

        % Replace zeros in BER_values with a small positive value
        BER_values(BER_values == 0) = 1e-10;

        % Use a stable renderer
        set(gcf, 'renderer', 'painters'); % Or use graphics_toolkit('gnuplot');

        % Plot BER vs. SNR
        fig = figure('visible', 'off');
        hold on;
        for type = 1:length(mod_schemes) % Adjust loop range to valid indices
            semilogy(SNR_values, BER_values(type, :), '-o', 'LineWidth', 1.5, 'DisplayName', mod_schemes{type});
        end
        grid on;
        set(gca, 'YScale', 'log');
        xlabel('SNR (dB)');
        ylabel(sprintf('BER - [%d QAM, %s Channel Model]', mod_size, channel_model_name));
        legend('show');
        title(plot_title);
        dateAndTime = datestr(now(), 'yyyy_mmmm_dd_HH-MM-SS');
        fname = sprintf('%s%s_%s_%d-QAM.png', directory, dateAndTime, channel_model_name, mod_size);
        print(fname, '-dpng', '-r300'); % Save as PNG with 300 DPI resolution
    end
end
