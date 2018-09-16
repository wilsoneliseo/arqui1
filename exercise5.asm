	;&============================================================
	;autor:
	;    Wilson S. Tubín
	;    wilsoneliseogt@gmail.com
	;fuente:
	;    clase arquitectura de computadoras 1 Ing. Otto
	;descripcion:
	;    Suponga que AX posee un numero binario, escriba un
	;    programa que multiplique por 15. Utilizar registros de 16
	;    bits. El resultado guardarlo en DX:AX
	;.============================================================	
			
%include "asm_io.inc"

	; initialized data is put in the .data segment
segment .data

	; uninitialized data is put in the .bss segment
segment .bss

	
	; code is put in the .text segment
segment .text
global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

	;ini-myCode------------------------------

	mov ax, 15000		;outcome-> dx=0003  ax=6EE8

	mov bx, ax
	xor dx,dx
	xor cx,cx
.I:
	shl ax,1
	rcl dx,1
	inc cx
	cmp cx,4
	jb .I
	sub ax,bx
	sbb dx,00h
		
	dump_regs 10
	
	;fin-myCode------------------------------

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


	; Local Variables:
	; mode: nasm
	; End:
