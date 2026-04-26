extern my_exit ; importando o codigo de saida segura, o mesmo mostrado anteriormente
global main ; Main entry point. avisar o linker com -e main

section .data ; label de data --> dados inicializados

    string: db 'Write usando a label data',10 ; define byte terminando em \n(10)
    tamanho: equ $ - string ; constante pra pegar o tamanho da string

section .text ; label de execucao

main:

    mov rax,1 ; syscall write (1)
    mov rdi,1 ; file decriptor de stdout(1)

    mov rsi,string ; ponteiro pra string
    mov rdx,tamanho  ; tamanho da string
    syscall ; kernel execute isso
    call my_exit



