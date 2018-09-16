	;&============================================================
	;autor:
	;    Wilson S. Tubín
	;    wilsoneliseogt@gmail.com
	;fuente:
	;    clase arquitectura de computadoras 1 Ing. Otto
	;descripcion:
	;    Diseñe un programa a bajo nivel con CPU Intel que teniendo
	;    datos tamaño byte pre-almacenados de la posicion `mere` a
	;    `mere+8Fh`, nos indique cuantos de estos son divisibles
	;    exactos o enteros por dos; dejar el numero de hallazgos
	;    en el registro AL.
	;    
	;             |<----8 bits---->|
	;            
	;             +----------------+            
	;    mere     |        52      |
	;    	      +----------------+
	;    mere+1   |        1       |
	;    	      +----------------+
	;    mere+2   |        1       |
	;    	      +----------------+
	;    mere+3   |        1       |
	;    	      +----------------+
	;    ...      |       ...      |
	;    	      +----------------+
	;    mere+8fh |        1       |
	;             +----------------+
	;.============================================================	
			
%include "asm_io.inc"

	; initialized data is put in the .data segment
segment .data
	mere times 8fh db 1	;MEmory REgion

	; uninitialized data is put in the .bss segment
segment .bss

	
	; code is put in the .text segment
segment .text
global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

	;ini-myCode------------------------------
	mov [mere],byte 01011101b		;adding value on purpose
	mov [mere+9],byte 11010000b		;adding value on purpose
	mov [mere+50],byte 01010110b		;adding value on purpose
	mov [mere+60],byte 01000100b		;adding value on purpose	
	mov [mere+70],byte 01011100b		;adding value on purpose

	mov ebx,mere		;index
	mov cx,0000h

.init:
	mov ah,[ebx]
	test ah,00000001b
	jnz .odd
	inc cx
.odd:
	inc ebx
	cmp ebx, mere+8fh
	jb .init
	mov al,cl
	
        ; dump_mem 1, mere, 1    ; dump out memorY
	dump_regs 1
	
	;fin-myCode------------------------------

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


	; Local Variables:
	; mode: nasm
	; End:
