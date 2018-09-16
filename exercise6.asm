	;&============================================================
	;autor:
	;    Wilson S. Tubín
	;    wilsoneliseogt@gmail.com
	;fuente:
	;    clase arquitectura de computadoras 1 Ing. Otto
	;descripcion:
	;    Suponga que posee ram con datos, de tamaño byte,
	;    prealmacenados de la posición `mere` a `mere+8e`. Diseñe
	;    un programa a bajo nivel de los CPU Intel en plataforma 8
	;    o 16 bit que encuetre y guarde en el registro que usted
	;    desee el número de bytes divisibles por "dos" y
	;    negativos. Disponga tambien del registro CX, para guardar
	;    en él, el valor 0000h. Si el tiempo que tarda el
	;    desarollo de esta tarea es inferior a 5 mili segundos y
	;    el dato FFFFh si es mayor o igual. Trabajar CPU P1 a 100Mhz.
	;.============================================================
	
%include "asm_io.inc"

	; initialized data is put in the .data segment
segment .data
	mere times 8fh db 1

	; uninitialized data is put in the .bss segment
segment .bss

	
	; code is put in the .text segment
segment .text
global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

	;ini-myCode------------------------------
				;NEgative NUmber=NENU
				;DIvisible for TWo=DITW

	mov [mere],word 10010100b ;adding value on purpose. NENU & DITW
	mov [mere+9],word 01110100b ;adding value on purpose. DITW
	mov [mere+20],word 10000101b ;adding value on purpose. NENU
	mov [mere+30],word 11010110b ;adding value on purpose. NENU & DITW
	mov [mere+40],word 10011110b ;adding value on purpose. NENU & DITW
				;                              -------------
				;                               correct 3
	


	
	xor cl,cl		;counter                             Tej XOR=T
	mov esi, mere		;                                    Tej MOV=T
.init:
	mov al, [esi]		;                                    Tej MOV=8fh(T)
	test al, 10000001b	;                                    Tej TEST=8fh(T) 
	jns .fails		;is positive                         Tej JNS=8fh(T)
	shr al,1		;                                    Tej SHR=8fh(T)
	jc .fails		;not divisible for two               Tej JC=8fh(T)
	inc cl			;success, increase counter           Tej INC=8fh(T)
.fails:
	inc esi			;                                    Tej INC=8fh(T)
	cmp esi,mere+8eh	;                                    Tej CMP=8fh(T)

	jnz .init		;                                    Tej JNZv=(8fh-1)(T)
				;                                    Tej JNZf=T

	mov al,cl
	mov cx,0000h

				;delta To=3T+8h(8Fh)+8Eh(T)
				;        =T(3+8(8F)+8E)h
				;        =T(509)h
				;        =T(1289)d
				;        =1289T
				;
				;F=100MHZ
				;T=1/F=1/(100MHZ)=10^(-5) ms
				;
				;delta To=1289T=1289[10^(-5)]ms
				;        =0.01289 ms
				;
				;es inferior a 5 mili segundos por
				;        tanto CX=0000h
	

	dump_regs 1
	;output:
	;    al=03
	
	;fin-myCode------------------------------

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret	

	; Local Variables:
	; mode: nasm
	; End:
