# hw11translate2Ascii

This repository contains a simple x86 assembly program that reads an array of bytes, 
converts each byte to its hexadecimal ASCII representation, and prints the result to the screen.

## Build Instructions

### Requirements

- Linux environment (or WSL)
- NASM assembler
- Linker (`ld`)
- 32-bit support installed

### Build and Run

nasm -f elf32 -g -F dwarf -o hw11translate2Ascii.o hw11translate2Ascii.asm
ld -m elf_i386 hw11translate2Ascii.o -o hw11translate2Ascii
./hw11translate2Ascii
