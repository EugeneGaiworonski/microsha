Вот 10 уроков по ассемблеру Intel 8080 от простого к сложному, с примерами программ. Все примеры написаны в синтаксисе, совместимом с эмуляторами i8080 (например, i8080emu или cpm80).
📘 Урок 1: Основы i8080 — Регистры и MOV
Тема:

    Регистры: A, B, C, D, E, H, L
    Команда MOV

Пример:

    MVI B, 05H     ; B = 5
    MVI C, 0AH     ; C = 10
    MOV A, B       ; A = B
    MOV D, C       ; D = C
    HLT            ; Останов

📘 Урок 2: Арифметика — ADD и SUB
Тема:

    Сложение (ADD)
    Вычитание (SUB)

Пример:

    MVI A, 07H     ; A = 7
    MVI B, 03H     ; B = 3
    ADD B          ; A = A + B = 10
    SUB B          ; A = A - B = 7
    HLT

📘 Урок 3: Работа с памятью — LXI, STA, LDA
Тема:

    Загрузка адреса (LXI)
    Сохранение в память (STA)
    Загрузка из памяти (LDA)

Пример:

    LXI H, 2000H   ; H:L = 2000H
    MVI M, 42H     ; [2000H] = 42H
    LDA 2000H      ; A = [2000H]
    HLT

📘 Урок 4: Условные переходы — JMP, JC, JZ
Тема:

    Безусловный переход (JMP)
    Переход при переносе (JC)
    Переход при нуле (JZ)

Пример:

    MVI A, 0FFH
    INR A          ; A = 0, флаг Z=1
    JZ zero_label
    JMP end_label

zero_label:
    MVI B, 01H

end_label:
    HLT

📘 Урок 5: Циклы — LOOP с помощью DCR и JNZ
Тема:

    Уменьшение (DCR)
    Условный переход (JNZ)

Пример:

    MVI B, 05H     ; Счетчик = 5
loop:
    DCR B          ; B = B - 1
    JNZ loop       ; Если B ≠ 0, продолжаем
    HLT

📘 Урок 6: Стек — PUSH, POP, SP
Тема:

    Работа со стеком
    Команды PUSH, POP
    Инициализация SP

Пример:

    LXI SP, 3000H  ; Установка стека
    MVI B, 11H
    MVI C, 22H
    PUSH B         ; Сохранить BC в стек
    POP D          ; Восстановить в DE
    HLT

📘 Урок 7: Вызов подпрограмм — CALL и RET
Тема:

    Вызов подпрограммы (CALL)
    Возврат (RET)

Пример:

    CALL square
    HLT

square:
    MVI A, 04H
    MOV B, A
    MUL B          ; A = A * B
    RET

⚠️ Примечание: MUL — это не команда 8080. В 8080 нет встроенной команды умножения. Это нужно реализовать вручную.
Реальный пример:

    MVI A, 04H
    MVI B, 04H
    CALL multiply
    HLT

multiply:
    PUSH B
    PUSH PSW
    MVI C, 00H     ; Результат
loop_mul:
    ADD B
    INR C
    JNZ loop_mul
    POP PSW
    POP B
    RET

📘 Урок 8: Прерывания и RST
Тема:

    Команда RST n
    Обработчики прерываний

Пример:

    MVI A, 03H
    RST 5          ; Переход к 0x0028
    HLT

    ORG 0028H      ; Обработчик RST 5
    PUSH PSW
    ; Действия
    POP PSW
    RET

📘 Урок 9: Ввод-вывод — IN и OUT
Тема:

    Команды IN, OUT для работы с портами

Пример:

    MVI A, 0FFH
    OUT 01H        ; Вывод в порт 01H
    IN 01H         ; Ввод из порта 01H
    HLT

📘 Урок 10: Простая программа — Вывод числа на экран
Тема:

    Преобразование числа в ASCII
    Вывод через порты или память

Пример (вывод числа 42):

    LXI SP, 3000H
    MVI A, 42
    CALL print_num
    HLT

print_num:
    PUSH PSW
    MVI B, 10
    MVI C, 0       ; Счетчик

convert_loop:
    INR C
    SUB B
    JNC convert_loop
    ADD B
    DCR C
    PUSH B
    PUSH PSW
    MVI A, '0'
    ADD C
    OUT 01H        ; Вывод символа
    POP PSW
    POP B
    RET

✅ Заключение

Эти уроки охватывают основы программирования на ассемблере i8080. Чтобы запустить код, используйте эмулятор:

    i8080emu
    cpm80
    Онлайн-эмулятор: https://schorn.ch/8080.php

Если нужно, я могу сгенерировать полные .asm файлы для каждой программы.


; ТЕСТ ВВОДА-ВЫВОДА НА ЛЕНТУ
    .project hellosha
    .tape microsha-rkm ; формат ленты RKM
        org 0
        mvi d, 10
rloop    mvi a, 08h
        call 0F806h
        mov c, a
        call 0F809h
        dcr d 
        mvi a,0
        cmp d
        jz end_rloop
        jmp rloop
end_rloop        
        mvi d, 10
        mvi e, 30h
wloop   mov c, e
        call 0F80Ch
        dcr d 
        mvi a,0
        cmp d
        inr e
        jz end_wloop
        jmp wloop
end_wloop        
        call 0F89Dh
