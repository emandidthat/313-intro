; Name: Emmanuel Aroh
; Date: 5/15/2025
; Class: CMSC 313

; Description: This program converts a byte array to its hexadecimal ASCII representation

section .data
inputBuf:   db 0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A
inputLen:   equ 8

hexChars:   db '0123456789ABCDEF'

section .bss
outputBuf:  resb 80     ; space for output

section .text
global _start

_start:
    mov esi, inputBuf     ; source pointer
    mov edi, outputBuf    ; destination pointer
    mov ecx, inputLen     ; number of bytes

convert_loop:
    lodsb                 ; load byte into AL from [ESI], ESI++
    
    ; high nibble
    movzx edx, al         ; zero extend AL into EDX
    shr edx, 4            ; get high nibble
    mov bl, [hexChars + edx]
    mov [edi], bl
    inc edi

    ; low nibble
    movzx edx, al         ; zero extend AL again (original byte still in AL)
    and edx, 0x0F         ; mask low nibble
    mov bl, [hexChars + edx]
    mov [edi], bl
    inc edi

    ; add space
    mov byte [edi], ' '
    inc edi

    loop convert_loop

    ; replace last space with newline
    dec edi
    mov byte [edi], 10    ; newline char

    ; print to screen
    mov eax, 4            ; sys_write
    mov ebx, 1            ; stdout
    mov ecx, outputBuf    ; buffer
    mov edx, edi          ; current pointer
    sub edx, outputBuf    ; length = edi - outputBuf
    inc edx               ; include newline

    int 0x80

    ; exit
    mov eax, 1            ; sys_exit
    xor ebx, ebx
    int 0x80
