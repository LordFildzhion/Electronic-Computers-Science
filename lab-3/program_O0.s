swap:
        push    rbp						; Сохраняет текущее значение регистра rbp (базовый указатель стека) в стеке
        mov     rbp, rsp				; Устанавливает новый базовый указатель стека равным текущему указателю стека (rsp)
        mov     QWORD PTR [rbp-24], rdi	; Копирует значение в регистре rdi (первый аргумент функции) в память по адресу [rbp-24]
        mov     QWORD PTR [rbp-32], rsi	; Копирует значение в регистре rsi (второй аргумент функции) в память по адресу [rbp-32]
        mov     rax, QWORD PTR [rbp-24]	; Загружает адрес в rbp-24 в регистр rax
        mov     rax, QWORD PTR [rax]	; Разыменовывает указатель rax и загружает значение, на которое он указывает
        mov     QWORD PTR [rbp-8], rax	; Сохраняет значение из регистра rax по адресу [rbp-8]
        mov     rax, QWORD PTR [rbp-32]	; Загружает адрес в rbp-32 в регистр rax
        mov     rdx, QWORD PTR [rax]	; Разыменовывает указатель rax и загружает значение по адресу, на который указывает rax, в rdx
        mov     rax, QWORD PTR [rbp-24]	; Загружает указатель в rbp-24 в rax
        mov     QWORD PTR [rax], rdx	; 
        mov     rax, QWORD PTR [rbp-32]	;
        mov     rdx, QWORD PTR [rbp-8]	;
        mov     QWORD PTR [rax], rdx	;
        nop								;
        pop     rbp						;
        ret								;
BubbleSort:
        push    rbp						;
        mov     rbp, rsp				;
        sub     rsp, 32					;
        mov     QWORD PTR [rbp-24], rdi	;
        mov     QWORD PTR [rbp-32], rsi	;
        mov     QWORD PTR [rbp-8], 0	;
        jmp     .L3						;
.L7:
        mov     QWORD PTR [rbp-16], 0	;
        jmp     .L4						;
.L6:
        mov     rax, QWORD PTR [rbp-16]	;
        lea     rdx, [0+rax*8]			;
        mov     rax, QWORD PTR [rbp-24]	;
        add     rax, rdx				;
        mov     rdx, QWORD PTR [rax]	;
        mov     rax, QWORD PTR [rbp-16]	;
        add     rax, 1					;
        lea     rcx, [0+rax*8]			;
        mov     rax, QWORD PTR [rbp-24]	;
        add     rax, rcx				;
        mov     rax, QWORD PTR [rax]	;
        cmp     rdx, rax				;
        jle     .L5						;
        mov     rax, QWORD PTR [rbp-16]	;
        add     rax, 1					;
        lea     rdx, [0+rax*8]			;
        mov     rax, QWORD PTR [rbp-24]	;
        add     rdx, rax				;
        mov     rax, QWORD PTR [rbp-16]	;
        lea     rcx, [0+rax*8]			;
        mov     rax, QWORD PTR [rbp-24]	;
        add     rax, rcx				;
        mov     rsi, rdx				;
        mov     rdi, rax				;
        call    swap					;
.L5:
        add     QWORD PTR [rbp-16], 1	;
.L4:
        mov     rax, QWORD PTR [rbp-32]	;
        sub     rax, QWORD PTR [rbp-8]	;
        sub     rax, 1					;
        cmp     QWORD PTR [rbp-16], rax	;
        jb      .L6						;
        add     QWORD PTR [rbp-8], 1	;
.L3:
        mov     rax, QWORD PTR [rbp-32]	;
        sub     rax, 1					;
        cmp     QWORD PTR [rbp-8], rax	;
        jb      .L7						;
        nop								;
        nop								;
        leave							;
        ret								;
.LC0:
        .string "r"						;
.LC1:
        .string "test.txt"				;
.LC2:
        .string "%llu"					;
.LC4:
        .string "%Lf\n"					;
main:
        push    rbp						;
        mov     rbp, rsp				;
        sub     rsp, 80					;
        mov     rax, QWORD PTR stdin[rip]	;
        mov     rdx, rax					;
        mov     esi, OFFSET FLAT:.LC0		;
        mov     edi, OFFSET FLAT:.LC1		;
        call    freopen						;
        mov     QWORD PTR [rbp-16], rax		;
        lea     rdx, [rbp-56]				;
        mov     rax, QWORD PTR [rbp-16]		;
        mov     esi, OFFSET FLAT:.LC2		;
        mov     rdi, rax					;
        mov     eax, 0						;
        call    __isoc99_fscanf				;
        mov     rax, QWORD PTR [rbp-56]		;
        sal     rax, 3						;
        mov     rdi, rax					;
        call    malloc						;
        mov     QWORD PTR [rbp-24], rax		;
        mov     QWORD PTR [rbp-8], 0		;
        jmp     .L9							;
.L10:
        mov     rax, QWORD PTR [rbp-8]		;
        lea     rdx, [0+rax*8]				;
        mov     rax, QWORD PTR [rbp-24]		;
        add     rdx, rax					;
        mov     rax, QWORD PTR [rbp-16]		;
        mov     esi, OFFSET FLAT:.LC2		;
        mov     rdi, rax					;
        mov     eax, 0						;
        call    __isoc99_fscanf				;
        add     QWORD PTR [rbp-8], 1		;
.L9:
        mov     rax, QWORD PTR [rbp-56]		;
        cmp     QWORD PTR [rbp-8], rax		;
        jb      .L10						;
        rdtsc								;
        sal     rdx, 32						;
        or      rax, rdx					;
        mov     QWORD PTR [rbp-32], rax		;
        mov     eax, 2500000000				;
        mov     QWORD PTR [rbp-40], rax		;
        mov     rdx, QWORD PTR [rbp-56]		;
        mov     rax, QWORD PTR [rbp-24]		;
        mov     rsi, rdx					;
        mov     rdi, rax					;
        call    BubbleSort					;
        mov     rax, QWORD PTR [rbp-24]		;
        mov     rdi, rax					;
        call    free						;
        rdtsc								;
        sal     rdx, 32						;
        or      rax, rdx					;
        mov     QWORD PTR [rbp-48], rax		;
        mov     rax, QWORD PTR [rbp-48]		;
        sub     rax, QWORD PTR [rbp-32]		;
        mov     QWORD PTR [rbp-72], rax		;
        fild    QWORD PTR [rbp-72]			;
        test    rax, rax					;
        jns     .L13						;
        fld     TBYTE PTR .LC3[rip]			;
        faddp   st(1), st					;
.L13:
        fild    QWORD PTR [rbp-40]			;
        fdivp   st(1), st					;
        lea     rsp, [rsp-16]				;
        fstp    TBYTE PTR [rsp]				;
        mov     edi, OFFSET FLAT:.LC4		;
        mov     eax, 0						;
        call    printf						;
        add     rsp, 16						;
        mov     eax, 0						;
        leave								;
        ret									;
.LC3:
        .long   0							;
        .long   -2147483648					;
        .long   16447						;
        .long   0							;