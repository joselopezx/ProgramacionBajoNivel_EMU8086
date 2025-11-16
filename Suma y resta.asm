; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
 
;BLOQUE 1  
mov al, 100
mov al, 100b
mov al, 100o   
                
;BLOQUE 2
mov [200h], 2
mov [201h], 1
mov ah, [200h]
add ah, [201h]

;BLOQUE 3
mov ah, [200h]
sub ah, [201h]
JS ES_NEGATIVO
    mov al, ah
    JMP FIN_RES
ES_NEGATIVO:
    mov bl, ah
FIN_RES:

;BLOQUE 4            
mov [202h], 2        
mov ch, [202h]       
test ch, 1           
jz par               
jmp impar            

par:
    mov [203h], ch 
    mov cl, ch      
    jmp fin 

impar:
    mov [204h], ch
    mov dl, ch         


fin:    

ret

