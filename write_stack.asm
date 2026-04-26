extern my_exit
global main

section .text

main:
    sub rsp, 32              ; reserva espaço na stack

    ; "usando a stack agora\n"
    mov byte [rsp + 0], 'u'
    mov byte [rsp + 1], 's'
    mov byte [rsp + 2], 'a'
    mov byte [rsp + 3], 'n'
    mov byte [rsp + 4], 'd'
    mov byte [rsp + 5], 'o'
    mov byte [rsp + 6], ' '
    mov byte [rsp + 7], 'a'
    mov byte [rsp + 8], ' '
    mov byte [rsp + 9], 's'
    mov byte [rsp + 10], 't'
    mov byte [rsp + 11], 'a'
    mov byte [rsp + 12], 'c'
    mov byte [rsp + 13], 'k'
    mov byte [rsp + 14], ' '
    mov byte [rsp + 15], 'a'
    mov byte [rsp + 16], 'g'
    mov byte [rsp + 17], 'o'
    mov byte [rsp + 18], 'r'
    mov byte [rsp + 19], 'a'
    mov byte [rsp + 20], 10   ; '\n'

    ;preparando a write
    mov rax, 1                ; syscall write
    mov rdi, 1                ; stdout
    mov rsi, rsp              ; buffer na stack
    mov rdx, 21               ; tamanho
    syscall

    add rsp, 32              ; limpa stack

    call my_exit
