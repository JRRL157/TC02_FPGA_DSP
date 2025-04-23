/*
* FUNCAO : Comunicação UDP e FPGA
* PROJETO: TOPICOS EM COMUNICAO 02
*/

//Do codigo basico
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include "hwlib.h"
#include "socal.h"
#include "hps.h"
#include "alt_gpio.h"
#include "hps_0.h"
#include "peripheral.h"

//do codigo de Breno
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/ipc.h> 
#include <sys/shm.h> 
#include <time.h> 
#include <math.h> 
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>

#include <unistd.h>

//UDP
#define N_BUF    20

//Dual Port RAM
#define DP_RAM_BASE_ADDR 0x40000
#define DP_RAM_WIDTH 32
#define DP_RAM_SPAN 4
#define DP_RAM_MEM_SPAN DP_RAM_WIDTH*DP_RAM_SPAN

#define CONTROL_OFFSET 0x00
#define DATA_IN_OFFSET 0x01
#define DATA_OUT_OFFSET 0x02
#define STATUS_OFFSET 0x03

int main()
{
	//Codigo UDP:
	int sock, length, n, flags;
	socklen_t fromlen;
	struct sockaddr_in server;
	struct sockaddr_in from;
	char buf[N_BUF];

	//Dual port RAM
	peripheral perif;

	sock=socket(AF_INET, SOCK_DGRAM, 0);
	if (sock < 0) printf("Opening socket");

	length = sizeof(server);
	bzero(&server,length);
	server.sin_family=AF_INET;
	server.sin_addr.s_addr=INADDR_ANY;
	server.sin_port=htons(9090);

	if (bind(sock, (struct sockaddr *) &server, length) < 0)
	    printf("binding");
	fromlen = sizeof(struct sockaddr_in);

	printf("*---------------------------------------------------------------------\n");
	printf("* FUNCTION       : UDP COMMUNICATION TEST\n");
	printf("* PROJECT        : TOPICOS EM COMUNICAO 02\n");
	printf("* DATE           : 2025.1 - 26/03/2025\n");
	printf("*---------------------------------------------------------------------\n");

	while(1)
	{
		printf("Aguardando pacote do PC...\n");
		bzero(buf, N_BUF);
	   	n = recvfrom(sock, buf, N_BUF, 0, (struct sockaddr *) &from, &fromlen);

		uint32_t a, b, res;

		if (sscanf(buf, "%u,%u", &a, &b) != 2) {
			printf("Erro ao extrair os parâmetros!");
			return -1;
		}

		uint32_t numbers = (a << 4) + b;

		uint32_t status;
		uint32_t data_out;

		perif = peripheral_create(DP_RAM_BASE_ADDR, DP_RAM_MEM_SPAN);
		peripheral_write32(perif, CONTROL_OFFSET, 0x1);
		peripheral_write32(perif, DATA_IN_OFFSET, numbers);

		do {
			status = peripheral_read32(perif, STATUS_OFFSET);
		} while((status & 0x1) == 0);

		data_out = peripheral_read32(perif, DATA_OUT_OFFSET);
		peripheral_write32(perif, STATUS_OFFSET, 0x0);

		printf("Data out = %x, %u\n", data_out, data_out);

		res = a * b;
		printf("Resultado = %u\n", res);

	   	if (n < 0) printf("recvfrom");
	   	else
	   	{
			printf("Esperando um tempo\n");
			usleep(1000); //Esperando um tempo para ver se o python espera a mensagem;

			bzero(buf, N_BUF);
			snprintf(buf, sizeof(buf), "%u", res);

			printf("Devolvendo pacote recebido:\n");
			n = sendto(sock, buf, sizeof(res), 0, (struct sockaddr *) &from, fromlen);
			if (n  < 0) printf("sendto");
		}
	}
}
