```make``` muestra el siguiente menú:
```
SISTEMA DE TAREAS
=================

[PRINCIPAL]
-----------------------------------
  help                 Muestra la ayuda agrupada por secciones limpias

[GENERAL]
-----------------------------------
  cal                  Mostrar calendario
  cal--all             Calendario con indicación de día
  clean                Clean
  hello                Hello World!
  help-general         Muestra este menú de ayuda
  hey                  Outputs "hey", since this is the target name
  toml--hello          Hola Mundo. TOML
  user--whoami         whoami

[LEARN]
-----------------------------------
  awk--hello-world     make awk--hello-world
  help-learn           Muestra este menú de ayuda
  memo                 make memo -- Muestra procesos en memoria
  saludo               make saludo nombre=Pepito

```

La sección principal corresponde al archivo Makefile que está en la raiz.
Podemos añadir archivos .mk dentro de la carpeta make/ y esto hará que se muestre una sección para cada archivo.

- Makefile
- make/general.mk
- make/learn.mk

Es una forma de estructurar las tareas a realizar con make.
