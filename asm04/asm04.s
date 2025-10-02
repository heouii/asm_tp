section .bss

    buffer resb 10

section .data

section .text
        

_START:
    mov rax, 0 
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 10 
    syscall


    mov rsi, buffer 
    xor rbx, rbx
    xor rcx, rcx


convert:

    mov al, [rsi+rcx]
    cmp al, 0xA
    je test
    cmp al, '0'
    jl test
    cmp al, '9'
    jg test
    sub al, '0'
    imul rbx,  rbx, 10
    add rbx, rax
    inc rcx
    jmp convert
test:
    mov rbx, 1 
    jz pair
    jmp impair

pair:
    mov rax, 60
    xor rdi, rdi
    syscall


impair:
    mov rax, 60
    xor rdi, 1
    syscall






