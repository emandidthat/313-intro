; Name: Emmanuel Aroh
; Date: 5/15/2025
; Class: CMSC 313

; Description: This program converts a byte array to its hexadecimal ASCII representation

section .data
inputBuf:   db 0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A
inputLen:   equ 8                       ; total number of bytes to translate
hexChars:   db '0123456789ABCDEF'       ; lookup table for converting nibble to ASCII

section .bss
outputBuf:  resb 80                     ; output buffer to hold converted hex text

section .text
global _start

_start:
    mov esi, inputBuf     ; point to start of input buffer
    mov edi, outputBuf    ; point to start of output buffer
    mov ecx, inputLen     ; counter for number of bytes to convert

convert_loop:
    lodsb                 ; load one byte from inputBuf into AL, increment ESI

    ; Isolate and translate high nibble (first 4 bits)
    movzx edx, al         ; zero-extend AL to EDX to safely shift and index
    shr edx, 4            ; shift right to get high nibble
    mov bl, [hexChars + edx] ; get corresponding ASCII hex character
    mov [edi], bl         ; store character in output buffer
    inc edi               ; move to next position

    ; Isolate and translate low nibble (last 4 bits)
    movzx edx, al         ; re-zero-extend original byte
    and edx, 0x0F         ; mask to get low nibble
    mov bl, [hexChars + edx] ; convert to ASCII hex character
    mov [edi], bl         ; store in output buffer
    inc edi               ; move to next position

    ; Add space after each hex pair for formatting
    mov byte [edi], ' '
    inc edi

    loop convert_loop     ; repeat for all bytes

    ; Replace the final space with newline character (ASCII 10)
    dec edi
    mov byte [edi], 10

    ; Set up system call to write output to stdout
    mov eax, 4            ; sys_write
    mov ebx, 1            ; file descriptor for stdout
    mov ecx, outputBuf    ; buffer to write
    mov edx, edi          ; current position (end of data)
    sub edx, outputBuf    ; calculate length of output
    inc edx               ; include newline

    int 0x80              ; perform system call

    ; Exit the program cleanly
    mov eax, 1            ; sys_exit
    xor ebx, ebx
    int 0x80
    
 
