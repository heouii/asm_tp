section .data
    msg db "1337", 0xA
    len equ $-msg

section .bss
    buffer resb 8

section .text
    global _start

_start:
    ; Lire l'entrée utilisateur
    mov rax, 0          ; syscall read
    mov rdi, 0          ; stdin
    mov rsi, buffer
    mov rdx, 8
    syscall

    ; Vérifier "42" + retour à la ligne
    mov al, [buffer]
    cmp al, '4'
    jne exit_code_1

    mov al, [buffer+1]
    cmp al, '2'
    jne exit_code_1

    mov al, [buffer+2]
    cmp al, 0xA         ; entrée = retour à la ligne
    jne exit_code_1

    ; Afficher "1337"
    mov rax, 1
    mov rdi, 1          ; stdout
    mov rsi, msg
    mov rdx, len
    syscall

    ; Quitter avec code 0
    mov rax, 60
    xor rdi, rdi        ; code de sortie 0
    syscall

exit_code_1:
    mov rax, 60
    mov rdi, 1          ; code de sortie 1
    syscall
