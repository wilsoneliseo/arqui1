	;&============================================================
	;autor:
	;    Wilson S. Tubín
	;    wilsoneliseogt@gmail.com
	;fuente:
	;    clase arquitectura de computadoras 1 Ing. Otto
	;descripcion:
	;    Diseñar un programa a bajo nivel de CPU Intel en
	;    plataforma de 32 bits que sea capaz de ejecutar la suma
	;    de dos números x & y de 3 bytes cada uno, ellos están
	;    alojados en memoria, (como se observa) el resultado
	;    almacenelo tambien en memoria en las posiciones vecinas
	;    consecutivas.
	;
	;             |<----8 bits---->|
	;            
	;             +----------------+            
	;    mere     |       00       | |          
	;    	      +----------------+ |          
	;    mere+1   |       6B       | | x        
	;    	      +----------------+ |          
	;    mere+2   |       F5       | |          
	;    	      +----------------+            
	;    mere+3   |       59       | |          
	;    	      +----------------+ |          
	;    ...      |       00       | | y        
	;    	      +----------------+ |          
	;    	      |       A0       | |          
	;    	      +----------------+            
	;    	      |        ?       | |          
	;    	      +----------------+ |          
	;    	      |        ?       | |          
	;    	      +----------------+ | resultado
	;    	      |        ?       | |          
	;    	      +----------------+ |          
	;    mere+9   |     carry      | |
	;             +----------------+
	;.============================================================
	
	
%include "asm_io.inc"

	; initialized data is put in the .data segment
segment .data
	; These labels refer to strings used for output


	; uninitialized data is put in the .bss segment
segment .bss
	mere resb 10 			;MEmory REgion


	; code is put in the .text segment
segment .text
global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

	;ini-myCode------------------------------

	mov [mere], dword 59F56B00h
	mov [mere+4], dword 0000A000h

	mov ebx,mere
	mov esi,mere+3
	mov edi,mere+6

	mov al,[ebx]		;add first byte
	mov ah,[esi]
	add al,ah
	mov [edi],al

	inc ebx
	inc esi
	inc edi

	mov al,[ebx]		;add second byte
	mov ah,[esi]
	adc al,ah
	mov [edi],al


	inc ebx
	inc esi
	inc edi

	mov al,[ebx]		;add third byte
	mov ah,[esi]
	adc al,ah
	mov [edi],al


	mov al,00h		;transform CF (carry) to byte
	adc al,00h
	mov [edi+1],al
	
	
        dump_mem 1, mere, 1    ; dump out memorY
	
	;fin-myCode------------------------------

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


	; Local Variables:
	; mode: nasm
	; End:
