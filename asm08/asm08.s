section .bss
    tampon resb 32

section .text
    global _start

_start:
    mov rax, [rsp]          
    cmp rax, 2
    jne erreur             

    mov rsi, [rsp+16]       
    call lire_nombre
    mov rbx, rax            

    cmp rbx, 1
    jle erreur              

    call somme_inferieure

    
    mov rdi, rax
    call afficher_nombre

   
    mov rax, 60
    xor rdi, rdi
    syscall


lire_nombre:
    xor rax, rax
    xor rcx, rcx
.boucle:
    mov bl, [rsi+rcx]
    cmp bl, 0
    je .fin
    cmp bl, 10
    je .fin
    cmp bl, '0'
    jb erreur
    cmp bl, '9'
    ja erreur

    sub bl, '0'
    imul rax, rax, 10
    movzx rdx, bl
    add rax, rdx
    inc rcx
    jmp .boucle
.fin:
    ret


somme_inferieure:
    mov rcx, 1         
    xor rax, rax         
.boucle:
    cmp rcx, rbx
    jge .fin
    add rax, rcx
    inc rcx
    jmp .boucle
.fin:
    ret


afficher_nombre:
    mov rax, rdi
    mov rbx, 10
    mov rsi, tampon
    add rsi, 31         
    mov byte [rsi], 10   
    dec rsi

.convert_loop:
    xor rdx, rdx
    div rbx
    add dl, '0'
    mov [rsi], dl
    dec rsi
    test rax, rax
    jnz .convert_loop

    inc rsi
    mov rax, 1
    mov rdi, 1
    mov rdx, tampon + 32
    sub rdx, rsi
    syscall
    ret


erreur:
    mov rax, 60
    mov rdi, 2
    syscall
