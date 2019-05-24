; Data una matrice quadrata M di interi a 16 bit e un numero k, scrivere un
; programma assembly che stampi “vero” se la somma degli elementi della matrice
; triangolare inferiore della matrice ad esclusione della diagonale è superiore
; a k e stampi “falso” altrimenti.

section .data
	M dw 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25
	n equ 5
	k equ 189
	vero db "vero",10
	vlen equ $-vero
	falso db "falso",10
	flen equ $-falso

section .text
	global _start
	
	_start:
		mov esi, n
		shl esi, 1; spazio riga
		mov eax, esi; base
		mov ebx, n
		dec ebx; indice colonna = n-1
		mov edx, ebx;
		mov ecx, 0; sum
		
	check_row:
		add cx, [eax+ebx*2+M]
		inc ebx
		cmp ebx, n
		jne check_row
	
	change_row:
		dec edx
		mov ebx, edx
		add eax, esi
		cmp ebx, 0
		jne check_row
	
	check:
		cmp cx, k
		jg stampa_vero
	
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
