/*
 * Don't forget to include "positions.h"
 */

#include "positions.h"

.section .text
.global add_vect

/* 
 * void add_vect(int *v1, int *v2, int n, int *v)
 *
 * add v1 and v2, that have both the length n, and store the result in v3.
 * also, substract from v3 the values provided in positions.S, as described
 * in the task
 */

add_vect:
	pushl	%ebp
	movl 	%esp, %ebp

	movl 8(%ebp), %esi			# esi = v1
	movl 12(%ebp), %edi			# edi = v2
	movl 16(%ebp), %ecx			# ecx = n
	movl 20(%ebp), %edx			# edx = v
	movl $0, %ebx		   	 	# ebx = i = 0, indexul


	# adunarea elementelor din v1 si v2
loop:
	cmpl %ecx, %ebx				# daca i = n
	je 	end						# ies din functie

	movl (%esi), %eax			# eax = v1[i]
	addl (%edi), %eax			# eax = v1[i] + v2[i]
	movl %eax, (%edx)			# v[i] = v1[i] + v2[i]
	addl $4, %esi				# v1++
	addl $4, %edi				# v2++

	cmpl $10, %ecx				# daca n < 10
	jl fewer_elements			# sar la cazul in care modifica
								# pozitiile din header in jos
	cmpl $10, %ecx				# daca n > 10
	jg more_elements			# sar la cazul in care modifica
								# pozitiile din header in sus
	jmp good_elements			# altfel, sar la cazul in care
								# nu modifica pozitiile din header


	# cazul in care modifica pozitiile din header in sus
more_elements:
	cmpl $10, %ebx				# daca i = 10
	je first_position			# sar la prima pozitie din header

	cmpl $20, %ebx	        	# daca i = 20
	je second_position			# sar la a doua pozitie din header

	cmpl $35, %ebx				# daca i = 35
	je third_position			# sar la a treia pozitie din header

	addl $4, %edx				# v++
	addl $1, %ebx				# i++

	jmp loop					# trec la urmatoarea iteratie


	# cazul in care modifica pozitiile din header in jos
fewer_elements:
	cmpl $1, %ebx				# daca i = 1
	je first_position			# sar la prima pozitie din header

	cmpl $2, %ebx				# daca i = 2
	je second_position			# sar la a doua pozitie din header

	cmpl $3, %ebx				# daca i = 3
	je third_position			# sar la a treia pozitie din header

	addl $4, %edx				# v++
	addl $1, %ebx				# i++

	jmp loop					# trec la urmatoarea iteratie


	# cazul in care nu modifica pozitiile din header
good_elements:
	cmpl $FIRST_POSITION, %ebx	# daca i = FIRST_POSITION
	je first_position			# sar la prima pozitie din header

	cmpl $SECOND_POSITION, %ebx	# daca i = SECOND_POSITION
	je second_position			# sar la a doua pozitie din header

	cmpl $THIRD_POSITION, %ebx	# daca i = THIRD_POSITION
	je third_position			# sar la a treia pozitie din header

	addl $4, %edx				# v++
	addl $1, %ebx				# i++

	jmp loop					# trec la urmatoarea iteratie


	# scad din v[i] valoarea de la FIRST_POSITION
first_position:
	subl $FIRST_VALUE, (%edx)	# v[i] = v[i] - FIRST_VALUE
	addl $1, %ebx				# i++
	addl $4, %edx				# v++
	jmp loop					# trec la urmatoarea iteratie


	# scad din v[i] valoarea de la SECOND_POSITION
second_position:
	subl $SECOND_VALUE, (%edx)	# v[i] = v[i] - SECOND_VALUE
	addl $1, %ebx				# i++
	addl $4, %edx				# v++
	jmp loop					# trec la urmatoarea iteratie


	# scad din v[i] valoarea de la THIRD_POSITION
third_position:
	subl $THIRD_VALUE, (%edx)	# v[i] = v[i] - THIRD_VALUE
	addl $1, %ebx				# i++
	addl $4, %edx				# v++
	jmp loop					# trec la urmatoarea iteratie


	# ies din functie
end:

	leave
	ret
