	;&============================================================
	;autor:
	;    Wilson S. Tubín
	;    wilsoneliseogt@gmail.com
	;fuente:
	;    clase arquitectura de computadoras 1 Ing. Otto
	;descripcion:
	;    Diseñar un programa a bajo nivel que teniendo almacenados
	;    previamente en la posición `mere` a `mere+0x8e` sea capaz
	;    de encontrar cuantos de estos bytes están en el rango 50
	;    a 55; dejar en el registro AL el número de hallazgos.
	;    
	;             |<----8 bits---->|
	;            
	;             +----------------+            
	;    mere     |        52      |
	;    	      +----------------+
	;    mere+1   |        0       |
	;    	      +----------------+
	;    mere+2   |        0       |
	;    	      +----------------+            
	;    mere+3   |        0       |
	;    	      +----------------+
	;    ...      |       ...      |
	;    	      +----------------+
	;    mere+8eh |        0       |
	;             +----------------+
	;.============================================================	
	
%include "asm_io.inc"

	; initialized data is put in the .data segment
segment .data
	mere times 8fh db 0	;MEmory REgion

	; uninitialized data is put in the .bss segment
segment .bss

	
	; code is put in the .text segment
segment .text
global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

	;ini-myCode------------------------------
	mov [mere],byte 52		;adding value on purpose
	mov [mere+9],byte 53		;adding value on purpose
	mov [mere+50],byte 50		;adding value on purpose

	mov esi,mere		;index
	xor dl,dl

.init:
	mov al,[esi]
	cmp al,50
	jb .outOfRange

	cmp al,55
	ja .outOfRange
	inc dl
.outOfRange:
	inc esi
	cmp esi, mere+8eh
	jne .init
	mov al,dl
	
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
