org 100h 
SUMA_RESTA 
call INGRESO_OPC 
cmp ch, 31h
je SUMA
cmp ch, 32h 
je RESTA 
cmp ch, 33h 
je MULTIPLICAR
cmp ch, 34h 
je DIVIDIR

jmp finPrograma 

INGRESO_OPC: 
    mov ah, 01h
    int 21h
    mov ch, al
ret

macro SUMA_RESTA
    mov ah, 02h 
    mov dl, "1"
    int 21h
    mov dl, " "
    int 21h
    mov dl, "S"
    int 21h
    mov dl, "U"
    int 21h   
    mov dl, "M"
    int 21h
    mov dl, "A"
    int 21h
    mov dl, " "
    int 21h
    mov dl, "2"
    int 21h
    mov dl, " "
    int 21h
    mov dl, "R"
    int 21h
    mov dl, "E"
    int 21h
    mov dl, "S"
    int 21h
    mov dl, "T"
    int 21h
    mov dl, "A"
    int 21h   
    mov dl, " "
    int 21h
    mov dl, "3"
    int 21h 
    mov dl, " "
    int 21h
    mov dl, "M"
    int 21h 
    mov dl, "U"
    int 21h
    mov dl, "L"
    int 21h 
    mov dl, "T"
    int 21h
    mov dl, "I"
    int 21h 
    mov dl, "P"
    int 21h
    mov dl, "L"
    int 21h  
    mov dl, "I"
    int 21h
    mov dl, "C"
    int 21h 
    mov dl, "A"
    int 21h   
    mov dl, "R"
    int 21h 
    mov dl, " "
    int 21h
    mov dl, "4"
    int 21h 
    mov dl, " "
    int 21h
    mov dl, "D"
    int 21h 
    mov dl, "I"
    int 21h
    mov dl, "V"
    int 21h 
    mov dl, "I"
    int 21h
    mov dl, "D"
    int 21h 
    mov dl, "I"
    int 21h
    mov dl, "R"
    int 21h 
    mov dl, " "
    int 21h
    mov dl, ":"
    int 21h 
    mov dl, " "
    int 21h
endm

macro PEDIR_NUMERO
    mov ah, 02h
    mov dl, " "
    int 21h           
    mov dl, "I"
    int 21h           
    mov dl, "N"
    int 21h          
    mov dl, "G"
    int 21h          
    mov dl, "R"
    int 21h           
    mov dl, "E"
    int 21h           
    mov dl, "S"
    int 21h           
    mov dl, "E"
    int 21h           
    mov dl, " "
    int 21h           
    mov dl, "N"
    int 21h           
    mov dl, "U"
    int 21h           
    mov dl, "M"
    int 21h           
    mov dl, "E"
    int 21h           
    mov dl, "R"
    int 21h          
    mov dl, "O"
    int 21h          
    mov dl, " "
    int 21h          
    mov dl, ":"
    int 21h           
    mov dl, " "
    int 21h
endm   

macro MOSTRAR_RESULTADO
      
    mov ah, 02h
    mov dl, " "
    int 21h           
    mov dl, "R"
    int 21h 
    mov dl, "E"
    int 21h 
    mov dl, "S"
    int 21h 
    mov dl, "U"
    int 21h
    mov dl, "L"
    int 21h
    mov dl, "T"
    int 21h
    mov dl, "A"
    int 21h
    mov dl, "D"
    int 21h 
    mov dl, "O"
    int 21h  
    mov dl, " "
    int 21h 
    mov dl, ":"
    int 21h
    mov dl, " "
    int 21h   
               
endm    

                 
INGRESO_N:  
    mov ah, 01h 
    int 21h
ret  


SUMA:   
       
    mov bl, 10   
    ;PRIMER PAR DE NUMEROS 
    PEDIR_NUMERO
    call INGRESO_N 
    sub al, 30h 
    mul bl
    
    add bh, al
    
    call INGRESO_N 
    sub al, 30h
    add bh, al 
    
    ;SEGUNDO PAR DE NUMEROS
    PEDIR_NUMERO
    call INGRESO_N 
    sub al, 30h  
    mul bl
    add bh, al
    
    call INGRESO_N 
    sub al, 30h
    add bh, al  
    
    ;guardar en memoria decimal
    mov ah, 0
    mov al, 0
    mov al, bh
    div bl
    mov [13h], ah
    mov ah, 0 
    div bl
    mov [12h], ah
    mov ah, 0
    div bl
    mov [11h], ah
    mov ah, 0 
    
    MOSTRAR_RESULTADO 
    mov ah, 02h
    mov dl, [11h]
    add dl, 30h
    int 21h
    mov dl, 0
    mov dl, [12h]
    add dl, 30h
    int 21h
    mov dl, 0
    mov dl, [13h]
    add dl, 30h
    int 21h    
ret        

RESTA:    
    mov bl, 10   
    ;PRIMER PAR DE NUMEROS 
    PEDIR_NUMERO
    call INGRESO_N 
    sub al, 30h 
    mul bl
    
    add bh, al
    
    call INGRESO_N 
    sub al, 30h
    add bh, al
    
    mov [21h], bh 
    
    ;SEGUNDO PAR DE NUMEROS 
    mov bh, 0
    PEDIR_NUMERO
    call INGRESO_N 
    sub al, 30h 
    mul bl
    
    add bh, al
    
    call INGRESO_N 
    sub al, 30h
    add bh, al
    
    mov [22h], bh
    
    ;///////////////////////////////////
    
    mov al, 0
    mov ah, 0
    
    mov al, [21h]
    mov bl, [22h]
    RESTA_CONT:
    sub al, bl
    js NEGATIVO  
    
    ;guardar en memoria decimal
    mov ah, 0 
    mov bl, 10
    div bl
    mov [13h], ah
    mov ah, 0 
    div bl
    mov [12h], ah
    mov ah, 0
    div bl
    mov [11h], ah
    mov ah, 0 
    
    MOSTRAR_RESULTADO 
    mov ah, 02h  
    mov dl, [10h]
    int 21h
    mov dl, [11h]
    add dl, 30h
    int 21h
    mov dl, 0
    mov dl, [12h]
    add dl, 30h
    int 21h
    mov dl, 0
    mov dl, [13h]
    add dl, 30h
    int 21h 
    mov [10h], 0    
ret 

NEGATIVO:
    mov [10h], 45
    mov al, [22h]
    mov bl, [21h]
jmp RESTA_CONT 

MULTIPLICAR:
   PEDIR_NUMERO 
   mov [5h], 10
   
   call INGRESO_N           
   sub al, 30h
   mov [14h], al  
   call INGRESO_N           
   sub al, 30h
   mov [15h], al
   
   PEDIR_NUMERO
   
   call INGRESO_N           
   sub al, 30h
   mov [24h], al  
   call INGRESO_N           
   sub al, 30h
   mov [25h], al  
   
   ;multiplicacion
   
   mov al, [15h]
   mov bl, [25h] 
   mul bl 
   div [5h]  
   mov [45h], ah
   mov [4h], al 
   
   mov al, [14h]
   mov bl, [25h] 
   mul bl 
   add al, [4h]    
   div [5h] 
   mov [44h], ah
   mov [43h], al
   
   mov [4h], 0
   
   mov al, [15h]
   mov bl, [24h] 
   mul bl 
   div [5h]  
   mov [54h], ah
   mov [4h], al
   
   mov al, [14h]
   mov bl, [24h] 
   mul bl 
   add al, [4h]    
   div [5h] 
   mov [53h], ah
   mov [52h], al
   
   mov bh, [45h]
   mov [65h], bh
                 
   mov bh, 0
   mov bl, 10
   mov ah, 0
   add bh, [44h]
   add bh, [54h]
   mov al, bh
   div bl
   mov [64h], ah
   mov [33h], al  
   
   mov ah, 0 
   mov al, 0
   mov bh, 0
   add bh, [33h]
   add bh, [43h]
   add bh, [53h]
   mov al, bh
   mov ah, 0
   div bl
   mov [63h], ah
   mov [32h], al   
   
   mov ah, 0 
   mov al, 0
   mov bh, 0
   add bh, [52h]
   add bh, [32h]
   mov al, bh
   div bl
   mov [62h], ah
   mov [61h], al  
   
   MOSTRAR_RESULTADO
    
   mov ah, 02h
   mov dl, [62h]
   add dl, 30h 
   int 21h
   
   mov dl, [63h]
   add dl, 30h 
   int 21h
   
   mov dl, [64h]
   add dl, 30h 
   int 21h
   
   mov dl, [65h]
   add dl, 30h 
   int 21h
ret  

DIVIDIR:  
    mov bl, 10
    ;PRIMER PAR DE NUMEROS 
    PEDIR_NUMERO
    call INGRESO_N 
    sub al, 30h
    mul bl
    mov bh, al
    
    call INGRESO_N 
    sub al, 30h
    add bh, al 
    cmp bh, 0
    je finPrograma 
    mov [4h], bh 
    
    PEDIR_NUMERO
    call INGRESO_N
    sub al, 30h
    mul bl
    mov bh, al
    
    call INGRESO_N
    sub al, 30h
    add bh, al
    mov bl, bh
    cmp bl, 0
    je finPrograma 
    
    
    
    mov ah, 0 
    
    mov al, [4h]
    div bl
    
    mov [3h], al
    
    cmp ah, 0
    jne DECIMALES
    CONTINUA:
    
    mov al, [3h]
    mov bl, 10 
    mov ah, 0
    div bl
    mov [12h], al
    mov [13h], ah 
    
    MOSTRAR_RESULTADO 
    
    mov [14h], 46
    
    mov ah, 02h 
    mov dl, [12h]
    add dl, 30h
    int 21h
    mov dl, [13h]
    add dl, 30h
    int 21h
    mov dl, [14h] 
    int 21h
    mov dl, [15h] 
    add dl, 30h
    int 21h 
    
ret    

DECIMALES:
    mov al, ah
    mov ah, 0
    mov bh, 10
    mul bh 
    div bl
    mov [15h], al 
    jmp CONTINUA
ret

finPrograma:


END