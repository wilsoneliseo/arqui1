	;&============================================================
	;autor:
	;    Wilson S. Tubín
	;    wilsoneliseogt@gmail.com
	;fuente:
	;    clase arquitectura de computadoras 1 Ing. Otto
	;descripcion:
        ;    Lo mismo que en `exercise1.asm`, la diferencia es que aqui se
	;    utiliza un ciclo.
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
	
	xor ecx,ecx		;CF=0, ecx=0. CF=0 because the first
				;sum with carry should not contaminate
				;the result
	mov cx,3

	mov ebx,mere
.ciclo:
	mov al,[ebx]
	mov ah,[ebx+3]
	adc al,ah
	mov [ebx+6],al

	inc ebx
	dec cx
	jnz .ciclo

	mov al,00h		;transform CF (carry) to byte
	adc al,00h
	mov [mere+9],al
	
        dump_mem 1, mere, 1    ; dump out memorY
	
	;fin-myCode------------------------------

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret



	; Local Variables:
	; mode: nasm
	; End:
