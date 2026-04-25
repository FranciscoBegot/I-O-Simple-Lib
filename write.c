#include <unistd.h>
#include <sys/syscall.h>

int main(){
    
    char msg[] = "Hello,Prof Diego so que com syscall.h\n";

    write(1,"Hello,Prof Diego!\n",18); // Aqui usamos a funcao write de unistd pra invocar a chamada de write
    syscall(SYS_write, 1, msg,sizeof(msg)-1); // aqui usamos a syscall.h para chamar a syscall de write
    _exit(0); // saida segura com unistd.h ( EXIT syscall) 



    }
