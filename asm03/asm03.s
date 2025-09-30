section .data
    msg db "1337", 0xA
    len equ $-msg

section .text
    global _start

_start:
    
    mov rbx, [rsp]          
    cmp rbx, 2              
    jne exit               

    
    mov rsi, [rsp+16]       

   
    mov al, byte [rsi]
    cmp al, '4'
    jne exit

   
    mov al, byte [rsi+1]
    cmp al, '2'
    jne exit

    
    mov al, byte [rsi+2]
    cmp al, 0
    jne exit

   
    mov rax, 1              
    mov rdi, 1              
    mov rsi, msg
    mov rdx, len
    syscall

exit:
    mov rax, 60            
    xor rdi, rdi
    syscall
