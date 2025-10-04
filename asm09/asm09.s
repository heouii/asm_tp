section .bss
    tampon resb 64

section .text
    global _start

_start:
    mov rax, [rsp]
    cmp rax, 2
    je pas_option
    cmp rax, 3
    je avec_option
    jmp erreur

pas_option:
    mov rsi, [rsp+16]
    call lire_nombre
    mov rdi, rax
    mov rbx, 16
    call afficher_base
    jmp fin_ok

avec_option:
    mov rsi, [rsp+16]
    mov al, [rsi]
    cmp al, '-'
    jne erreur
    mov al, [rsi+1]
    cmp al, 'b'
    jne erreur

    mov rsi, [rsp+24]
    call lire_nombre
    mov rdi, rax
    mov rbx, 2
    call afficher_base
    jmp fin_ok

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

afficher_base:
    mov rax, rdi
    mov rsi, tampon
    add rsi, 63
    mov byte [rsi], 10
    dec rsi
.convert_loop:
    xor rdx, rdx
    div rbx
    cmp dl, 9
    jle .digit
    add dl, 55
    jmp .store
.digit:
    add dl, '0'
.store:
    mov [rsi], dl
    dec rsi
    test rax, rax
    jnz .convert_loop
    inc rsi
    mov rax, 1
    mov rdi, 1
    mov rdx, tampon + 64
    sub rdx, rsi
    syscall
    ret

fin_ok:
    mov rax, 60
    xor rdi, rdi
    syscall

erreur:
    mov rax, 60
    mov rdi, 2
    syscall
