; lab6_modos.asm
; Compilar: nasm -f bin lab6_modos.asm -o lab6_modos.com

org 100h

jmp inicio

; ===== DATOS =====

array     dw 10, 20, 30, 40, 50

nota1     dw 85
nota2     dw 73
promedio  dw 0

var_x     dw 0FFFFh

inicio:

; ===== MODO 1: INMEDIATO =====
    MOV ax, 100
    MOV bx, 0A5h
    ADD cx, 55
    AND dx, 00FFh

; ===== MODO 2: DIRECTO =====
    MOV ax, [var_x]
    MOV bx, [array]
    MOV cx, [nota1]

    MOV [var_x], word 0

; ===== MODO 3: INDIRECTO =====
    MOV si, nota1
    MOV ax, [si]

    MOV si, nota2
    MOV bx, [si]

    ADD ax, bx
    SHR ax, 1

    MOV si, promedio
    MOV [si], ax

; ===== MODO 4: INDEXADO =====

    ; acceso a array[2]
    MOV bx, array
    MOV si, 4
    MOV ax, [bx + si]

    ; suma del array
    XOR ax, ax
    MOV bx, array
    MOV cx, 5
    XOR si, si

bucle:
    ADD ax, [bx + si]
    ADD si, 2
    LOOP bucle
    ; AX = 150 (0096h)

; ===== EXTENSIÓN: INVERSO =====

    XOR ax, ax
    MOV bx, array
    MOV cx, 5
    MOV si, 8        ; último elemento (4*2)

bucle_inv:
    ADD ax, [bx + si]
    SUB si, 2
    LOOP bucle_inv
    ; AX = 150

; ===== FIN =====
    INT 20h