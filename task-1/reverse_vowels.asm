section .data
	; declare global vars here

section .text
	global reverse_vowels
	extern printf

;;	void reverse_vowels(char *string)
;	Cauta toate vocalele din string-ul `string` si afiseaza-le
;	in ordine inversa. Consoanele raman nemodificate.
;	Modificare se va face in-place
reverse_vowels:
	enter 0, 0

	push ebx						; salvez ebx pentru final
	
	push dword 0					; esi este primul index din for
	pop esi							; si il incrementez cu 0

	push dword 0					; edi este al doilea index din for
	pop edi							; si il incrementez cu 0

	push dword [ebp + 8]			; pun pe stiva adresa string-ului
	pop esi							; si o salvez in esi


get_from_string:
	cmp byte [esi + edi], byte 0	; verific daca am ajuns la sfarsitul
									; string-ului
	je prepare_push					; daca da, sar la linia care pregateste
									; string-ul pentru a fi afisat
									; daca nu, verific urmatoarea vocala

	cmp byte [esi + edi], byte 'a'	; verific daca litera curenta este "a"
	je push_vowel_a					; daca da, sar la linia care pune pe
									; stiva litera "a"
									; daca nu, verific urmatoarea vocala

	cmp byte [esi + edi], byte 'e'	; verific daca litera curenta este "e"
	je push_vowel_e					; daca da, sar la linia care pune pe
									; stiva litera "e"
									; daca nu, verific urmatoarea vocala

	cmp byte [esi + edi], byte 'i'	; verific daca litera curenta este "i"
	je push_vowel_i					; daca da, sar la linia care pune pe
									; stiva litera "i"
									; daca nu, verific urmatoarea vocala

	cmp byte [esi + edi], byte 'o'	; verific daca litera curenta este "o"
	je push_vowel_o					; daca da, sar la linia care pune pe
									; stiva litera "o"
									; daca nu, verific urmatoarea vocala

	cmp byte [esi + edi], byte 'u'	; verific daca litera curenta este "u"
	je push_vowel_u					; daca da, sar la linia care pune pe
									; stiva litera "u"
									; daca nu, este consona si continuam codul


next_letter:
	inc edi							; incrementez index-ul pentru a trece
									; la urmatoarea litera
	jmp get_from_string				; sar la verificarea urmatoarei litere


prepare_push:
	push dword [ebp + 8]			; daca am ajuns la sfarsitul string-ului
									; pun pe stiva adresa string-ului
	pop esi							; si o salvez in esi

	push dword 0					; reinitializez indexul edi cu 0
	pop edi

get_from_string_after_pushing_vowels:
	cmp [esi + edi], byte 0			; verific daca am ajuns la sfarsitul
									; string-ului
	je end							; daca da, sar la sfarsitul functiei
									; daca nu, verific urmatoarea vocala

	cmp [esi + edi], byte 'a'		; verific daca litera curenta este "a"
	je pop_vowel_a					; daca da, sar la linia care ia de pe
									; stiva litera "a"
									; daca nu, verific urmatoarea vocala

	cmp [esi + edi], byte 'e'		; verific daca litera curenta este "e"
	je pop_vowel_e					; daca da, sar la linia care ia de pe
									; stiva litera "e"
									; daca nu, verific urmatoarea vocala

	cmp [esi + edi], byte 'i'		; verific daca litera curenta este "i"
	je pop_vowel_i					; daca da, sar la linia care ia de pe
									; stiva litera "i"
									; daca nu, verific urmatoarea vocala

	cmp [esi + edi], byte 'o'		; verific daca litera curenta este "o"
	je pop_vowel_o					; daca da, sar la linia care ia de pe
									; stiva litera "o"
									; daca nu, verific urmatoarea vocala

	cmp [esi + edi], byte 'u'		; verific daca litera curenta este "u"
	je pop_vowel_u					; daca da, sar la linia care ia de pe
									; stiva litera "u"
									; daca nu, este consona si continuam codul

next_letter_after_pushing_vowels:
	inc edi							; incrementez index-ul pentru a trece
									; la urmatoarea litera
	jmp get_from_string_after_pushing_vowels	; sar la verificarea 
												; urmatoarei litere

push_vowel_a:
	push byte "a"					; pun pe stiva litera "a"
	jmp next_letter					; sar la urmatoarea litera

pop_vowel_a:
	sub [esi + edi], byte 'a'		; scad din litera curenta litera "a"
	pop ebx							; scot de pe stiva litera "a"
	add [esi + edi], bl				; adun la litera curenta litera "a"
	jmp next_letter_after_pushing_vowels	; sar la verificarea 
											; urmatoarei litere

push_vowel_e:
	push byte "e"					; pun pe stiva litera "e"
	jmp next_letter					; sar la urmatoarea litera

pop_vowel_e:
	sub [esi + edi], byte 'e'		; scad din litera curenta litera "e"
	pop ebx							; scot de pe stiva litera "e"
	add [esi + edi], bl				; adun la litera curenta litera "e"
	jmp next_letter_after_pushing_vowels	; sar la verificarea 
											; urmatoarei litere

push_vowel_i:
	push byte "i"					; pun pe stiva litera "i"
	jmp next_letter					; sar la urmatoarea litera

pop_vowel_i:
	sub [esi + edi], byte 'i'		; scad din litera curenta litera "i"
	pop ebx							; scot de pe stiva litera "i"
	add [esi + edi], bl				; adun la litera curenta litera "i"
	jmp next_letter_after_pushing_vowels	; sar la verificarea 
											; urmatoarei litere

push_vowel_o:
	push byte "o"					; pun pe stiva litera "o"
	jmp next_letter					; sar la urmatoarea litera

pop_vowel_o:
	sub [esi + edi], byte 'o'		; scad din litera curenta litera "o"
	pop ebx							; scot de pe stiva litera "o"
	add [esi + edi], bl				; adun la litera curenta litera "o"
	jmp next_letter_after_pushing_vowels	; sar la verificarea 
											; urmatoarei litere

push_vowel_u:
	push byte "u"					; pun pe stiva litera "u"
	jmp next_letter					; sar la urmatoarea litera

pop_vowel_u:
	sub [esi + edi], byte 'u'		; scad din litera curenta litera "u"
	pop ebx							; scot de pe stiva litera "u"
	add [esi + edi], bl				; adun la litera curenta litera "u"
	jmp next_letter_after_pushing_vowels	; sar la verificarea 
											; urmatoarei litere

end:
	pop ebx			; scot de pe stiva adresa string-ului salvata la
					; inceputul functiei si o pun in ebx, astfel, ebx
					; contine adresa string-ului initial, string-ul
					; modificat in functie este in continuare in acelasi
					; loc de memorie, string-ul initial este pierdut,
					; string-ul modificat este returnat prin intermediul
					; lui ebx,
					
	push ebp
	pop ebp
	pop ebp
	ret

