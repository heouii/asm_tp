section .data
    num db '1337',0xA

section .bss
    buffer resb 10        

section .text
    global _start

_start:
    mov rax, 0            
    mov rdi, 0           
    mov rsi, buffer       
    mov rdx, 10           
    syscall

    
    mov rsi, buffer
    xor rax, rax          
    xor rcx, rcx          

convert_loop:
    mov bl, [rsi + rcx]
    cmp bl, 0xA           
    je compare
    cmp bl, 0             
    je compare
    sub bl, '0'           
    imul rax, rax, 10
    add rax, rbx
    inc rcx
    jmp convert_loop

compare:
    cmp rax, 42
    je egal

    ; quitter si pas égal
    mov rax, 60
    mov rdi, 0
    syscall

egal:
    mov rax, 1       
    mov rdi, 1
    mov rsi, num    
    mov rdx, 5           
    syscall          

    mov rax, 60
    mov rdi, 0
    syscall