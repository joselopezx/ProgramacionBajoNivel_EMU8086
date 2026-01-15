org 100h                             ; DIRECTIVA 1: Indica el inicio del sistema en la direccion 100h

inicio: 

tituloMensaje DB 'Directivas$'       ; DIRECTIVA 2: DB almacena una cadena de texto en memoria

datos SEGMENT                        ; DIRECTIVA 3: SEGMENT define el inicio de un segmento de datos
    valorInicial DB 1                ; DIRECTIVA 4: Almacena un numero en un byte              
    ultimoNumero EQU 10              ; DIRECTIVA 5: EQU define un nombre simbolico con valor constante
                                   
datos ENDS                           ; DIRECTIVA 6: ENDS indica el fin del segmento de datos


M1 MACRO                             ; DIRECTIVA 7: Inicio de macro
    LOCAL repetir                    ; DIRECTIVA 8: LOCAL define una etiqueta local dentro de la macro

    mov al, [110h]
repetir:
    inc al
    cmp al, ultimoNumero
    jne repetir

ENDM                                 ; DIRECTIVA 9: Fin de macro  

start:
    M1  
    M1  
    M1   

fin:       
    ret                              ; DIRECTIVA 10: 

END                                  ; DIRECTIVA 11: Indica el fin del codigo fuente