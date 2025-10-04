section .bss
    buffer resb 1024

section .text
    global _start

_start:
    mov rcx, [rsp]
    cmp rcx, 2
    jne error
    
    mov rsi, [rsp + 16]
    mov rdi, buffer
    xor rcx, rcx
    
get_length:
    mov al, [rsi + rcx]
    test al, al
    je reverse
    inc rcx
    jmp get_length
    
reverse:
    test rcx, rcx
    je print_result
    dec rcx
    xor rdx, rdx
    
reverse_loop:
    mov al, [rsi + rcx]
    mov [rdi + rdx], al
    inc rdx
    test rcx, rcx
    je print_result
    dec rcx
    jmp reverse_loop
    
print_result:
    mov byte [rdi + rdx], 10
    inc rdx
    
    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    syscall
    
    xor rdi, rdi
    jmp exit
    
error:
    mov rax, 1
    mov rdi, 1
    mov rsi, error_msg
    mov rdx, 2
    syscall
    
    mov rdi, 1
    
exit:
    mov rax, 60
    syscall

section .data
    error_msg db '0', 10