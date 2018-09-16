# Linux makefile. Use with make 
AS	:= nasm
ASFLAGS := -f elf
CFLAGS	:= -Wall
TARGET_ARCH:=-m32
CC	:= gcc
DEP := driver.o asm_io.o

TARGETS := exercise1 exercise2 exercise3 exercise4 exercise5 exercise6

ECHO:=echo
AWK:=awk
RM:=rm -r
PRINTF:=printf

%.o: %.asm
	$(call build-msg,$<)
	$(AS) $(ASFLAGS) $<

.PHONY:%.run
%.run:
	./$(basename $@)

all: $(TARGETS) 

exercise1.run:exercise1
exercise1: $(DEP)		#suma de dos numeros de tres bytes
exercise1.o: asm_io.inc
exercise1.lst: exercise1.asm
	nasm $(ASFLAGS) $< -l $@

exercise2.run:exercise2
exercise2: $(DEP)		#lo mismo que exercise1.asm solo que utilizando un ciclo
exercise2.o: asm_io.inc

exercise3.run:exercise3
exercise3: $(DEP)		#cantidad de numeros que estan en el rango 50 a 55 en una region de memoria
exercise3.o: asm_io.inc

exercise4.run:exercise4
exercise4: $(DEP)		#cantidad de numeros pares en una region de memoria
exercise4.o: asm_io.inc

exercise5.run:exercise5
exercise5: $(DEP)		#multiplicar AX por 15. Utilizando instruccion de rotacion con acarreo (RCL)
exercise5.o: asm_io.inc

exercise6.run:exercise6
exercise6: $(DEP)		#Retardo del scan (exploracion) de una region de memoria buscando bytes
exercise6.o: asm_io.inc		#divisibles por dos y negativos.


asm_io.o: asm_io.asm
	$(AS) $(ASFLAGS) -d ELF_TYPE asm_io.asm

define build-msg
	@$(AWK) 'BEGIN {$(PRINTF) "	;=============================================================\
	\n	;   Ejecute: make $(basename $1).run\n"} /;&=/,/;\.=/' $1
endef

.PHONY: clean
clean :
	$(RM) *.o *~ $(TARGETS)
