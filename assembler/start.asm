; r0 = number to divide
div_10:
    clr r8
    cmp r0, 10
    jge subtract_loop
    ret
subtract_loop:
    inc r8
    sub r0, 10
    cmp r0, 10
    jge subtract_loop
    ret

; r0 = vram offset
clear_number:
    clr r8
    add r0, VRAM_START
    mov [r0 + 4], r8
    mov [r0 + 3], r8
    mov [r0 + 2], r8
    mov [r0 + 1], r8
    mov [r0], r8
    ret


; ful subrutin
get_tile_digit:
    mov r9, r8
    mul r9, 10
    sub r11, r9
    add r11, 30
    ret

; r0 = vram offset, r1 = number
print_number:
    push r9
    push r10
    push r11
    mov r10, r0

    mov r11, r1
    mov r0, r1
    call div_10
    call get_tile_digit
    mov [VRAM_START + r10 + 4], r11

    mov r11, r8
    mov r0, r8
    call div_10
    call get_tile_digit
    mov [VRAM_START + r10 + 3], r11

    mov r11, r8
    mov r0, r8
    call div_10
    call get_tile_digit
    mov [VRAM_START + r10 + 2], r11

    mov r11, r8
    mov r0, r8
    call div_10
    call get_tile_digit
    mov [VRAM_START + r10 + 1], r11

    mov r11, r8
    mov r0, r8
    call div_10
    call get_tile_digit
    mov [VRAM_START + r10], r11

    pop r11
    pop r10
    pop r9
    ret

print_player_wallets:
    mov r0, [player_money_pos]
    mov r1, [player_wallets]
    call print_number

    mov r0, [player_money_pos + 1]
    mov r1, [player_wallets + 1]
    call print_number

    mov r0, [player_money_pos + 2]
    mov r1, [player_wallets + 2]
    call print_number

    mov r0, [player_money_pos + 3]
    mov r1, [player_wallets + 3]
    call print_number
    ret

start:
    call print_player_wallets

    jmp start
