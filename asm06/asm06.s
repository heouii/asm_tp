section .bss
    tampon resb 20

section .text
    global _start

_start:
    mov rax, [rsp]
    cmp rax, 3
    jne errer

    mov rsi, [rsp+16]
    mov rdi, [rsp+24]

    xor rbx, rbx
    xor rcx, rcx
lire1:
    mov al, [rsi+rcx]
    cmp al, 0
    je lire2
    sub al, '0'
    imul rbx, rbx, 10
    add rbx, rax
    inc rcx
    jmp lire1

lire2:
    xor rdx, rdx
    xor rcx, rcx
lire3:
    mov al, [rdi+rcx]
    cmp al, 0
    je ajoute
    sub al, '0'
    imul rdx, rdx, 10
    add rdx, rax
    inc rcx
    jmp lire3

ajoute:
    add rbx, rdx

    mov rsi, tampon
    mov rax, rbx
    xor rcx, rcx
    test rax, rax
    jnz boucle_chiffre
    mov byte [rsi], '0'
    inc rsi
    jmp fini_chiffre
boucle_chiffre:
    mov rdx, 0
    mov rbx, 10
    div rbx
    add dl, '0'
    mov [rsi], dl
    inc rsi
    inc rcx
    test rax, rax
    jnz boucle_chiffre
fini_chiffre:
    mov rbx, rcx
    mov rdi, tampon
    add rdi, rcx
    dec rdi
    mov rsi, tampon
    mov rcx, rbx
boucle_inv:
    cmp rcx, 0
    je affiche
    mov al, [rsi]
    mov [rdi], al
    inc rsi
    dec rdi
    dec rcx
    jmp boucle_inv

affiche:
    mov rax, 1
    mov rdi, 1
    mov rsi, tampon
    mov rdx, rbx
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

errer:
    mov rax, 60
    mov rdi, 1
    syscall