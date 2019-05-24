; Sia dato un intero k a 32 bit e un vettore V contenente n indirizzi di
; memoria, a partire da ciascuno dei quali è memorizzata una matrice 4x4 di
; interi a 16 bit. Una matrice è considerata valida se la somma degli elementi
; sulla diagonale secondaria è inferiore a k. Scrivere un programma assembly
; che stampi "vero" se tutte le matrici il cui indirizzo è in V sono valide,
; stampi "falso" altrimenti. Segue un esempio.

section .data
	k dd 83
	M1 dw 1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8
	M2 dw 9,10,11,12,13,14,15,16,9,10,11,12,13,14,15,16
	M3 dw 17,18,19,20,21,22,23,24,17,18,19,20,21,22,23,24
	N equ 4
	V dd M1,M2,M3
	n equ 3
	vero db "vero",10
	vlen equ $-vero
	falso db "falso",10
	flen equ $-falso

section .text
	global _start
	
	_start:
		mov eax, 0				; indice vettore
		mov esi, N
		shl esi, 1				; spazio riga matrice
	
	_reset:
		mov ebx, 0				; base matrice
		mov ecx, N
		dec ecx					; indice colonna matrice
		mov dx, 0				; somma elementi nella diagonale
	
	scan_matrix:
		mov edi, [eax*4+V]		; matrix address (elemento del vettore)
		add edi, ebx
		add edi, ecx
		add edi, ecx			; edi = ebx+ecx*2+M dove M = [eax+4*V]
		add dx, [edi]
		add ebx, esi
		dec ecx
		cmp ecx, 0
		jge scan_matrix
	
	check:
		cmp dx, [k]
		jge stampa_falso
		inc eax
		cmp eax, n
		jl _reset
	
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
