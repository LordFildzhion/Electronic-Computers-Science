swap:
        mov     rax, QWORD PTR [rdi]
        mov     rdx, QWORD PTR [rsi]
        mov     QWORD PTR [rdi], rdx
        mov     QWORD PTR [rsi], rax
        ret
BubbleSort:
        cmp     rsi, 1
        je      .L2
        lea     r8, [rdi-8+rsi*8]
        jmp     .L4
.L9:
        mov     QWORD PTR [rax], rcx
        mov     QWORD PTR [rax+8], rdx
.L5:
        add     rax, 8
        cmp     rax, r8
        je      .L8
.L6:
        mov     rdx, QWORD PTR [rax]
        mov     rcx, QWORD PTR [rax+8]
        cmp     rdx, rcx
        jle     .L5
        jmp     .L9
.L8:
        sub     rsi, 1
        sub     r8, 8
        cmp     rsi, 1
        je      .L2
.L4:
        mov     rax, rdi
        jmp     .L6
.L2:
        ret
.LC0:
        .string "r"
.LC1:
        .string "test.txt"
.LC2:
        .string "%llu"
.LC3:
        .string "%Lf\n"
main:
        push    r13
        push    r12
        push    rbp
        push    rbx
        sub     rsp, 40
        mov     rdx, QWORD PTR stdin[rip]
        mov     esi, OFFSET FLAT:.LC0
        mov     edi, OFFSET FLAT:.LC1
        call    freopen
        mov     r12, rax
        lea     rdx, [rsp+24]
        mov     esi, OFFSET FLAT:.LC2
        mov     rdi, rax
        mov     eax, 0
        call    __isoc99_fscanf
        mov     rbx, QWORD PTR [rsp+24]
        lea     rdi, [0+rbx*8]
        call    malloc
        mov     r13, rax
        test    rbx, rbx
        je      .L11
        mov     rbp, rax
        mov     ebx, 0
.L12:
        mov     rdx, rbp
        mov     esi, OFFSET FLAT:.LC2
        mov     rdi, r12
        mov     eax, 0
        call    __isoc99_fscanf
        add     rbx, 1
        add     rbp, 8
        cmp     rbx, QWORD PTR [rsp+24]
        jb      .L12
.L11:
        rdtsc
        mov     rbx, rax
        sal     rdx, 32
        or      rbx, rdx
        mov     rsi, QWORD PTR [rsp+24]
        mov     rdi, r13
        call    BubbleSort
        mov     rdi, r13
        call    free
        rdtsc
        sal     rdx, 32
        or      rax, rdx
        sub     rax, rbx
        mov     QWORD PTR [rsp+8], rax
        fild    QWORD PTR [rsp+8]
        js      .L16
.L13:
        fdiv    DWORD PTR .LC5[rip]
        lea     rsp, [rsp-16]
        fstp    TBYTE PTR [rsp]
        mov     edi, OFFSET FLAT:.LC3
        mov     eax, 0
        call    printf
        mov     eax, 0
        add     rsp, 56
        pop     rbx
        pop     rbp
        pop     r12
        pop     r13
        ret
.L16:
        fadd    DWORD PTR .LC4[rip]
        jmp     .L13
.LC4:
        .long   1602224128
.LC5:
        .long   1326777081