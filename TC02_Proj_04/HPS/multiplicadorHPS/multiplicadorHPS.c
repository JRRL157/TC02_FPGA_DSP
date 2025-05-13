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
#define N_BUF    8

//Dual Port RAM
#define DP_RAM_BASE_ADDR 0x40000
#define DP_RAM_WIDTH 32
#define DP_RAM_SPAN 4
#define DP_RAM_MEM_SPAN DP_RAM_WIDTH*DP_RAM_SPAN

#define CONTROL_OFFSET 0
#define DATA_IN_OFFSET 1
#define DATA_OUT_OFFSET 2
#define STATUS_OFFSET 3

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

		printf("Writing %x to DATA_IN address\n", numbers);
		peripheral_write32(perif, DATA_IN_OFFSET, numbers);

		uint32_t numbers_wrt = peripheral_read32(perif, DATA_IN_OFFSET);
		printf("Wrote %x in address %x\n", numbers_wrt, DP_RAM_BASE_ADDR + DATA_IN_OFFSET);

		printf("Writing 0x1 to Control address\n");
		peripheral_write32(perif, CONTROL_OFFSET, 0x1);

		do {
			usleep(100000);
			data_out = peripheral_read32(perif, DATA_OUT_OFFSET);
			/*
			if(data_out != 0) {
				printf("Data out = %x\n", data_out);
				break;
			}
			else {
				printf("Waiting for data...\n");
			}
			*/
			status = peripheral_read32(perif, STATUS_OFFSET);
		} while(status == 0);

		data_out = peripheral_read32(perif, DATA_OUT_OFFSET);
		printf("Data out = %x, %u\n", data_out, data_out);

		printf("%u * %u = %u\n", a, b, data_out);

	   	if (n < 0) printf("recvfrom");
	   	else
	   	{
			printf("Esperando um tempo\n");
			usleep(1000*1000*3); //Esperando um tempo para ver se o python espera a mensagem;

			bzero(buf, N_BUF);
			snprintf(buf, sizeof(buf), "%u", data_out);

			printf("Devolvendo pacote recebido:\n");
			n = sendto(sock, buf, sizeof(res), 0, (struct sockaddr *) &from, fromlen);
			if (n  < 0) printf("sendto");

			printf("Writing 0 to Status OFFSET\n");
			usleep(10000);
			peripheral_write32(perif, CONTROL_OFFSET, 0x0);
		}
	}
}
