import socket
import struct
import numpy as np
from dwht import dwht

def processing(data: np.ndarray) -> np.ndarray:
    """
    Dummy processing function that simulates some computation on the data.
    This function can be modified to perform any desired operation.
    
    Args:
        data (np.ndarray): Input data array.
    
    Returns:
        np.ndarray: Processed data array.
    """

    print(data.shape[0])
    output_data: np.ndarray = dwht(data, data.shape[0])

    return output_data

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

            # Concatenate the results
            response_data = processing(received_data)            

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

    udp_server(SERVER_IP, SERVER_PORT)