; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h    

inicio:

call rutina  ; 7 clck por cada
call rutina  ; 7 * 3 = 21
call rutina  ; 2 bits por cada una 2 * 3 = 6
jmp fin

rutina:
    mov al, 1 ;|2 ciclos de reloj por cada mov 2*10  =20 bytes
    mov al, 2 ;|cada mov son 2 bytes 
    mov al, 3 ;| 
    mov al, 4
    mov al, 5 
    mov al, 6
    mov al, 7
    mov al, 8
    mov al, 9
    mov al, 10
    
    ret       ;| 10 clck 

fin:

ret


;     6 + 20 bytes = 26