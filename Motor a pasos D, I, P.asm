; ===============================
; Control de motor paso a paso
; con lectura continua del teclado
; EMU8086
; Puerto virtual del motor: 7
; ===============================    

#start=stepper_motor.exe#

name "stepper"
#make_bin#

steps_before_direction_change = 20h ; 32 pasos

; ===========================================
; Datos: patrones de activación de bobinas
; ===========================================

; Half-step clockwise
datcw    db 00000110b
         db 00000100b    
         db 00000011b
         db 00000010b

; Half-step counter-clockwise
datccw   db 00000011b
         db 00000001b    
         db 00000110b
         db 00000010b

; Full-step clockwise
datcw_fs db 00000001b
         db 00000011b    
         db 00000110b
         db 00000000b

; Full-step counter-clockwise
datccw_fs db 00000100b
          db 00000110b    
          db 00000011b
          db 00000000b

; ===========================================
; Inicio del programa
; ===========================================

start:
    mov bx, offset datcw   ; iniciar con half-step CW
    mov si, 0              ; índice dentro del bloque
    mov cx, 0              ; contador de pasos

main_loop:

    ; ==========================
    ; 1. Leer teclado sin bloquear
    ; ==========================
    mov ah, 01h            ; función: verificar si hay tecla
    int 16h
    jz motor_ready         ; si no hay tecla, continuar con motor
    mov ah, 00h            ; función: leer tecla
    int 16h
    cmp al, 's'            ; si presiona 's', salir
    je fin  
    cmp al, 'a'
    je izquierda
    cmp al, 'd'
    je derecha

motor_ready:
    ; ==========================
    ; 2. Esperar motor listo (bit 7 = 1)
    ; ==========================
wait:
    in al, 7
    test al, 10000000b
    jz wait

    ; ==========================
    ; 3. Enviar siguiente paso al motor
    ; ==========================
    mov al, [bx][si]
    out 7, al
    inc si
    cmp si, 4
    jb next_step
    mov si, 0

    ; ==========================
    ; 4. Contar pasos y cambiar dirección si es necesario
    ; ==========================
    inc cx
    cmp cx, steps_before_direction_change
    jb next_step

    mov cx, 0
    add bx, 4              ; siguiente bloque de datos
    cmp bx, offset datccw_fs
    jbe next_step
    mov bx, offset datcw   ; volver al inicio CW

next_step:
    jmp main_loop          ; repetir ciclo 
    
izquierda:
     mov bx, offset datccw
jmp motor_ready
derecha:   
    mov bx, offset datcw
jmp motor_ready

fin:
    ; ==========================
    ; Salida segura del programa
    ; ==========================
    mov ah, 4Ch
    int 21h                ; terminar programa
