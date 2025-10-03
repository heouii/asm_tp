section .bss
    tampon resb 20

section .text
    global _start

_start:
    mov rax, [rsp]
    cmp rax, 2
    jne erreur

    ; MODIF: Supprimé "pop rax" et "pop rsi" qui décalaient la stack
    mov rsi, [rsp+16]
    call lire_nombre
    mov rbx, rax

    call est_premier
    ; MODIF: Sauvegarder dans r12 (registre préservé)
    mov r12, rax
    mov rdi, rax

    call afficher_resultat
    
    ; MODIF: Récupérer depuis r12 et inverser
    mov rdi, r12
    xor rdi, 1
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
    ; MODIF: Inversé - retourne 1 pour premier (exit code 0 attendu après inversion)
    mov rax, 1
    ret
.pas_premier:
    ; MODIF: Inversé - retourne 0 pour non-premier (exit code 1 attendu après inversion)
    mov rax, 0
    ret

afficher_resultat:
    add rdi, '0'
    mov [tampon], dil
    
    mov rax, 1
    push rdi
    mov rdi, 1
    mov rsi, tampon
    mov rdx, 1
    syscall
    pop rdi
    ; MODIF: Corriger sub rdi, 0 en sub rdi, '0' pour restaurer la valeur
    sub rdi, '0'
    ret

erreur:
    mov rax, 60
    ; MODIF: Code d'erreur 2 au lieu de 1
    mov rdi, 2
    syscall