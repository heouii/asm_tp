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

    mov rcx, tampon
    mov rsi, rbx
    mov rdx, 0
retourne:
    mov rax, rsi
    xor rdx, rdx
    mov rdi, 10
    div rdi
    add dl, '0'
    mov [rcx], dl
    inc rcx
    mov rsi, rax
    test rax, rax
    jnz retourne

    mov rbx, rcx
    sub rbx, tampon

    ; inversion correcte
    mov rdi, tampon
    mov rsi, tampon
    add rsi, rbx
    dec rsi
    mov rcx, rbx
boucle_inv:
    cmp rcx, 0
    je affiche
    mov al, [rsi]
    mov [rdi], al
    inc rdi
    dec rsi
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