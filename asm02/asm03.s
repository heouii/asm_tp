section .data
    num db '1337',0xA

section .text
    global _start

_start:
    mov rax, 0
    mov rdi, 0
    cmp rax, 42
    je egal


egal:
    mov rax, 1       
    mov rdi, 1
    mov rsi, num    
    mov rdx, 4
    syscall          

    mov rax, 60
    mov rdi, 0
    syscall