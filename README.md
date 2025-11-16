Este repositorio cuenta con codigos realizados en lenguaje ensamblador utilizando EMU8086.
Este emulador cuenta con diferentes herraminetas e interfaces.

[numero h] -> hace referencia a una dirección de memoria
Memonicos:
  MOV: Mueve datos entre direcciones, directorio->directorio, directorio->memoria, memoria->directorio, memoria->memoria
       su sintaxis es mov direccion a guardar, dato a guardar o direccion a tomar dato.
       mov ax, 1     mov [200h], 3      mov bl, [206h]
Etiquetas:
  Las etiquetas nos ayudan a hacer "bloques de codigo" que se pueden llamar de diferentes formas.
  Los puedes crear mediante un nombre segido por dos puntos ejm. ETIQUETA: (No importa si la creas con mayusculas o minusculas, 
  etiqueta:, es sensible a mayusculas o minuscolas).
  Estas etiquetas creadas las puedes observar durante la ejecucuion la ruta view->simbole table

  <img width="591" height="407" alt="image" src="https://github.com/user-attachments/assets/27ccd13a-b8a0-4b85-a393-48a19d2397f9" />

  <img width="1231" height="396" alt="image" src="https://github.com/user-attachments/assets/0bb995ce-7e46-4294-b4e9-70ec41ccba8f" />
