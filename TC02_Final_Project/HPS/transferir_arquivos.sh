#!/bin/bash
IP_DESTINO="root@10.42.0.23"
PASTA_RAIZ_PROJETO="TC_02_JRRL"
PASTA_DESTINO=$PASTA_RAIZ_PROJETO/"Final_project"

scp udp_matrix_server.c dwht.c dwht.h build.sh $IP_DESTINO:/home/root/$PASTA_DESTINO/