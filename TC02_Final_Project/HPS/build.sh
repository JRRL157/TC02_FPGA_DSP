#!/bin/bash
MAINFILE="$1"
LIBSRC="$2"

echo "Compiling main source: $main_src"
gcc $MAINFILE $LIBSRC -o main.o -std=c99
echo "SUCCESS: Compiled main source."
chmod +x main.o
echo "Executing created executable..."
./main.o