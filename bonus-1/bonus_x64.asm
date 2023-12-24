section .text
	global intertwine

;; void intertwine(int *v1, int n1, int *v2, int n2, int *v);
;
;  Take the 2 arrays, v1 and v2 with varying lengths, n1 and n2,
;  and intertwine them
;  The resulting array is stored in v
intertwine:
	push	rbp
	mov 	rbp, rsp

	mov r9, rdi     ; r9 preia adresa lui v1
	mov r10, rsi    ; r10 preia valoarea lui n1
	mov r11, rdx    ; r11 preia adresa lui v2
	mov r12, rcx    ; r12 preia valoarea lui n2
	mov rbx, r8     ; rbx preia adresa lui v

	mov rcx, r10    ; rcx = n1
	mov rdx, r12    ; rdx = n2

loop1:
	dec rcx         ; n1--, decrementez n1 ca sa tin cont de numarul de 
					; elemente din v1

	mov rax, [r9]   ; rax este un auxiliar care preia valoarea lui v1[i]
	mov [rbx], rax  ; v[i] = v1[i]

	add rbx, 4      ; v++, incrementez adresa lui v ca sa pot trece la 
					; urmatorul element din v
	add r9, 4       ; v1++, incrementez adresa lui v1 ca sa pot trece la 
					; urmatorul element din v1

	cmp rdx, 0      ; verific daca n2 != 0, daca da, atunci se trece la 
					; loop2, ca sa preiau urmatorul element pentru v din v2
	jne loop2       ; goto loop2

	cmp rcx, 0      ; verific daca n1 != 0, daca da, atunci se trece la 
					; loop1, ca sa preiau urmatorul element pentru v din v1
	jne loop1       ; goto loop1

	jmp end         ; sar la end, pentru ca am terminat de preluat elementele
					; din v1 si v2


loop2:
	dec rdx         ; n2--, decrementez n2 ca sa tin cont de numarul de 
					; elemente din v2

	mov rax, [r11]  ; rax este un auxiliar care preia valoarea lui v2[i]
	mov [rbx], rax  ; v[i] = v2[i]

	add rbx, 4      ; v++, incrementez adresa lui v ca sa pot trece la 
					; urmatorul element din v
	add r11, 4      ; v2++, incrementez adresa lui v2 ca sa pot trece la 
					; urmatorul element din v2

	cmp rcx, 0      ; verific daca n1 != 0, daca da, atunci se trece la 
					; loop1, ca sa preiau urmatorul element pentru v din v1
	jne loop1       ; goto loop1

	cmp rdx, 0      ; verific daca n2 != 0, daca da, atunci se trece la 
					; loop2, ca sa preiau urmatorul element pentru v din v2
	jne loop2       ; goto loop2

					; daca am ajuns aici, inseamna ca am terminat de preluat
					; elementele din v1 si v2, deci ajung la end

end:

	leave
	ret
