; Scrivere un programma assembly che, dati due vettori V1 e V2, stampi "vero"
; se V1 è uguale a V2 capovolto e stampi "falso" altrimenti.

section .data
	V1 dd 1,2,2,4,5
	V2 dd 5,4,2,2,1
	n equ 5
	vero db "vero",10
	vlen equ $-vero
	falso db "falso",10
	flen equ $-falso

section .text
	global _start
	
	_start:
		mov eax, 0
		mov ecx, n
		dec ecx; ecx = n-1
	
	_check:
		mov ebx, [eax*4+V1]
		cmp ebx, [ecx*4+V2]
		jne stampa_falso
		inc eax
		loop _check
	
	stampa_vero:
		mov eax, 4
		mov ebx, 1
		mov ecx, vero
		mov edx, vlen
		int 0x80
		jmp _exit
	
	stampa_falso:
		mov eax, 4
		mov ebx, 1
		mov ecx, falso
		mov edx, flen
		int 0x80
	
	_exit:
		mov eax, 1
		mov ebx, 0
		int 0x80
