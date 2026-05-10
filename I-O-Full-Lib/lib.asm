global exit,print_newl,string_lenght,print_string,string,print_char,string2,clear,read_keyboard,string3,print_int ; letting the linker see these functions for other files
;;;;;;;;;;;;;;;;;;;;;

section .data

nl db 10,0 ; just a newline character followed by a null terminator 

string: db 'I/O lib lhes deseja boas vindas!',0 ; welcome message for the user
string2: db "Digite algo de até 100 caracteres:",0 ; prompt for keyboard input
string3: db "Você digitou: ",0 ; label to show what was captured
string4: db "A primeira letra da string é :",0 ; label for the first character extraction
string5: db "Para finalizar, a string têm: ",0 ; part of the final count message
string6: db " caracteres",0 ; unit label for the length display

clear_screen: db 27, '[2J', 27, '[H' ; ansi codes to wipe the terminal and reset cursor
;;;;;;;;;;;;;;;;;;;;;;;;;

section .bss
buffer: resb 100 ; reserving 100 bytes for whatever the user types
res_buffer: resb 21 ; space to hold the converted number string

;;;;;;;;;;;;;;;;;;;;;;;;;
section .text

exit: ; start of the exit routine
        mov rax,60 ; rax 60 is the code for sys_exit in linux
        xor rdi,rdi ; zero out rdi to return an exit code of 0
        syscall ; tell the kernel to shut it down
        ret ; won't actually reach here, but its a good practice (routine btw                                                                                                                                                        
;;;;;;;;;;;;;;;;;;;;;;;;

string_lenght:  ; function to count how many chars in a string

        xor rax,rax ; using rax as our counter, so start at zero
    
.loop_lenght: ; loop label for counting
        cmp byte [rdi + rax],0 ; check if the current byte is the null terminator
        je .end_lenght ; if it's zero, we found the end
        
        inc rax ; increment our counter by one
        jmp .loop_lenght ; go back and check the next byte
     
.end_lenght: ; wrap it up

        ret ; go back to whoever called us with the count in rax
;;;;;;;;;;;;;;;;;;;;;;;;;



print_string: ; wrapper for sys_write

    push rdi ; save the string pointer since string_lenght might change registers
    call string_lenght ; go find out how long this string is
    pop rsi ; put the pointer into rsi, which is where syscall 1 expects it
    
    mov rdx,rax ; move the count from rax into rdx for the syscall
    mov rax,1 ; syscall 1 is sys_write
    mov rdi,1 ; file descriptor 1 is stdout (the screen)
    syscall ; trigger the write
    ret ; all done

;;;;;;;;;;;;;;;;;;;;;;;;;
print_char: ; routine to grab and show just the first letter
    
    mov rdi,string4 ; load the label string
    call print_string ; print "the first letter is..."
    mov rdi,buffer ; point to the user input

    sub rsp,2 ; make a tiny bit of space on the stack
    mov al,[rdi]  ; grab the very first byte from the buffer
    mov byte [rsp],al ; put that byte on our temporary stack space
    mov byte [rsp +1],0 ; add a null terminator so print_string doesn't go crazy
    mov rdi,rsp ; point rdi to the character on the stack
    call print_string ; print that single char
    add rsp,2 ; clean up the stack space we used
   
    ret ; back to main
;;;;;;;;;;;;;;;;;;;;;;;;;

read_keyboard: ; capturing user input

    mov rax,0 ; syscall 0 is sys_read
    mov rdi,0 ; file descriptor 0 is stdin (the keyboard)

    mov rsi,buffer ; where to store the typed bytes
    mov rdx,99 ; don't read more than 99 bytes to stay safe
    syscall ; wait for the user to hit enter
    
    cmp rax,0 ; check if we actually read anything
    jle exit ; if something went wrong or empty, just quit 
    mov byte [buffer + rax], 0  ; stick a null terminator at the end of the input
   
    call clear ; wipe the screen to keep it tidy
   
    mov rdi,string3 ; load the "you typed" label
    call print_string ; show the label
    mov rdi,buffer ; point back to the user input
    call print_string ; print the actual input back to them

    ret ; return

;;;;;;;;;;;;;;;;;;;;;;;;;;;

clear: ; quick helper to clear the terminal

    mov rdi,clear_screen ; load the ansi escape sequence
    call print_string ; "print" the codes to the terminal

    ret ; return
;;;;;;;;;;;;;;;;;;;;;;;;;
print_newl: ; helper for a clean line break
    
    mov rdi,nl ; load the newline character
    call print_string ; print it
    ret ; return
;;;;;;;;;;;;;;;;;;;;;;;

print_int: ; complex part: turning a number into text   

    mov rdi,string5 ; load the "string has..." label
    call print_string ; print it

    mov rdi,buffer ; point to the user's string
    call string_lenght ; get the count
    dec rax             ; drop the count by 1 to ignore the '\n' character
    mov rdi, res_buffer + 20 ; start at the end of our small buffer (backwards)
    mov rbx, 10              ; we divide by 10 to peel off digits

.loop_convert: ; division loop
    
    dec rdi                  ; move the pointer back one spot
    xor rdx, rdx             ; clear rdx because div uses rdx:rax
    div rbx                 ; rax / 10. quotient in rax, remainder in rdx
    
    add dl, '0'              ; turn the remainder (0-9) into an ascii char
    mov [rdi], dl            ; store that character in our buffer
    
    test rax, rax            ; check if rax is finally zero
    jnz .loop_convert        ; if not, keep dividing

    ; now rdi points to the first digit of our number string
    call print_string ; print the converted number

    mov rdi,string6 ; load the "characters" unit label
    call print_string ; print it

    ret ; finally done
