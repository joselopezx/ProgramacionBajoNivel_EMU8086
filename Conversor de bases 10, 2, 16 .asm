.model small
.stack 100h

.data
    menu_principal db 13,10,'MENU',13,10
                   db '1. Decimal',13,10
                   db '2. Binario',13,10
                   db '3. Hexadecimal',13,10
                   db 'Seleccione opcion: $'
    
    menu_decimal   db 13,10,'DECIMAL',13,10
                   db '1. Binario',13,10
                   db '2. Hexadecimal',13,10
                   db 'Seleccione opcion: $'
    
    menu_binario   db 13,10,'BINARIO',13,10
                   db '1. Decimal',13,10
                   db '2. Hexadecimal',13,10
                   db 'Seleccione opcion: $'
    
    menu_hexa      db 13,10,'HEXADECIMAL',13,10
                   db '1. Decimal',13,10
                   db '2. Binario',13,10
                   db 'Seleccione opcion: $'
    
    input_decimal  db 13,10,10,'Ingrese numero decimal (0-99): $'
    input_binario  db 13,10,10,'Ingrese numero binario (00000000-11111111): $'
    input_hexa     db 13,10,10,'Ingrese numero hexadecimal (00-FF): $'
    
    decimal_msg    db 13,10,'Numero decimal: $'
    hex_msg        db 13,10,'Numero hexadecimal: $'
    bin_msg        db 13,10,'Numero binario: $'
    error_msg      db 13,10,'Error: Entrada invalida!$'
    newline        db 13,10,'$'
    
    number         db 0

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 09h
    mov dx, offset menu_principal
    int 21h
    
    mov ah, 01h
    int 21h
    
    cmp al, '1'
    je opcion_decimal
    cmp al, '2'
    je opcion_binario
    cmp al, '3'
    je opcion_hexadecimal
    
    jmp error_y_salir

opcion_decimal:
    call menu_conversion_decimal
    jmp salir

opcion_binario:
    call menu_conversion_binario
    jmp salir

opcion_hexadecimal:
    call menu_conversion_hexa
    jmp salir

error_y_salir:
    mov ah, 09h
    mov dx, offset error_msg
    int 21h

salir:
    mov ah, 09h
    mov dx, offset newline
    int 21h
    mov ah, 4Ch
    int 21h
main endp

; MENU DECIMAL
menu_conversion_decimal proc
    mov ah, 09h
    mov dx, offset menu_decimal
    int 21h
    
    mov ah, 01h
    int 21h
    
    cmp al, '1'
    je decimal_a_binario
    cmp al, '2'
    je decimal_a_hexa
    
    jmp error_y_salir

decimal_a_binario:
    call leer_decimal
    jc error_y_salir  
    call mostrar_binario
    ret

decimal_a_hexa:
    call leer_decimal
    jc error_y_salir  
    call mostrar_hexadecimal
    ret
menu_conversion_decimal endp

;MENU BINARIO
menu_conversion_binario proc
   
    mov ah, 09h
    mov dx, offset menu_binario
    int 21h
    
    mov ah, 01h
    int 21h
    
    cmp al, '1'
    je binario_a_decimal
    cmp al, '2'
    je binario_a_hexa
    
    
    jmp error_y_salir

binario_a_decimal:
    call leer_binario
    jc error_y_salir  
    call mostrar_decimal
    ret

binario_a_hexa:
    call leer_binario
    jc error_y_salir  
    call mostrar_hexadecimal
    ret
menu_conversion_binario endp

; MENU HEXADECIMAL
menu_conversion_hexa proc
    
    mov ah, 09h
    mov dx, offset menu_hexa
    int 21h
    
    mov ah, 01h
    int 21h
    
    cmp al, '1'
    je hexa_a_decimal
    cmp al, '2'
    je hexa_a_binario
    
    jmp error_y_salir

hexa_a_decimal:
    call leer_hexadecimal
    jc error_y_salir  
    call mostrar_decimal
    ret

hexa_a_binario:
    call leer_hexadecimal
    jc error_y_salir  
    call mostrar_binario
    ret
menu_conversion_hexa endp

; LECTURA DE NUMEROS

leer_decimal proc
    mov ah, 09h
    mov dx, offset input_decimal
    int 21h
    
    
    mov ah, 01h
    int 21h
    call verificar_digito
    jc error_lectura
    sub al, '0'
    mov bl, al
    
    mov ah, 01h
    int 21h
    call verificar_digito
    jc error_lectura
    sub al, '0'
    mov bh, al
    
    mov al, bl
    mov cl, 10
    mul cl
    add al, bh
    mov [number], al
    
    clc
    ret

error_lectura:
    stc
    ret
leer_decimal endp

leer_binario proc
    mov ah, 09h
    mov dx, offset input_binario
    int 21h
    
    mov bl, 0       
    mov cx, 8       
    
leer_bits:
    
    mov ah, 01h
    int 21h
    
    cmp al, '0'
    je es_cero
    cmp al, '1'
    je es_uno
    jmp error_lectura_bin   

es_cero:
    shl bl, 1       
    jmp continuar

es_uno:
    shl bl, 1       
    or bl, 1        

continuar:
    loop leer_bits
    
    mov [number], bl
    clc
    ret

error_lectura_bin:
    stc
    ret
leer_binario endp


leer_hexadecimal proc
    mov ah, 09h
    mov dx, offset input_hexa
    int 21h
    
    
    mov ah, 01h
    int 21h
    call char_a_hex
    jc error_lectura_hex
    
    mov bl, al
    shl bl, 4
    
    mov ah, 01h
    int 21h
    call char_a_hex
    jc error_lectura_hex
    
    or bl, al
    mov [number], bl
    
    clc
    ret

error_lectura_hex:
    stc
    ret
leer_hexadecimal endp

; CONVERSIONES 

mostrar_decimal proc
    mov ah, 09h
    mov dx, offset decimal_msg
    int 21h
    
    mov al, [number]
    mov ah, 0
    mov bx, 10
    mov cx, 0
    
convertir_decimal:
    mov dx, 0
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne convertir_decimal
    
mostrar_digitos:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop mostrar_digitos
    
    ret
mostrar_decimal endp


mostrar_hexadecimal proc
    mov ah, 09h
    mov dx, offset hex_msg
    int 21h
    
    mov al, [number]
    mov bl, al
    mov cx, 2
    
mostrar_hex:
    rol bl, 4
    mov dl, bl
    and dl, 0Fh
    
    cmp dl, 9
    jbe es_numero_hex
    add dl, 7
es_numero_hex:
    add dl, '0'
    
    mov ah, 02h
    int 21h
    
    loop mostrar_hex
    ret
mostrar_hexadecimal endp

mostrar_binario proc
    mov ah, 09h
    mov dx, offset bin_msg
    int 21h
    
    mov bl, [number]
    mov cx, 8
    
mostrar_bits:
    rol bl, 1
    mov dl, bl
    and dl, 1
    add dl, '0'
    
    mov ah, 02h
    int 21h
    
    mov ax, cx
    dec ax
    cmp ax, 4
    jne sin_espacio
    mov dl, ' '
    mov ah, 02h
    int 21h
sin_espacio:
    loop mostrar_bits
    ret
mostrar_binario endp
 

verificar_digito:
    cmp al, '0'
    jb digito_invalido
    cmp al, '9'
    ja digito_invalido
    clc
    ret
digito_invalido:
    stc
    ret

char_a_hex proc
    cmp al, '0'
    jb error_char
    cmp al, '9'
    jbe es_numero
    
    cmp al, 'A'
    jb error_char
    cmp al, 'F'
    jbe es_mayuscula
    
    cmp al, 'a'
    jb error_char
    cmp al, 'f'
    jbe es_minuscula
    
error_char:
    stc
    ret

es_numero:
    sub al, '0'
    clc
    ret

es_mayuscula:
    sub al, 'A' - 10
    clc
    ret

es_minuscula:
    sub al, 'a' - 10
    clc
    ret
char_a_hex endp

end main