; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h  
inicio:        

M1 MACRO
    mov al, 1  ;|   2 * 10 = 20 bytes
    mov al, 2  ;|cada mov son dos bytes   
                ;longitud de macro 20 bytes
    mov al, 3  ;| 
    mov al, 4
    mov al, 5 
    mov al, 6
    mov al, 7
    mov al, 8
    mov al, 9
    mov al, 10
ENDM

start:
    M1  ;|
    M1  ;| 3 llamadas * 20 bytes cada una son 60 bytes
    M1  ;|  
fin:          

ret           



