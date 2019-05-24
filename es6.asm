; Scrivere una programma in Assembly che, dato un intero k (a 16 bit) e una
; matrice quadrata M di interi a 16 bit, stampi su video "Vero" se la
; diagonale principale di M contiene almeno un’occorrenza di k, e stampi
; "Falso" altrimenti.

section .data
	k dw 14
	M dw 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
	dim equ $-M
	n equ 4
	vero db "Vero",10
	vlen equ $-vero
	falso db "Falso",10
	flen equ $-falso

section .text
	global _start
	
	_start:
		mov eax, 0				;base
		mov ebx, 0				;indice colonna
		mov esi, n
		shl esi, 1				;spazio riga
	
	scan:
		mov cx, [eax+ebx*2+M]
		cmp cx, [k]
		je stampa_vero
		add eax, esi
		inc ebx
		cmp ebx, n
		jl scan
	
	stampa_falso:
		mov eax, 4
		mov ebx, 1
		mov ecx, falso
		mov edx, flen
		int 0x80
		jmp exit
	
	stampa_vero:
		mov eax, 4
		mov ebx, 1
		mov ecx, vero
		mov edx, vlen
		int 0x80
	
	exit:
		mov eax, 1
		mov ebx, 0
		int 0x80
