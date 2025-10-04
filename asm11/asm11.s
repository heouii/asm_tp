section .data
    vowels db 'aeiouAEIOU', 0

section .bss
    count resb 1

section .text
    global _start

_start:
    mov rcx, [rsp]
    cmp rcx, 2
    jne error
    
    mov rsi, [rsp + 16]
    xor rdx, rdx
    
count_loop:
    lodsb
    test al, al
    je print_result
    
    mov rdi, vowels
    
check_vowel:
    mov bl, [rdi]
    test bl, bl
    je count_loop
    
    cmp al, bl
    je increment
    
    inc rdi
    jmp check_vowel
    
increment:
    inc rdx
    jmp count_loop
    
print_result:
    add dl, '0'
    mov [count], dl
    
    mov rax, 1
    mov rdi, 1
    mov rsi, count
    mov rdx, 1
    syscall
    
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
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
    newline db 10
    error_msg db '0', 10
