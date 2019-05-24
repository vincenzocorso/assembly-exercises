; Scrivere una programma in Assembly che, data una matrice quadrata M di interi
; a 16 bit, stampi su video "Vero" se la somma degli elementi della diagonale
; principale di M coincide con la somma degli elementi diagonale secondaria
; e stampi "Falso" altrimenti

section .data
	M dw 2,1,2,5,3,2,1,4,5,1,4,6,1,7,8,0
	n equ 4
	vero db "Vero",10
	vlen equ $-vero
	falso db "Falso",10
	flen equ $-falso

section .text
	global _start
	
	_start:
		mov esi, n
		shl esi, 1			;spazio riga
		mov eax, 0			;base
		mov ebx, 0			;indice1
		mov edi, n
		dec edi				;indice2
		mov cx, 0			;somma diag. principale
		mov dx, 0			;somma diag. secondaria
	
	scan:
		add cx, [eax+ebx*2+M]
		add dx, [eax+edi*2+M]
		add eax, esi
		inc ebx
		dec edi
		cmp ebx, n
		jl scan
	
	check:
		cmp cx, dx
		je stampa_vero
	
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
