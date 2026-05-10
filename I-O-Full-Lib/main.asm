extern exit,print_newl,print_string,string_lenght,string,print_char,string2,read_keyboard,print_int ; importing all from lib.asm
global _start ; default entry point


section .text ; code to be exec
_start:

mov rdi,string ; rdi its our reference for strings and etc

call print_string
call print_newl
;#############

mov rdi,string2

call print_string
call print_newl
;#############'

call read_keyboard
call print_char 
call print_newl
call print_int
call print_newl

;#############

call exit ; quit from all of this

; to compile, use : nasm -felf64 lib.asm or main.asm
; to link, use ld main.o lib.o -o final_code
