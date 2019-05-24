; Scrivere una programma assembly che, dato un intero X (a 16 bit) e una
; matrice quadrata di interi a 16 bit, verifichi che la somma in valore
; assoluto degli elementi negativi posti in posizione [i,j], tale che o i e j
; sono entrambi indici dispari o i e j sono entrambi indici pari, sia
; inferiore ad X. Memorizzare l'esito della verifica in una variabile
; (memorizzare "1" per "vero" e "0" per "falso").

section .data
	X dw 69
	M dw -1,2,-3,4,5,-6,7,-8,-9,10,-11,12,13,-14,15,-16
	dim equ $-M
	n equ 4

section .text
	global _start
	
	_start:
		mov eax, 0; base
		mov ebx, 0; indice colonna
		mov edi, 0; indice riga
		mov esi, n
		shl esi, 1; spazio riga
		mov ecx, 0; sum

	scan_row:
		mov edx, ebx
		add edx, edi
		shr edx, 1
		jc change_col
	
	somma:
		mov dx, [eax+ebx*2+M]
		cmp dx, 0
		jge change_col
		sum:add cx, [eax+ebx*2+M]
	
	change_col:
		inc ebx
		cmp ebx, n
		jge change_row
		jmp scan_row
	
	change_row:
		mov ebx, 0
		inc edi
		add eax, esi
		cmp eax, dim
		jl scan_row
	
	check:
		neg cx
		mov eax, 0; eax contiene il valore finale
		cmp cx, [X]
		jge exit
		mov eax, 1
	
	exit:
		mov eax, 1
		mov ebx, 0
		int 0x80
