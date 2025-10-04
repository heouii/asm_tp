section .bss
    buffer resb 1024

section .text
    global _start

_start:
    mov rcx, [rsp]
    cmp rcx, 2
    jne error
    
    mov rsi, [rsp + 16]
    xor rcx, rcx
    
get_length:
    mov al, [rsi + rcx]
    test al, al
    je check_palindrome
    inc rcx
    jmp get_length
    
check_palindrome:
    test rcx, rcx
    je is_palindrome
    
    xor rdx, rdx
    mov r8, rcx
    dec r8
    
compare_loop:
    cmp rdx, r8
    jge is_palindrome
    
    mov al, [rsi + rdx]
    mov bl, [rsi + r8]
    
    cmp al, bl
    jne not_palindrome
    
    inc rdx
    dec r8
    jmp compare_loop
    
is_palindrome:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_true
    mov rdx, 2
    syscall
    
    xor rdi, rdi
    jmp exit
    
not_palindrome:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_false
    mov rdx, 2
    syscall
    
    xor rdi, rdi
    jmp exit
    
error:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_false
    mov rdx, 2
    syscall
    
    mov rdi, 1
    
exit:
    mov rax, 60
    syscall

section .data
    msg_true db '1', 10
    msg_false db '0', 10