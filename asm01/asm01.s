section .data
    num db '1337',0xA
    buffer times 3 db

section .text
    global _start

_start:
    mov rax, 1       
    mov rdi, 1
    mov rsi, num    
    mov rdx, 4
    syscall          

    mov rax, 60
    mov rdi, 0
    syscall