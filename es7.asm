; Scrivere una programma in Assembly che, data una matrice quadrata M di interi
; a 32 bit, stampi su video "Vero" se la diagonale principale di M coincide
; con la diagonale secondaria capovolta e stampi "Falso" altrimenti.

section .data
	M dd 1,5,6,4,7,2,3,8,9,2,3,10,1,11,12,4
	dim equ $-M
	n equ 4
	vero db "Vero",10
	vlen equ $-vero
	falso db "Falso",10
	flen equ $-falso

section .text
	global _start
	
	_start:
		mov esi, n
		shl esi, 2				;spazio riga
		mov eax, 0				;indice colonna
		mov ebx, 0				;base1
		mov ecx, dim
		sub ecx, esi			;base2
	
	scan:
		mov edx, [ebx+eax*4+M]
		cmp edx, [ecx+eax*4+M]
		jne stampa_falso
		add ebx, esi
		sub ecx, esi
		inc eax
		cmp eax, n
		jl scan
	
	stampa_vero:
		mov eax, 4
		mov ebx, 1
		mov ecx, vero
		mov edx, vlen
		int 0x80
		jmp exit
	
	stampa_falso:
		mov eax, 4
		mov ebx, 1
		mov ecx, falso
		mov edx, flen
		int 0x80
	
	exit:
		mov eax, 1
		mov ebx, 0
		int 0x80
