section .bss
    tampon resb 20

section .text
    global _start

_start:
    mov rax, [rsp]          ; argc
    cmp rax, 2
    jne erreur              ; si pas exactement 1 argument utilisateur

    mov rsi, [rsp+16]       ; argv[1] = adresse de la chaîne saisie
    call lire_nombre
    mov rbx, rax            ; sauvegarde du nombre dans rbx

    call est_premier
    mov r15, rax            ; résultat du test (1 = premier, 0 = non-premier)
    mov rdi, rax

    call afficher_resultat
    
    ; exit code inversé (prime → 0, non-prime → 1)
    mov rdi, r15
    xor rdi, 1
    mov rax, 60
    syscall

; -------------------
; Convertit argv[1] en entier
; -------------------
lire_nombre:
    xor rax, rax       ; résultat = 0
    xor rcx, rcx       ; index = 0
.boucle:
    mov bl, [rsi+rcx]  ; lire caractère
    cmp bl, 0
    je .fin
    cmp bl, 10         ; si retour à la ligne
    je .fin
    cmp bl, '0'
    jb erreur          ; caractère non valide
    cmp bl, '9'
    ja erreur          ; caractère non valide

    sub bl, '0'        ; convertir en chiffre
    imul rax, rax, 10  ; résultat *= 10
    movzx rdx, bl      ; rdx = chiffre
    add rax, rdx       ; résultat += chiffre

    inc rcx
    jmp .boucle
.fin:
    ret

; -------------------
; Test si rbx est premier
; -------------------
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
    mov rax, 1      ; 1 = premier
    ret
.pas_premier:
    mov rax, 0      ; 0 = non premier
    ret

; -------------------
; Affiche le résultat (0 ou 1)
; -------------------
afficher_resultat:
    add rdi, '0'
    mov [tampon], dil
    
    mov rax, 1
    mov rdi, 1
    mov rsi, tampon
    mov rdx, 1
    syscall
    
    sub rdi, '0'    ; restaurer valeur numérique
    ret

; -------------------
; Sortie erreur
; -------------------
erreur:
    mov rax, 60
    mov rdi, 2
    syscall
