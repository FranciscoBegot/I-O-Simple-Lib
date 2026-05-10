#include <unistd.h>
#include <sys/syscall.h>

int main(){
    
    char msg[] = "Hello,Prof Diego but with syscall.h\n";

   // we use the write function from unistd.h to invoke the write system call
    write(1, "Hello, Prof Diego!\n", 18); 

    // here we use syscall.h to manually trigger the write syscall by its ID
    syscall(SYS_write, 1, msg, sizeof(msg) - 1); 

    // safe exit using unistd.h to trigger the sys_exit syscall
    _exit(0);


    }
