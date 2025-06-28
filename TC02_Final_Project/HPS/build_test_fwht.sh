#!/bin/bash
MAINFILE="fwht_test.c"
LIBSRC="dwht.c"

echo "Compiling main source: $MAINFILE"
gcc $MAINFILE $LIBSRC -o fwht_test.out -std=c99 -lm -Wall
echo "SUCCESS: Compiled main source."
chmod +x fwht_test.out
echo "Executing created executable..."
./fwht_test.out