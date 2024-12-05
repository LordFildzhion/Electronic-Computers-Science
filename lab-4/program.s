swap:
        push    {r7}
        sub     sp, sp, #20
        add     r7, sp, #0
        str     r0, [r7, #4]
        str     r1, [r7]
        ldr     r3, [r7, #4]
        ldrd    r2, [r3]
        strd    r2, [r7, #8]
        ldr     r3, [r7]
        ldrd    r2, [r3]
        ldr     r1, [r7, #4]
        strd    r2, [r1]
        ldr     r1, [r7]
        ldrd    r2, [r7, #8]
        strd    r2, [r1]
        nop
        adds    r7, r7, #20
        mov     sp, r7
        ldr     r7, [sp], #4
        bx      lr
BubbleSort:
        push    {r7, lr}
        sub     sp, sp, #16
        add     r7, sp, #0
        str     r0, [r7, #4]
        str     r1, [r7]
        movs    r3, #0
        str     r3, [r7, #12]
        b       .L3
.L7:
        movs    r3, #0
        str     r3, [r7, #8]
        b       .L4
.L6:
        ldr     r3, [r7, #8]
        lsls    r3, r3, #3
        ldr     r2, [r7, #4]
        add     r3, r3, r2
        ldrd    r2, [r3]
        ldr     r1, [r7, #8]
        adds    r1, r1, #1
        lsls    r1, r1, #3
        ldr     r0, [r7, #4]
        add     r1, r1, r0
        ldrd    r0, [r1]
        cmp     r0, r2
        sbcs    r3, r1, r3
        bge     .L5
        ldr     r3, [r7, #8]
        lsls    r3, r3, #3
        ldr     r2, [r7, #4]
        adds    r0, r2, r3
        ldr     r3, [r7, #8]
        adds    r3, r3, #1
        lsls    r3, r3, #3
        ldr     r2, [r7, #4]
        add     r3, r3, r2
        mov     r1, r3
        bl      swap
.L5:
        ldr     r3, [r7, #8]
        adds    r3, r3, #1
        str     r3, [r7, #8]
.L4:
        ldr     r2, [r7]
        ldr     r3, [r7, #12]
        subs    r3, r2, r3
        subs    r3, r3, #1
        ldr     r2, [r7, #8]
        cmp     r2, r3
        bcc     .L6
        ldr     r3, [r7, #12]
        adds    r3, r3, #1
        str     r3, [r7, #12]
.L3:
        ldr     r3, [r7]
        subs    r3, r3, #1
        ldr     r2, [r7, #12]
        cmp     r2, r3
        bcc     .L7
        nop
        nop
        adds    r7, r7, #16
        mov     sp, r7
        pop     {r7, pc}
.LC0:
        .ascii  "r\000"
.LC1:
        .ascii  "test.txt\000"
.LC2:
        .ascii  "%llu\000"
main:
        push    {r7, lr}
        sub     sp, sp, #16
        add     r7, sp, #0
        movw    r3, #:lower16:stdin
        movt    r3, #:upper16:stdin
        ldr     r3, [r3]
        mov     r2, r3
        movw    r1, #:lower16:.LC0
        movt    r1, #:upper16:.LC0
        movw    r0, #:lower16:.LC1
        movt    r0, #:upper16:.LC1
        bl      freopen
        str     r0, [r7, #8]
        mov     r3, r7
        mov     r2, r3
        movw    r1, #:lower16:.LC2
        movt    r1, #:upper16:.LC2
        ldr     r0, [r7, #8]
        bl      __isoc99_fscanf
        ldr     r3, [r7]
        lsls    r3, r3, #3
        mov     r0, r3
        bl      malloc
        mov     r3, r0
        str     r3, [r7, #4]
        movs    r3, #0
        str     r3, [r7, #12]
        b       .L9
.L10:
        ldr     r3, [r7, #12]
        lsls    r3, r3, #3
        ldr     r2, [r7, #4]
        add     r3, r3, r2
        mov     r2, r3
        movw    r1, #:lower16:.LC2
        movt    r1, #:upper16:.LC2
        ldr     r0, [r7, #8]
        bl      __isoc99_fscanf
        ldr     r3, [r7, #12]
        adds    r3, r3, #1
        str     r3, [r7, #12]
.L9:
        ldr     r3, [r7]
        ldr     r2, [r7, #12]
        cmp     r2, r3
        bcc     .L10
        ldr     r3, [r7]
        mov     r1, r3
        ldr     r0, [r7, #4]
        bl      BubbleSort
        ldr     r0, [r7, #4]
        bl      free
        movs    r3, #0
        mov     r0, r3
        adds    r7, r7, #16
        mov     sp, r7
        pop     {r7, pc}
