#!/bin/bash
MAINFILE="fwht_samples_creator.c"
LIBSRC="../dwht.c"

#PARAMETERS
N=32
ITER=100000
INFILE=../samples/input_samples_$N.txt
OUTFILE=../samples/output_samples_$N.txt

echo "Compiling main source: $MAINFILE"
gcc $MAINFILE $LIBSRC -o fwht_samples_creator.out -std=c99 -lm -Wall
echo "SUCCESS: Compiled main source."

chmod +x fwht_samples_creator.out
echo "Executing created executable..."
./fwht_samples_creator.out $N $ITER $INFILE $OUTFILE
