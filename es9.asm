; Scrivere una programma in Assembly che, dati due vettori V1 e V2 di interi
; a 32 bit ed entrambi di dimensione n, restituisca un terzo array di interi
; a 32 bit V3 anch’esso di taglia n tale che, per ogni indice i:
; V3[i] = V1[n-i-1] se V1[i] <= V2[i],
; V3[i] = V2[i] altrimenti.

section .data
	V1 dd 1,6,8,0,9,2
	V2 dd 7,3,2,5,8,0
	n equ 6

section .bss
	V3 resd 6

section .text
	global _start
	
	_start:
		mov eax, 0			;primo indice
		mov ebx, n			;secondo indice
	
	scan:
		dec ebx
		mov ecx, [eax*4+V1]
		cmp ecx, [eax*4+V2]
		jg caso2
	
	caso1:
		mov ecx, [ebx*4+V1]
		jmp insert
	
	caso2:
		mov ecx, [eax*4+V2]
	
	insert:
		mov [eax*4+V3], ecx
		inc eax
		cmp eax, n
		jl scan
	
	visualizza:
		mov eax, [0+V3]
		mov ebx, [4+V3]
		mov ecx, [8+V3]
		mov edx, [12+V3]
		mov esi, [16+V3]
		mov edi, [20+V3]
	
	exit:
		mov eax, 0
		mov ebx, 1
		int 0x80
