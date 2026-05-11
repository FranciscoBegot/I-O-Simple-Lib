#include <unistd.h> // unix standard library

int main() {
    char buffer[50]; // buffer to store keyboard input data

    // ssize_t --> signed integer type, used to represent sizes OR errors
    // here we store the number of bytes read into the 'entrada' variable
    ssize_t entrada = read(0, buffer, sizeof(buffer) - 1); 

    if (entrada > 0) // if the read was successful...
        // print the stored value using the exact number of bytes read
        write(1, buffer, entrada); 

    _exit(0); // safe exit via syscall
}
