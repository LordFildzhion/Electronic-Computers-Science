swap:
        mov     rax, QWORD PTR [rdi]  ; Сохраняем значение из адреса, на который указывает rdi, в rax
        mov     rdx, QWORD PTR [rsi]  ; Сохраняем значение из адреса, на который указывает rsi, в rdx
        mov     QWORD PTR [rdi], rdx   ; Записываем значение из rdx по адресу rdi
        mov     QWORD PTR [rsi], rax   ; Записываем значение из rax по адресу rsi
        ret                             ; Возврат из функции

BubbleSort:
        cmp     rsi, 1                 ; Сравниваем количество элементов (rsi) с 1
        je      .L3                    ; Если элементов меньше или равно 1, выходим
        lea     r8, [rdi-8+rsi*8]     ; Вычисляем адрес конца массива для сортировки
.L7:
        mov     rax, rdi               ; Устанавливаем указатель на начало массива
.L6:
        movdqu  xmm0, XMMWORD PTR [rax] ; Загружаем 128 бит (16 байт) из массива в xmm0
        movhlps xmm1, xmm0             ; Перемещаем верхние 64 бита xmm0 в xmm1
        movq    rdx, xmm0              ; Копируем младшие 64 бита в rdx
        movq    rcx, xmm1              ; Копируем старшие 64 бита в rcx
        cmp     rcx, rdx               ; Сравниваем два значения
        jge     .L5                    ; Если старшее значение больше или равно младшему, продолжаем
        shufpd  xmm0, xmm0, 1          ; Меняем местами старшие и младшие 64 бита в xmm0
        movups  XMMWORD PTR [rax], xmm0 ; Записываем обратно в массив
.L5:
        add     rax, 8                 ; Переходим к следующему элементу (8 байт)
        cmp     rax, r8                 ; Проверяем, достигли ли конца массива
        jne     .L6                    ; Если нет, продолжаем сортировку
        sub     rsi, 1                 ; Уменьшаем количество элементов для следующей итерации
        sub     r8, 8                  ; Уменьшаем адрес конца массива на 8 байт
        cmp     rsi, 1                 ; Проверяем количество оставшихся элементов
        jne     .L7                    ; Если больше 1, продолжаем сортировку
.L3:
        ret                             ; Возврат из функции

.LC0:
        .string "r"                    ; Строка для режима открытия файла (чтение)
.LC1:
        .string "test.txt"             ; Имя файла для открытия
.LC2:
        .string "%llu"                 ; Формат для считывания беззнакового длинного целого числа

main:
        push    r14                    ; Сохраняем регистр r14 на стек
        mov     esi, OFFSET FLAT:.LC0  ; Загружаем адрес строки формата в esi
        mov     edi, OFFSET FLAT:.LC1   ; Загружаем адрес имени файла в edi
        push    r13                    ; Сохраняем регистр r13 на стек
        push    r12                    ; Сохраняем регистр r12 на стек
        push    rbp                    ; Сохраняем базовый указатель на стек
        push    rbx                    ; Сохраняем регистр rbx на стек
        sub     rsp, 16                ; Выделяем место на стеке
        mov     rdx, QWORD PTR stdin[rip] ; Получаем указатель на стандартный ввод
        call    freopen                ; Открываем файл с указанным именем для чтения
        lea     rdx, [rsp+8]           ; Загружаем адрес для хранения данных из файла
        mov     esi, OFFSET FLAT:.LC2   ; Загружаем адрес формата для считывания данных в esi
        mov     rdi, rax               ; Загружаем возвращаемый указатель на файл в rdi
        mov     r13, rax               ; Сохраняем указатель на файл в r13
        xor     eax, eax                ; Обнуляем eax для вызова функции fscanf
        call    __isoc99_fscanf         ; Читаем количество элементов из файла
        mov     r12, QWORD PTR [rsp+8]  ; Загружаем количество считанных элементов в r12
        lea     rdi, [0+r12*8]          ; Вычисляем размер памяти для массива (количество * размер элемента)
        call    malloc                  ; Выделяем память под массив и сохраняем указатель в r14
        mov     r14, rax                ; Сохраняем указатель на выделенную память в r14
        test    r12, r12                ; Проверяем, было ли что-то считано
        je      .L14                    ; Если нет элементов, переходим к завершению

        mov     rbp, rax                ; Устанавливаем указатель на начало массива в rbp
        xor     ebx, ebx                ; Обнуляем счетчик элементов

.L15:
        mov     rdx, rbp                ; Устанавливаем указатель на текущую позицию в массиве (rbp)
        mov     esi, OFFSET FLAT:.LC2   ; Загружаем адрес формата для считывания данных в esi
        mov     rdi, r13                ; Загружаем указатель на файл в rdi
        xor     eax, eax                ; Обнуляем eax для вызова функции fscanf
        call    __isoc99_fscanf         ; Читаем очередное значение из файла в массив
        mov     r12, QWORD PTR [rsp+8]  ; Обновляем количество считанных элементов
        add     rbx, 1                  ; Увеличиваем счетчик считанных элементов
        add     rbp, 8                  ; Переходим к следующему элементу в массиве (8 байт)
        cmp     rbx, r12                ; Сравниваем счетчик с количеством считанных элементов
        jb      .L15                    ; Если счетчик меньше количества элементов, продолжаем чтение

.L14:
        mov     rsi, r12                ; Устанавливаем количество элементов для сортировки в rsi
        mov     rdi, r14                ; Устанавливаем указатель на массив в rdi
        call    BubbleSort              ; Вызываем функцию сортировки пузырьком

        call    free                    ; Освобождаем выделенную память под массив

        add     rsp, 16                 ; Восстанавливаем стек после выделения памяти
        xor     eax, eax                ; Обнуляем eax перед выходом из main

        pop     rbx                    ; Восстанавливаем регистр rbx из стека
        pop     rbp                    ; Восстанавливаем базовый указатель из стека
        pop     r12                    ; Восстанавливаем регистр r12 из стека
        pop     r13                    ; Восстанавливаем регистр r13 из стека
        pop     r14                    ; Восстанавливаем регистр r14 из стека

        ret                             ; Возврат из функции main