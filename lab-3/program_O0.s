swap:
        push    rbp                     ; Сохранение старого значения базового указателя
        mov     rbp, rsp                ; Установка текущего значения указателя стека в rbp
        mov     QWORD PTR [rbp-24], rdi ; Сохранение первого аргумента (указателя rdi)
        mov     QWORD PTR [rbp-32], rsi ; Сохранение второго аргумента (указателя rsi)
        
        ; Загружаем значение по адресу rdi
        mov     rax, QWORD PTR [rbp-24]
        mov     rax, QWORD PTR [rax]
        mov     QWORD PTR [rbp-8], rax  ; Сохраняем его во временной переменной

        ; Загружаем значение по адресу rsi
        mov     rax, QWORD PTR [rbp-32]
        mov     rdx, QWORD PTR [rax]

        ; Меняем местами значения
        mov     rax, QWORD PTR [rbp-24]
        mov     QWORD PTR [rax], rdx    ; Перемещаем значение из rsi в rdi
        mov     rax, QWORD PTR [rbp-32]
        mov     rdx, QWORD PTR [rbp-8]  ; Загружаем временно сохранённое значение
        mov     QWORD PTR [rax], rdx    ; Перемещаем его в rsi

        nop                             ; Нет операции (может быть использовано как выравнивание или задержка)
        pop     rbp                     ; Восстанавливаем старое значение базового указателя
        ret                             ; Возвращаемся к вызвавшей функции

BubbleSort:
        push    rbp                     ; Сохраняем старое значение базового указателя
        mov     rbp, rsp                ; Устанавливаем текущий стек
        sub     rsp, 32                 ; Выделяем место на стеке для локальных переменных

        ; Сохранение аргументов функции
        mov     QWORD PTR [rbp-24], rdi ; Сохраняем указатель на массив
        mov     QWORD PTR [rbp-32], rsi ; Сохраняем размер массива

        mov     QWORD PTR [rbp-8], 0    ; Сбрасываем индекс итерации внешнего цикла
        jmp     .L3                     ; Переход к условию внешнего цикла

.L7:
        mov     QWORD PTR [rbp-16], 0   ; Сбрасываем индекс внутреннего цикла
        jmp     .L4                     ; Переход к началу внутреннего цикла

.L6:
        mov     rax, QWORD PTR [rbp-16] ; Загружаем индекс внутреннего цикла
        lea     rdx, [0+rax*8]          ; Рассчитываем смещение первого элемента
        mov     rax, QWORD PTR [rbp-24] ; Загружаем адрес массива
        add     rax, rdx                ; Указываем на первый элемент
        mov     rdx, QWORD PTR [rax]    ; Загружаем значение первого элемента

        mov     rax, QWORD PTR [rbp-16] ; Загружаем индекс
        add     rax, 1                  ; Увеличиваем на 1
        lea     rcx, [0+rax*8]          ; Рассчитываем смещение второго элемента
        mov     rax, QWORD PTR [rbp-24] ; Загружаем адрес массива
        add     rax, rcx                ; Указываем на второй элемент
        mov     rax, QWORD PTR [rax]    ; Загружаем значение второго элемента

        cmp     rdx, rax                ; Сравниваем элементы
        jle     .L5                     ; Переход, если первый <= второго

        ; Меняем местами элементы, если они не в порядке
        mov     rax, QWORD PTR [rbp-16]
        add     rax, 1
        lea     rdx, [0+rax*8]
        mov     rax, QWORD PTR [rbp-24]
        add     rdx, rax
        mov     rax, QWORD PTR [rbp-16]
        lea     rcx, [0+rax*8]
        mov     rax, QWORD PTR [rbp-24]
        add     rax, rcx
        mov     rsi, rdx                ; Передаём указатели в функцию `swap`
        mov     rdi, rax
        call    swap                    ; Вызываем функцию для обмена значениями

.L5:
        add     QWORD PTR [rbp-16], 1   ; Увеличиваем индекс внутреннего цикла
.L4:
        mov     rax, QWORD PTR [rbp-32]
        sub     rax, QWORD PTR [rbp-8]
        sub     rax, 1                  ; Вычисляем количество оставшихся элементов
        cmp     QWORD PTR [rbp-16], rax ; Сравниваем индекс с количеством элементов
        jb      .L6                     ; Продолжаем внутренний цикл

        add     QWORD PTR [rbp-8], 1    ; Увеличиваем индекс внешнего цикла
.L3:
        mov     rax, QWORD PTR [rbp-32]
        sub     rax, 1
        cmp     QWORD PTR [rbp-8], rax  ; Проверяем, завершён ли внешний цикл
        jb      .L7                     ; Продолжаем внешний цикл

        nop                             ; Нет операции
        leave                          ; Восстанавливаем стек и базовый указатель
        ret                            ; Возвращаем управление
