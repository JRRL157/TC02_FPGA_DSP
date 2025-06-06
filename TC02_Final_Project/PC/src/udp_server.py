import socket
import struct
import numpy as np
from dwht import dwht_1d, dwht_2d

def udp_server(server_ip: str, server_port: int, buffer_size: int = 1024) -> None:
    """
    Listens for UDP packets, performs a dummy operation, and sends back a response.

    Args:
        server_ip (str): The IP address to listen on.
        server_port (int): The port to listen on.
        buffer_size (int): The maximum packet size that the server will accept
    """
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind((server_ip, server_port))

    print(f"Listening on {server_ip}:{server_port}")

    while True:
        try:
            data, addr = sock.recvfrom(buffer_size)
            print(f"Received {len(data)} bytes from {addr}")

            # Unpack the received data (assuming it's an array of doubles)
            received_data = np.frombuffer(data, dtype=np.float64)            

            print(received_data)
            print(received_data.shape)

            # Concatenate the results
            response_data = dwht_1d(received_data, received_data.shape[0])

            # Pack the response data
            response_bytes = response_data.tobytes()

            # Send the response back to the client
            sock.sendto(response_bytes, addr)
            print(f"Sent {len(response_bytes)} bytes back to {addr}")

        except Exception as e:
            print(f"Error processing data: {e}")

def udp_server_matrix(server_ip: str, server_port: int, buffer_size: int = 1024) -> None:
    """
    Listens for UDP packets, performs a dummy operation, and sends back a response.

    Args:
        server_ip (str): The IP address to listen on.
        server_port (int): The port to listen on.
        buffer_size (int): The maximum packet size that the server will accept
    """
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind((server_ip, server_port))

    print(f"Listening on {server_ip}:{server_port}")

    while True:
        try:
            data, addr = sock.recvfrom(buffer_size)
            print(f"Received {len(data)} bytes from {addr}")

            # Unpack the received data (assuming it's an array of doubles)
            received_data = np.frombuffer(data, dtype=np.float64)            

            print(received_data)
            print(received_data.shape)
            N = received_data[0].astype(int)
            M = received_data[1].astype(int)
            matrix_data = received_data[2:].reshape((N, M))

            print(matrix_data)
            # Concatenate the results
            response_data = dwht_2d(matrix_data, N, M)

            # Pack the response data
            response_bytes = response_data.tobytes()

            # Send the response back to the client
            sock.sendto(response_bytes, addr)
            print(f"Sent {len(response_bytes)} bytes back to {addr}")

        except Exception as e:
            print(f"Error processing data: {e}")

if __name__ == '__main__':
    # Replace with your desired IP and port
    SERVER_IP = "127.0.0.1"  # Listen on all interfaces
    SERVER_PORT = 5005

    udp_server_matrix(SERVER_IP, SERVER_PORT)
