import socket
import numpy
import struct
import time

def communication(msgFromClient: str, ip_address: str, port: int) -> int:
    bytesToSend         = str.encode(msgFromClient)
    serverAddressPort   = (ip_address, port)
    bufferSize          = 20
    #bufferSize          = len(bytesToSend)

    UDPClientSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)

    print("ATENÇÃO! ENVIANDO PACOTE PARA A PORTA -", serverAddressPort)

    print("Mensagem  a ser enviada:", msgFromClient)

    print("Enviando a mensagem pelo socket criado")
    UDPClientSocket.sendto(bytesToSend, serverAddressPort)

    print("Esperando receber algo:")
    msgFromServer = UDPClientSocket.recvfrom(bufferSize)

    #num = struct.unpack('<I', msgFromServer[0][:4])[0]
    msg = msgFromServer[0].decode('utf-8').rstrip('\x00')
    print(f"Mensagem recebida: {msg}")

    return int(msg)

def multiplicar(num1: int, num2: int) -> int:
    return num1 * num2;

ip_address = "10.42.0.23"
port = 9090

quadro_final = {
    'error': 0,
    'total': 0,
    'occurrence': []
}
for a in range(1,16):
    for b in range(1,16):
        time.sleep(0.01)
        res = multiplicar(a,b)
        
        msg = f"{a},{b}"
        #msg = f"{hex(a).replace('0x','')}{hex(b).replace('0x','')}"
        print(msg)
        int_rec = communication(msg, ip_address, port)
        
        quadro_final['total'] += 1;
        if int_rec != res:
            quadro_final['error'] += 1
            quadro_final['occurrence'].append((a, b, res, int_rec))

print(quadro_final)
