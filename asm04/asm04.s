section .bss
    buffer resb 10

section .text
    global _START

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
    je test_parity
    cmp al, 0           
    je test_parity
    cmp al, '0'
    jl invalid_input    
    cmp al, '9'
    jg invalid_input    
    sub al, '0'
    imul rbx, rbx, 10
    add rbx, rax
    inc rcx
    jmp convert

invalid_input:
    mov rax, 60
    mov rdi, 2          
    syscall

test_parity:
    test rbx, 1
    jz even
    mov rax, 60
    mov rdi, 1          
    syscall

even:
    mov rax, 60
    xor rdi, rdi        
    syscall






