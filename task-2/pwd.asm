section .data
	back db "..", 0
	curr db ".", 0
	slash db "/", 0

	; declare global vars here


	; declar variabilele externe necesare
    nothing db 0				; string-ul cu nimic
	string_length dd 0			; lungimea curenta a string-ului
	last_word_length dd 0		; lungimea ultimului cuvant
	debugging db "%d\n",0		; debugging

section .text
	global pwd


	; declar functiile externe folosite pentru operatii cu siruri
	extern strcat
	extern strlen
	extern strcpy
	extern strcmp

;;	void pwd(char **directories, int n, char *output)
;	Adauga in parametrul output path-ul rezultat din
;	parcurgerea celor n foldere din directories
pwd:
	enter 0, 0
	pusha

	mov eax, [ebp+8] 			; directories
	mov ecx, [ebp+12] 			; n
	mov ebx, [ebp+16] 			; output


	; initializez string-ul cu nimic
	pusha						; push everything
	push nothing	    		; push nothing
	push ebx					; push output

	call strcpy					; strcpy(output, nothing)

	add esp, 8 					; scot parametrii din stiva
	popa						; pop everything

pwd_main:
	mov edx, [eax]				; edx = directories[i]
	mov ebx, [ebp+16]			; ebx = output


	; cazul in care am ".." si trebuie sa merg in ultimul folder
	pusha						; push everything
	push edx					; push directories[i]
	push back					; push ".."

	call strcmp					; strcmp(directories[i], "..")
	cmp eax, 0					; daca sunt egale
	je pwd_back					; merg in ultimul folder

	add esp, 8					; scot parametrii din stiva
	popa			   		 	; pop everything


	; cazul in care am "." si trebuie sa raman in folderul curent
	pusha						; push everything
	push edx					; push directories[i]
	push curr					; push "."

	call strcmp					; strcmp(directories[i], ".")
	cmp eax, 0					; daca sunt egale
	je pwd_curr					; raman in folderul curent

	add esp, 8					; scot parametrii din stiva
	popa						; pop everything


	; trebuie sa adaug '/' inainte de urmatorul folder
	pusha						; push everything
	push slash					; push "/"
	push ebx					; push output

	call strcat					; strcat(output, "/")

	add esp, 8					; scot parametrii din stiva
	popa						; pop everything


	; trebuie sa adaug urmatorul folder
	pusha						; push everything
	push edx					; push directories[i]
	push ebx					; push output

	call strcat					; strcat(output, directories[i])

	add esp, 8					; scot parametrii din stiva
	popa						; pop everything

	
	jmp pwd_next  				; continui cu urmatorul folder


	; daca am ajuns aici, inseamna ca am ".." si trebuie sa merg 
	; in ultimul folder din path
pwd_back:
	add esp, 8					; scot ".." din stiva


	; verific care este lungimea curenta a string-ului
	push ebx					; push output

	call strlen					; strlen(output)
	add esp, 4					; scot parametrii din stiva
	mov [string_length], eax	; string_length = strlen(output)

	popa						; pop everything


	; ajung la ultimul folder
	pusha						; push everything

	add ebx, [string_length]	; ebx = output + strlen(output)
	sub ebx, 1					; ebx = output + strlen(output) - 1


	; caut ultimul '/' si vreau sa pun terminator de sir dupa
	; el, ca sa sterg ultimul folder
no_slash:
	; daca ajung la '/'
	cmp byte [ebx], '/'			; daca am ajuns la '/'
	je go_back					; merg inapoi

	dec ebx						; decrementez ebx

	jmp no_slash				; continui sa caut


	; am ajuns la ultimul '/'
	; pun terminator de sir dupa el
go_back:
	mov byte [ebx], 0			; output[strlen(output) - 1] = 0
	popa						; pop everything

	jmp pwd_next				; continui cu urmatorul folder


	; daca am ajuns aici, inseamna ca am "." si trebuie sa raman
	; in folderul curent
pwd_curr:
	add esp, 8					; scot "." din stiva
	popa						; pop everything


	; trec la urmatorul folder
pwd_next:
	add eax, 4 					; trec la urmatorul folder
	dec ecx 					; decrementez n

	cmp ecx, 0 					; daca n == 0
	jne pwd_main 				; continui cu urmatorul folder


	; daca string-ul se termina cu '/', daca nu adaug '/' la final
	mov ebx, [ebp+16]			; ebx = output

	pusha						; push everything
	push ebx					; push output

	call strlen					; strlen(output)

	add esp, 4					; scot parametrii din stiva

	mov [string_length], eax	; string_length = strlen(output)

	popa						; pop everything

	add ebx, [string_length]	; ebx = output + strlen(output)
	dec ebx						; ebx = output + strlen(output) - 1

	cmp ebx, '/'				; daca output[strlen(output) - 1] == '/'
	je end						; nu mai adaug '/'

	add ebx, 1					; ebx = output + strlen(output)
	mov byte [ebx], '/'			; output[strlen(output)] = '/'

	add ebx, 1					; ebx = output + strlen(output) + 1
	mov byte [ebx], 0			; output[strlen(output) + 1] = 0


end:
	popa						; pop everything

	leave
	ret