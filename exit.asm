global my_exit ; ponto de entrada global. e necessario linkarlo com a opcao -e main pra demonstrar pro liker o ponto de entrada. ele por padrao usa _start

section .text

my_exit:
    ; tal syscall e utilizada com o finco de retrno de sucesso ao fim de um programa
    ; ela e necessaria para evitar erros de segmentation fault
    ;com ela, finalizamos um processo de maneira segura

    mov rax,60 ; numero da chamada de sistema definida na tabela de chamadas do linux
                ; podemos velas em arch/x86/entry/syscalls/syscall_64.tbl
    xor rdi,rdi ; codigo de saida 0, tudo certo

    syscall ; kernel vai verificar rax, e associar aos padroes exigidos pela chamada de sistema exit


            ; para confirmar o retorno, utilize o comando echo $?
