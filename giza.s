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
        call    atoi			# eax
	mov	%eax, %r12d
	mov     $0, %r8d                # counter
	mov     $0, %r9d                # j
	mov	$0, %r10d
#	mov	$0, %r11d	#breakpoint variable! (new)
	jmp	loop1

loop1:
	cmp	%r8d, %r12d		# compare i with input value
	jg	loop2
	jle	end

loop2:
        add    	$1, %r8d
	jmp 	loop3

loop3:
        cmp	%r9d, %r10d
	jge	write
	jl	write2

write:
        add     $1, %r9d
        mov     $1, %rax                # system call 1 is write
        mov     $1, %rdi                # file handle 1 is stdout
        mov     $message, %rsi         # address of string to output
        mov     $1, %rdx                # number of bytes
        syscall
	jmp	loop3

       # char* message = "Hello, world\n"

write2:
        mov     $1, %rax                # system call 1 is write
	mov     $1, %rdi                # file handle 1 is stdout
        mov     $message2, %rsi         # address of string to output
        mov     $1, %rdx                # number of bytes
        syscall
	mov     $0, %r9d
	add	$1, %r10d
        jmp	loop1

end:
        # write and exit(0)
        mov     $1, %rax                # system call 1 is write
        mov     $1, %rdi                # file handle 1 is stdout
        mov     $message3, %rsi         # address of string to output
        mov     $7, %rdx                # number of bytes
        syscall

        mov     $60, %rax               # system call 60 is exit
        mov     $0, %rdi                # we want return code 0
        syscall                         # invoke operating system to exit

test:
        mov     $1, %rax                # system call 1 is write
	mov     $1, %rdi                # file handle 1 is stdout
        mov     $message4, %rsi         # address of string to output
        mov     $5, %rdx                # number of bytes
        syscall
        jmp     end

message:
                .ascii  "*"

message2:
                .ascii "\n"

message3:
                .ascii "Finito\n"

message4:
		.ascii "Test\n"
