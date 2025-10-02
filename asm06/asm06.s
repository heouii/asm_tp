section .bss
    tampon resb 20
    tampon2 resb 20

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
    xor r8, r8          
    
    
    mov al, [rsi]
    cmp al, '-'
    jne lire1
    mov r8, 1           
    inc rcx             
    
lire1:
    mov al, [rsi+rcx]
    cmp al, 0
    je fin_lire1
    sub al, '0'
    imul rbx, rbx, 10
    add rbx, rax
    inc rcx
    jmp lire1

fin_lire1:
    
    test r8, r8
    jz lire2
    neg rbx

lire2:
    xor rdx, rdx
    xor rcx, rcx
    xor r9, r9          
    
    
    mov al, [rdi]
    cmp al, '-'
    jne lire3
    mov r9, 1
    inc rcx
    
lire3:
    mov al, [rdi+rcx]
    cmp al, 0
    je fin_lire3
    sub al, '0'
    imul rdx, rdx, 10
    add rdx, rax
    inc rcx
    jmp lire3

fin_lire3:
   
    test r9, r9
    jz ajoute
    neg rdx

ajoute:
    add rbx, rdx

   
    mov rax, rbx
    xor r10, r10      
    test rax, rax
    jns positif
    neg rax
    mov r10, 1

positif:
    mov rsi, tampon
    xor rcx, rcx
    test rax, rax
    jnz boucle_chiffre
    mov byte [rsi], '0'
    inc rsi
    mov rcx, 1
    jmp fini_chiffre
    
boucle_chiffre:
    mov rdx, 0
    mov rdi, 10
    div rdi
    add dl, '0'
    mov [rsi], dl
    inc rsi
    inc rcx
    test rax, rax
    jnz boucle_chiffre
    
fini_chiffre:
    
    test r10, r10
    jz pas_de_signe
    mov byte [rsi], '-'
    inc rsi
    inc rcx
    
pas_de_signe:
    mov rsi, tampon
    mov rdi, tampon2
    mov rbx, rcx
    xor rdx, rdx
    
boucle_inv:
    cmp rbx, 0
    je affiche
    dec rbx
    mov al, [rsi+rbx]
    mov [rdi+rdx], al
    inc rdx
    jmp boucle_inv

affiche:
    mov rax, 1
    mov rdi, 1
    mov rsi, tampon2
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

errer:
    mov rax, 60
    mov rdi, 1
    syscall