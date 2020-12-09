.data
	n: .space 4
	nrleg: .space 4
	stanga: .space 4
	dreapta: .space 4
	host: .asciz "host index %d; "
	cont: .asciz "controller index %d; "
	sw: .asciz "switch index %d; "
	swm: .asciz "switch malitios index %d; "
	swm1: .asciz "switch malitios index %d: "
	coada: .space 1600
	matrix: .fill 1600
	indexlinie: .space 4
	indexcoloana: .space 4
	host1: .space 4
	host2: .space 4
	msg: .space 40
	formatd: .asciz "%d"
	formats: .asciz "%s"
	newline: .asciz "\n"
	nrprob: .space 4
	viz: .fill 1600
	roluri: .space 1600
	numar: .space 4
	index: .space 4
	index1: .space 4
	index2: .space 4
	strYes: .asciz "Yes\n"
	strNo: .asciz "No\n"
	douapct: .asciz ": "
	coadalung: .space 4
	nodactual: .space 4
	coadaact: .space 4
	suma: .long 0
.text

.global main

main:
	pushl $n
	push $formatd
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $nrleg
	push $formatd
	call scanf
	popl %ebx
	popl %ebx	

	movl $0, index
	lea matrix, %edi
	
	citire_matrice:

		movl index, %ecx
		cmp  %ecx, nrleg
		je preg_cit_vector
	
		pushl $stanga
		push $formatd
		call scanf
		popl %ebx
		popl %ebx
	
		pushl $dreapta
		push $formatd
		call scanf
		popl %ebx
		popl %ebx
	
		movl stanga, %eax
		movl $0, %edx
		mull n
		addl dreapta, %eax
		movl $1, (%edi, %eax, 4)

		movl dreapta, %eax
		movl $0, %edx
		mull n
		addl stanga, %eax
		movl $1, (%edi, %eax, 4)

		incl index
		jmp citire_matrice
	
	preg_cit_vector:
    		lea roluri, %edi
    		movl $0, index
    		jmp citire_vector

	citire_vector:
    		movl index, %ecx
    		cmp n, %ecx
    		je numar_problema

    		pushl $numar
    		push $formatd
   		call scanf
   		popl %ebx
    	popl %ebx

    movl index, %ecx
    movl numar, %edx
    movl %edx, (%edi, %ecx, 4)

    incl index
    jmp citire_vector


numar_problema:
	pushl $nrprob
	push $formatd
	call scanf
	popl %ebx
	popl %ebx
	jmp verif_nr_prob

verif_nr_prob:
	
	movl nrprob, %eax
	cmp $1, %eax
	je nota_5
	
	cmp $2, %eax
	je nota_7
	
	cmp $3, %eax
	je nota_10
	
nota_5:
	movl $0, index1
	lea roluri, %esi
	lea matrix, %edi
	
    for_1:
        movl index1, %ecx
        cmp n, %ecx
        je etexit

        movl $0, index2
        movl $3, %edx
        cmp (%esi, %ecx, 4), %edx
        je swm_1
        jne cont_for_1

    swm_1:
        pushl index1
        push $swm1
        call printf
        popl %ebx
        popl %ebx

        pushl $0
        call fflush
        popl %ebx

        jmp for_2

    for_2:
        movl index2, %ecx
        cmp n, %ecx
        je new_line


        movl n, %eax
        mull index1
        addl index2, %eax     

        movl $1, %ebx
        movl (%edi, %eax, 4), %edx
        cmp %ebx, %edx
        je  verif_afis
        jne cont_for_2

    verif_afis:
        movl index2, %ecx

        movl (%esi, %ecx, 4), %edx
        cmp $1, %edx                
        je af_h

        cmp $2, %edx               
        je af_sw

        cmp $3, %edx
        je af_swm

        cmp $4, %edx               
        je af_c

    af_h:
      
        pushl index2
        push $host
        call printf
        popl %ebx
        popl %ebx

        pushl $0
        call fflush
        popl %ebx

        jmp cont_for_2

    af_sw:

        pushl index2
        push $sw
        call printf
        popl %ebx
        popl %ebx
        
        pushl $0
        call fflush
        popl %ebx

        jmp cont_for_2

    af_swm:

        pushl index2
        push $swm
        call printf
        popl %ebx
        popl %ebx

        pushl $0
        call fflush
        popl %ebx

        jmp cont_for_2

    af_c:
    
        pushl index2
        push $cont
        call printf
        popl %ebx
        popl %ebx

        pushl $0
        call fflush
        popl %ebx

        jmp cont_for_2


    new_line:

        push $newline
        push $formats
        call printf
        popl %ebx
        popl %ebx

        push $0
        call fflush
        popl %ebx


        jmp cont_for_1

    cont_for_2:
        incl index2
        jmp for_2
    

    cont_for_1:
        incl index1
        jmp for_1

	
    nota_7:
        lea coada, %edi
        movl $0, coadalung

        movl $0, %eax
        movl coadalung, %ecx
        movl %eax, (%edi, %ecx, 4)

        incl coadalung

        lea viz, %edi
        movl $1, %eax
        movl $0, %ecx
        movl %eax, (%edi, %ecx, 4)

        while_1:
            movl coadaact, %ecx
            cmp coadalung, %ecx
            je viz_1

            lea coada, %edi
            movl (%edi, %ecx, 4), %edx
            movl %edx, nodactual

            lea roluri, %edi
            movl nodactual, %ecx
            movl $1, %edx
            cmp %edx, (%edi, %ecx, 4)
            je af_host
            jne cont_while_1

            af_host:
                pushl nodactual
                push $host
                call printf
                popl %ebx
                popl %ebx

                pushl $0
                call fflush
                popl %ebx

                movl nodactual, %ecx

            cont_while_1:
                movl $0, indexcoloana
                jmp while_2

                while_2:
                    movl indexcoloana, %ecx
                    cmp n, %ecx
                    je final_while_1

                    lea matrix, %edi
                    movl n, %eax
                    movl $0, %edx
                    mull nodactual
                    addl indexcoloana, %eax

                    movl $1, %edx
                    cmp (%edi, %eax, 4), %edx
                    je if_1
                    jne final_while_2

                if_1:
                    lea viz, %edi
                    movl indexcoloana, %ecx
                    movl $1, %eax
                    cmp (%edi, %ecx, 4), %eax
                    jne if_2
                    je final_while_2

                if_2:
                    lea coada, %edi
                    movl coadalung, %ecx
                    movl indexcoloana, %edx
                    movl %edx, (%edi, %ecx, 4)

                    incl coadalung

                    lea viz, %edi
                    movl indexcoloana, %ecx
                    movl $1, %edx
                    movl %edx, (%edi, %ecx, 4)

                final_while_2:
                    incl indexcoloana
                    jmp while_2

            final_while_1:
                incl coadaact
                jmp while_1

            viz_1:
                push $newline
                call printf
                popl %ebx

                pushl $0
                call fflush
                popl %ebx

                lea viz, %edi
                movl $0, index

                viz_2:
                    movl index, %ecx
                    cmp n, %ecx
                    je verificare_suma

                    movl (%edi, %ecx, 4), %edx
                    addl %edx, suma

                    incl index
                    jmp viz_2

                verificare_suma:
                    movl suma, %ecx
                    cmp n, %ecx
                    je print_da
                    jne print_nu

                print_da:
                    push $strYes
                    call printf
                    popl %ebx

                    pushl $0
                    call fflush
                    popl %ebx

                    jmp etexit

                print_nu:
                    push $strNo
                    call printf
                    popl %ebx

                    pushl $0
                    call fflush
                    popl %ebx
                    jmp etexit

 

nota_10:
	
	pushl $host1
	pushl $formatd
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $host2
	pushl $formatd
	call scanf
	popl %ebx
	popl %ebx
	
	push $msg
	push $formats
	call scanf
	popl %ebx
	popl %ebx
	
	movl host1, %eax
	movl host2, %ebx
	cmp %ebx, %eax
	jg interschimbare
	
	interschimbare:
	
		movl host1, %ebx
		movl host2, %eax
		movl %eax, host1
		movl %ebx, host2
	
	lea coada, %edi
	movl $0, coadalung
	movl host1, %eax
	movl coadalung, %ecx
	movl %eax, (%edi, %ecx, 4)
	incl coadalung
	
	lea viz, %edi
	movl $1, %eax
	movl host1, %ecx
	movl %eax, (%edi, %ecx, 4)
	
	while_3:
		movl coadaact, %ecx
		cmp coadalung, %ecx
		je ver_host_2
		
		lea coada, %edi
		movl (%edi, %ecx, 4), %edx
		movl %edx, nodactual
		movl $0, indexcoloana
		
		while_4:
			movl indexcoloana, %ecx
			cmp n, %ecx
			je final_while_3
			
			lea matrix, %edi
			movl nodactual, %eax
			movl $0, %edx
			mull n
			addl indexcoloana, %eax
			movl $1, %edx
			cmp %edx, (%edi, %eax, 4)
			je if_3
			jne final_while_4
			
			if_3:
				
				lea viz, %edi
				movl indexcoloana, %ecx
				movl $0, %eax
				cmp %eax, (%edi, %ecx, 4)
				je if_4
				jne final_while_4
				
			if_4:
					
				lea roluri, %edi
				movl indexcoloana, %ecx
				movl $3, %eax
				cmp %eax, (%edi, %ecx, 4)
				je final_while_4
				jne if_5
					
			if_5:
				
				lea coada, %edi
				movl coadalung, %ecx
				movl indexcoloana, %edx
				movl %edx, (%edi, %ecx, 4)
				incl coadalung
				
				lea viz, %edi
				movl indexcoloana, %ecx
				movl $1, %edx
				movl %edx, (%edi, %ecx, 4)
				
			final_while_4:
			
				incl indexcoloana
				jmp while_4
		final_while_3:
		
			incl coadaact
			jmp while_3
		
	ver_host_2:
		
		lea viz, %edi
		movl host2, %ecx
		movl $1, %edx
		cmp %edx, (%edi, %ecx, 4)
		je afisare_mesaj
		jne modificare_mesaj
	
	modificare_mesaj:
		
		lea msg, %edi
		movl $0, index
		
		mod_1:
			
			movl index, %ecx
			mov (%edi, %ecx, 1), %al
			cmp $0, %al
			je afisare_mesaj
			
			subb $10, %al
			cmp $97, %al
			jb mod_2
			jmp adaugare
			
			mod_2:
			
				addb $122, %al
				subb $97, %al
				addb $1, %al
				jmp adaugare
			
			adaugare:
				
				mov %al, (%edi, %ecx, 1)
				incl index
				jmp mod_1
	afisare_mesaj:
		
		push $msg
		push $formats
		call printf
		popl %ebx
		popl %ebx
		
		pushl $0
		call fflush
		popl %ebx
		
		jmp etexit
etexit:

	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
