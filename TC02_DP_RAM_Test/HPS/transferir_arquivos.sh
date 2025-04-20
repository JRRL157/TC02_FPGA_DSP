#!/bin/bash
PASTA_LOCAL="./testaRAM"
IP_DESTINO="root@10.42.0.23"
PASTA_RAIZ_PROJETO="TC_02_JRRL"
PASTA_DESTINO="testaRAM"
echo "Subindo Arquivos do Projeto - $PASTA_LOCAL:"
scp $PASTA_LOCAL/* $IP_DESTINO:/home/root/$PASTA_RAIZ_PROJETO/$PASTA_DESTINO
echo "Subindo Bibliotecas comuns a todos os projetos:"
scp ./INC/* $IP_DESTINO:/home/root/$PASTA_RAIZ_PROJETO/INC
