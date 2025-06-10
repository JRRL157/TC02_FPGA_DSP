#!/usr/bin/env fish

set main_src $argv[1]
set lib_src $argv[2]

echo "Compiling main source: $main_src"
gcc -c $main_src $lib_src -o main.o
echo "SUCCESS: Compiled main source."
