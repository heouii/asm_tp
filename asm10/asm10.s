section .data
    msg_err_args db "Erreur: il faut exactement 3 nombres.", 10
    len_err_args equ $ - msg_err_args
    msg_err_num db "Erreur: les arguments doivent etre des entiers positifs.", 10
    len_err_num equ $ - msg_err_num

section .bss
    tmp resb 32

section .text
    global _start

_start:
    mov rax, [rsp]
    cmp rax, 4
    jne erreur_args

    mov rsi, [rsp+16]
    call lire_nombre
    mov rbx, rax

    mov rsi, [rsp+24]
    call lire_nombre
    mov rcx, rax

    mov rsi, [rsp+32]
    call lire_nombre
    mov rdx, rax

    mov rax, rbx
    cmp rcx, rax
    jle .check3
    mov rax, rcx
.check3:
    cmp rdx, rax
    jle .print
    mov rax, rdx
.print:
    mov rdi, rax
    call print_number
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
    jb erreur_num
    cmp bl, '9'
    ja erreur_num
    sub bl, '0'
    imul rax, rax, 10
    add rax, rbx
    inc rcx
    jmp .boucle
.fin:
    ret

print_number:
    mov rsi, tmp
    add rsi, 31
    mov byte [rsi], 10
    dec rsi
    mov rax, rdi
.convert:
    xor rdx, rdx
    mov rbx, 10
    div rbx
    add dl, '0'
    mov [rsi], dl
    dec rsi
    test rax, rax
    jnz .convert
    inc rsi
    mov rax, 1
    mov rdi, 1
    mov rdx, tmp + 32
    sub rdx, rsi
    syscall
    ret

erreur_args:
    mov rax, 1
    mov rdi, 2
    mov rsi, msg_err_args
    mov rdx, len_err_args
    syscall
    mov rax, 60
    mov rdi, 1
    syscall

erreur_num:
    mov rax, 1
    mov rdi, 2
    mov rsi, msg_err_num
    mov rdx, len_err_num
    syscall
    mov rax, 60
    mov rdi, 1
    syscall
