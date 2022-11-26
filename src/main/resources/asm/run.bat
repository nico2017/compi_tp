PATH=C:\TASM;

tasm numbers.asm
tasm final1.asm
tlink final1.obj numbers.obj
final1.exe
del final1.obj
del numbers.obj
del final1.exe
del final1.map