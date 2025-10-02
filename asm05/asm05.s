section .text
    global _start

_start:
    mov rsi, [rsp+16]
    mov rdx, 0

find_len:
    mov al, [rsi+rdx]
    cmp al, 0
    je print
    inc rdx
    jmp find_len

print:
    mov rax, 1
    mov rdi, 1
    mov rsi, [rsp+16]
    syscall

    mov rax, 60
    xor rdi, rdi