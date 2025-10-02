section .bss
    buffer resb 20

section .text
    global _start

_start:
    mov rax, [rsp]
    cmp rax, 3
    jne error

    mov rsi, [rsp+16]      
    mov rdi, [rsp+24]      


    xor rbx, rbx
    xor rcx, rcx
convert1:
    mov al, [rsi+rcx]
    cmp al, 0
    je next
    sub al, '0'
    imul rbx, rbx, 10
    add rbx, rax
    inc rcx
    jmp convert1

next:
    
    xor rdx, rdx
    xor rcx, rcx
convert2:
    mov al, [rdi+rcx]
    cmp al, 0
    je add
    sub al, '0'
    imul rdx, rdx, 10
    add rdx, rax
    inc rcx
    jmp convert2

add:
    add rbx, rdx

    
    mov rcx, buffer
    mov rsi, rbx
    mov rdx, 0
reverse:
    mov rax, rsi
    xor rdx, rdx
    mov rbx, 10
    div rbx
    add dl, '0'
    mov [rcx], dl
    inc rcx
    mov rsi, rax
    test rax, rax
    jnz reverse

    
    mov rbx, rcx
    sub rbx, buffer
    mov rcx, buffer
result:
    dec rcx
    mov al, [rcx]
    mov [rcx+rbx], al
    cmp rcx, buffer
    jne result

    mov rax, 1
    mov rdi, 1
    mov rsi, buffer+rbx
    mov rdx, rbx
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

error:
    mov rax, 60
    mov rdi, 1
    syscall