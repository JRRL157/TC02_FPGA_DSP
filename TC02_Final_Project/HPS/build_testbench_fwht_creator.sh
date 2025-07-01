#!/bin/bash
MAINFILE="fwht_samples_creator.c"
LIBSRC="dwht.c"

echo "Compiling main source: $MAINFILE"
gcc $MAINFILE $LIBSRC -o fwht_samples_creator.out -std=c99 -lm -Wall
echo "SUCCESS: Compiled main source."
chmod +x fwht_samples_creator.out
echo "Executing created executable..."
./fwht_samples_creator.out