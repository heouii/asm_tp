section .data
    msg db "1337", 0xA
    len equ $-msg

section .text
    global _start

_start:
    mov rbx, [rsp+16]      

   
    cmp rbx, 0
    je exit_code_1

    mov al, [rbx]
    cmp al, '4'
    jne exit_code_1

    mov al, [rbx+1]
    cmp al, '2'
    jne exit_code_1

    mov al, [rbx+2]
    cmp al, 0
    jne exit_code_1

    
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, len
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

exit_code_1:
    mov rax, 60
    mov rdi, 1
    syscall
