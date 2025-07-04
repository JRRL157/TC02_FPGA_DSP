#!/bin/bash
PASTA_LOCAL="./multiplicadorCUSTOM"
IP_DESTINO="root@192.168.0.100"
PASTA_RAIZ_PROJETO="TC_02_JRRL"
PASTA_DESTINO=$PASTA_RAIZ_PROJETO/"multiplicadorCUSTOM"
echo "Subindo Arquivos do Projeto - $PASTA_LOCAL:"
scp $PASTA_LOCAL/* $IP_DESTINO:/home/root/$PASTA_DESTINO
echo "Subindo Bibliotecas comuns a todos os projetos:"
scp ./INC/* $IP_DESTINO:/home/root/$PASTA_RAIZ_PROJETO/INC
