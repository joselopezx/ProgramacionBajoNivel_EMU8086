; this short program for emu8086 shows how to keep constant temperature
; using heater and thermometer (between 60° to 80°),
; it is assumed that air temperature is lower 60°.

; thermometer.exe is started automatically from c:\emu8086\devices.
; it is also accessible from the "virtual devices" menu of the emulator.

#start=thermometer.exe#

; temperature rises fast, thus emulator should be set to run at the maximum speed.

; if closed, the thermometer window can be re-opened from emulator's "virtual devices" menu.



#make_bin#

name "thermo"

; set data segment to code segment:
mov ax, cs
mov ds, ax 

mov bh, 0
mov ax, 0
out 199, ax

start:

in al, 125 

cmp al, 75
jae tempAlta
jmp tempBaja 

continua:

mov ah, 01h            
int 16h
jz ok         
mov ah, 00h            
int 16h
cmp al, 'w'            
je high 
cmp al, 's'
je low

tempAlta: 
    mov ax, 1
    out 199, ax
    out 10, ax
jmp continua
tempBaja: 
    mov ax, 0
    out 199, ax
    out 10, ax
jmp continua

low:
mov al, 0
out 127, al   ; turn heater "off". 
jmp ok

high: 
mov al, 1
out 127, al   ; turn heater "on".

ok:
jmp start   ; endless loop.


