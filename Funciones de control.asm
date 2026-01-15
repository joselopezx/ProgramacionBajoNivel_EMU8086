; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; funciones de control JNC, JE, CALL, JMP
; Bloque 1
mov ax, 1  

rotar:
    rol ax, 1                   
    jnc rotar 
    ;jmp rotar      

; Bloque 2
mov bh, 1

incrementar:
    inc bh
    cmp bh, 0FFh
    je decrementar
    call incrementar
   
decrementar: 
    dec bh
    cmp bh, 1
    je incrementar
    jmp decrementar



ret