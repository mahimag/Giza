# Writes "Hello, World" to the console using only system calls. 
# Runs on 64-bit Linux only.
#
# To run
#     gcc -no-pie hello.s && ./a.out
# -----------------------------------------------------------

#r8d - is a 32 bit register
#r9d
#r10d
        .global main

        .text
main:
        # int main(int argc, char* argv[]) OR rdi, rsi OR ./a.out [NUM]
        mov     8(%rsi), %rdi           # char argv[1], int version
        call    atoi                    # eax
        syscall
        mov     $0, %r8d                # counter
        mov     $0, %r9d                # j
        jmp     loop
        jmp     theend

loop:
        cmp     %eax, %r8d          # compares input value with incr value
        jle     theend
        jg      loop2

loop3:
        cmp     %r8d, %r9d          # compares 0 to 1
        jge     loop2
        jl      loop4
loop4:
        dec     %r9d
        inc     %r8d
        jmp     write2

loop2:
        # write(1, message, 13)
        mov     $1, %rax                # system call 1 is write
        mov     $1, %rdi                # file handle 1 is stdout
        mov     $message, %rsi          # address of string to output    
        mov     $1, %rdx                # number of bytes
        syscall
        inc     %r9d
        jmp     loop3

theend:
        # exit(0)
                # write
        mov     $1, %rax                # system call 1 is write
        mov     $1, %rdi                # file handle 1 is stdout
        mov     $message3, %rsi         # address of string to output
        mov     $7, %rdx                # number of bytes
        syscall

        mov     $60, %rax               # system call 60 is exit
        mov     $0, %rdi                # we want return code 0
        syscall                         # invoke operating system to exit

write2:
        # write
        mov     $1, %rax                # system call 1 is write
        mov     $1, %rdi                # file handle 1 is stdout
       mov     $message2, %rsi         # address of string to output
        mov     $1, %rdx                # number of bytes
        syscall
        jmp loop

       # char* message = "Hello, world\n"

test:
                # write
        mov     $1, %rax                # system call 1 is write
        mov     $1, %rdi                # file handle 1 is stdout
       mov     $message4, %rsi         # address of string to output
        mov     $6, %rdx                # number of bytes
        syscall
        jmp     theend

message: 
                .ascii  "*"

message2: 
                .ascii "\n" 

message3:
                .ascii "Finito\n"

message4:
                .ascii "Mahima"
