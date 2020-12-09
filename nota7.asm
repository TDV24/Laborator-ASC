.data
    matrix: .space 1600
    roluri: .space 80
    queue: .space 400
    queueLen: .space 4
    queueIndx: .space 4
    visited: .space 400
    currentNode: .space 4
    columnIndex: .space 4
    formatd: .asciz "%d"
    formats: .asciz "%s"
    da: .asciz "Yes\n"
    nu: .asciz "No\n"
    endl: .asciz "\n"
    host: .asciz "host index %d; "
    cont: .asciz "controller index %d; "
    sw: .asciz "switch index %d; "
    swm: .asciz "switch malitios index %d: "
    swm2: .asciz "switch malitios index %d; "
    endl1: .asciz "\n"
    index: .space 4
    index1: .space 4
    index2: .space 4
    stanga: .space 4
    dreapta: .space 4
    n: .space 4
    nrleg: .space 4
    numar: .space 4
    nr_probl: .space 4
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

    for_citire_stanga_dreapta:
        movl index, %ecx
        cmp nrleg, %ecx
        je pregatire_cit_vector

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

        movl $0, %edx
        movl n, %eax
        mull stanga
        addl dreapta, %eax

        movl $1, %ebx
        movl %ebx, (%edi, %eax, 4)

        movl $0, %edx
        movl n, %eax
        mull dreapta
        addl stanga, %eax

        movl $1, %ebx
        movl %ebx, (%edi, %eax, 4)

        incl index
        jmp for_citire_stanga_dreapta  

    pregatire_cit_vector:
        lea roluri, %edi
        movl $0, index
        jmp citire_vector

    citire_vector:
        movl index, %ecx
        cmp n, %ecx
        je citire_nr_problema

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

    citire_nr_problema:
        pushl $nr_probl
        push $formatd
        call scanf
        popl %ebx
        popl %ebx
        jmp alege_problema
    
    alege_problema:
        movl nr_probl, %eax
        cmp $1, %eax
        je nota5
        cmp $2, %eax
        je nota7
        cmp $3, %eax
        je nota10

    nota5:
        movl $0, index1
        movl $0, index2
        lea roluri, %edi
        lea matrix, %esi

        # for(i = 0; i < n; i++)
        for1:
            movl index1, %ecx
            cmp n, %ecx
            je et_exit

            movl $0, index2
            movl $3, %ebx
            cmp %ebx, (%edi, %ecx, 4)
            je print_switch_malitios
            jmp continui_for1

            print_switch_malitios:
                pushl index1
                push $swm
                call printf
                popl %ebx
                popl %ebx

                jmp for2
            
            for2:
                movl index2, %ecx
                cmp n, %ecx
                je afisare_endl

                
                movl $0, %edx
                movl n, %eax
                mull index1
                addl index2, %eax

                movl $1, %edx
                cmp %edx, (%esi, %eax, 4)
                je verificare_index2
                jmp continui_for2

                verificare_index2:
                    movl index2, %ecx
                    cmp $1, (%edi, %ecx, 4)
                    je afisare_host

                    cmp $2, (%edi, %ecx, 4)
                    je afisare_switch

                    cmp $3, (%edi, %ecx, 4)
                    je afisare_switch_malitios

                    cmp $4, (%edi, %ecx, 4)
                    je afisare_controller

                afisare_host:
                    pushl index2
                    push $host
                    call printf
                    popl %ebx
                    popl %ebx

                    pushl $0
                    call fflush
                    popl %ebx
                    
                    jmp continui_for2

                afisare_switch:
                    pushl index2
                    push $sw
                    call printf
                    popl %ebx
                    popl %ebx

                    pushl $0
                    call fflush
                    popl %ebx
                    
                    jmp continui_for2

                afisare_switch_malitios:
                    pushl index2
                    push $swm2
                    call printf
                    popl %ebx
                    popl %ebx

                    pushl $0
                    call fflush
                    popl %ebx
                    
                    jmp continui_for2


                afisare_controller:
                    pushl index2
                    push $cont
                    call printf
                    popl %ebx
                    popl %ebx

                    pushl $0
                    call fflush
                    popl %ebx
                    
                    jmp continui_for2
                

                continui_for2:
                    incl index2
                    jmp for2

            afisare_endl:
                push $endl
                call printf
                popl %ebx

                pushl $0
                call fflush
                popl %ebx

                jmp continui_for1

            continui_for1:
                incl index1
                jmp for1

    nota7:
        lea queue, %edi
        movl $0, queueLen

        movl $0, %eax
        movl queueLen, %ecx
        movl %eax, (%edi, %ecx, 4)

        incl queueLen

        lea visited, %edi
        movl $1, %eax
        movl $0, %ecx
        movl %eax, (%edi, %ecx, 4)

        primul_while:
            movl queueIndx, %ecx
            cmp queueLen, %ecx
            je pregaitre_parcurgere_visited

            # currentNode = queue[queueIndx]
            lea queue, %edi
            movl (%edi, %ecx, 4), %edx
            movl %edx, currentNode

            # if roles[currentNode] == 1{
            lea roluri, %edi
            movl currentNode, %ecx
            movl $1, %edx
            cmp %edx, (%edi, %ecx, 4)
            je afisare_host_index2
            jne continuare_interior_primul_while

            afisare_host_index2:
                pushl currentNode
                push $host
                call printf
                popl %ebx
                popl %ebx

                pushl $0
                call fflush
                popl %ebx

                movl currentNode, %ecx

            continuare_interior_primul_while:
                movl $0, columnIndex

                al_doilea_while:
                    movl columnIndex, %ecx
                    cmp n, %ecx
                    je continua_primul_while

                    lea matrix, %edi
                    movl n, %eax
                    movl $0, %edx
                    mull currentNode
                    addl columnIndex, %eax

                    movl $1, %edx
                    cmp (%edi, %eax, 4), %edx
                    je al_doilea_if
                    jne continua_al_doilea_while

                al_doilea_if:
                    lea visited, %edi
                    movl columnIndex, %ecx
                    movl $1, %eax
                    cmp (%edi, %ecx, 4), %eax
                    jne interior_al_doilea_if
                    je continua_al_doilea_while

                interior_al_doilea_if:
                    lea queue, %edi
                    movl queueLen, %ecx
                    movl columnIndex, %edx
                    movl %edx, (%edi, %ecx, 4)

                    incl queueLen

                    lea visited, %edi
                    movl columnIndex, %ecx
                    movl $1, %edx
                    movl %edx, (%edi, %ecx, 4)

                continua_al_doilea_while:
                    incl columnIndex
                    jmp al_doilea_while

            continua_primul_while:
                incl queueIndx
                jmp primul_while

            pregaitre_parcurgere_visited:
                push $endl1
                call printf
                popl %ebx

                pushl $0
                call fflush
                popl %ebx

                lea visited, %edi
                movl $0, index

                parcurgere_visited:
                    movl index, %ecx
                    cmp n, %ecx
                    je verificare_suma

                    movl (%edi, %ecx, 4), %edx
                    addl %edx, suma

                    incl index
                    jmp parcurgere_visited

                verificare_suma:
                    movl suma, %ecx
                    cmp n, %ecx
                    je print_da
                    jne print_nu

                print_da:
                    push $da
                    call printf
                    popl %ebx

                    pushl $0
                    call fflush
                    popl %ebx

                    jmp et_exit

                print_nu:
                    push $nu
                    call printf
                    popl %ebx

                    pushl $0
                    call fflush
                    popl %ebx
                    jmp et_exit

    nota10:
        jmp et_exit





et_exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80


