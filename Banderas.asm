;Garcia Lopez Jose Miguel

org 100h   
mov al, 1        
          
;bloque 1 rotabit
ROTABIT:
rol al, 1        
jno ROTABIT  

mov [201h], al  
              
;bloque 2 bantera de carreo, recorrer a la derecha
mov ah, [202h]

ror ah, 1
jc IMPAR_C       
jnc FIN_C        

IMPAR_C:   
mov al, [202h]
mov [203h], al 
jmp FIN_C        

FIN_C:

;bloque 3 bandera zero

mov ah, [202h]
test ah, 1 
jz  FIN_T
jnz IMPAR_T 

IMPAR_T:   
mov al, [202h]
mov [203h], al 
jmp FIN_T 

FIN_T:



ret
