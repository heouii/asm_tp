section .bss
    tampon resb 20

section .text
    global _start

_start:
    mov rax, [rsp]
    cmp rax, 2
    jne erreur

    mov rsi, [rsp+16]
    call lire_nombre
    mov rbx, rax

    call est_premier
    push rax
    mov rdi, rax

    call afficher_resultat
    pop rdi
    mov rax, 60
    syscall

lire_nombre:
    xor rax, rax
    xor rcx, rcx
.boucle:
    mov dl, [rsi+rcx]
    cmp dl, 0
    je .fin
    sub dl, '0'
    imul rax, rax, 10
    add rax, rdx
    inc rcx
    jmp .boucle
.fin:
    ret

est_premier:
    cmp rbx, 2
    jl .pas_premier
    je .est_premier
    
    mov rax, rbx
    xor rdx, rdx
    mov rcx, 2
    div rcx
    cmp rdx, 0
    je .pas_premier

    mov rcx, 3
.boucle:
    mov rax, rcx
    imul rax, rax
    cmp rax, rbx
    jg .est_premier
    
    mov rax, rbx
    xor rdx, rdx
    div rcx
    cmp rdx, 0
    je .pas_premier
    
    add rcx, 2
    jmp .boucle

.est_premier:
    mov rax, 0
    ret
.pas_premier:
    mov rax, 1
    ret

afficher_resultat:
    add rdi, '0'
    mov [tampon], dil

    push rdi

    mov rax, 1
    mov rdi, 1
    mov rsi, tampon
    mov rdx, 1
    syscall

    pop rdi
    ret

erreur:
    mov rax, 60
    mov rdi, 2
    syscall