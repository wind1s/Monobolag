start:
    nop
    ;jmp end_game
game_loop:
    call runs_left_mode
    mov r8, [current_player]
    add r8, 31
    mov [VRAM_START + 4169], r8

    call print_player_wallets
    call player_turn
    jmp game_loop

end_game:
    call print_game_over
    halt

player_turn:
    push r9
    push r10
    mov r9, [current_player]
    ; check player_active, inc player if player is inactive
    clr r10
    cmp r10, [player_active + r9]
    pop r10
    jeq end_of_round
    ; check if the only active player
    mov r10, [active_count]
    cmp r10, 1
    jne no_win
    call print_player_won
    jmp end_game
no_win:
    ; dice throw
    call clearMsgBox
    call print_throw_dice
    call dice_throw
    mov r0, r8
    call print_dice_result
    ; move player
    mov r0, r8
    mov r1, r9
    call move_player_piece

    ; try print price and rent
    mov r2, [player_board_pos + r9]
    mov r6, [board_type + r2]

    mov r1, [bench_rent + r6]
    mov r0, RENT_MSG
    call print_number
    ; print price
    mov r0, PRICE_MSG
    mov r1, [bench_price + r6]
    call print_number

    ; give money if passed go-tile
    mov r0, [current_player]
    call give_money_go

    ; init buy routine
    mov r2, [player_board_pos + r9]
    mov r0, [board_type + r2]
    mov r1, r9
    call try_buy

end_of_round:
    ; go to next player
    inc r9
    and r9, 3
    mov [current_player], r9
    pop r9
    ret

; r0 = steps to move, r1 = current_player
move_player_piece:
    push r9
    push r10
    mov r10, 1
    mov r8, r0
    mov r9, r1
    
    add r8, [player_board_pos + r9]
    cmp r8, SPELPLANER
    jlt no_wrap
    add [player_money_go + r1], r10
    sub r8, SPELPLANER
no_wrap:
    mov [player_board_pos + r9], r8

    mov r0, r9
    mov r1, [x_coords + r8]
    add r1, [player_x_offset + r9]
    mov r2, [y_coords + r8]
    add r2, [player_y_offset + r9]
    call move_sprite

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

runs_left_mode:
    push r11
    push r10
    push r9
    ; check runs_left, and decrease.
    mov r9, [runs_left]
    cmp r9, 0
    jeq end_game
    mov r11, [current_player]
    ; if current_player == 3, decrease
    cmp r11, 3
    jne no_decrement
    dec r9
    mov [runs_left], r9
no_decrement:
    ; print
    call print_runs_left
    pop r9
    pop r10
    pop r11
    ret

key_release:
    push r15
release_loop:
    mov r15, [KBDAddress]
    and r15, 0x10
    jne release_loop
    pop r15
    ret

; Waits for player to throw the dice with D key.
dice_throw:
    push r9
    ; wait for button to be released.
    call key_release
    mov r8, 6
throw_loop:
    ; inc dice result until player presses D button.
    dec r8
    movz r8, 6 
    mov r9, [KBDAddress]
    cmp r9, 0x1D
    jne throw_loop
    pop r9
    ret

; r0 = current_player
move_sprite:
    mul r0, 2
    mov [SPRITE_1X + r0], r1
    mov [SPRITE_1Y + r0], r2
    ret

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

    push r0
    call clear_number
    pop r10

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

; start of buy routine
; r0 = board_type of current_player board pos
; r1 = current_player
try_buy: 
    push r8
    push r9
    push r12
    push r14
    push r15
    ; If park bench
    cmp r0, 0
    jeq done_buy
    ; if go-tile
    cmp r0, 9
    jeq done_buy
    ; If lot_owner == current_player
    mov r8, [player_board_pos + r1]
    cmp [lot_owner + r8], r1
    jeq done_buy
    ; If lot_owner == empty
    mov r9, 4
    cmp [lot_owner + r8], r9
    jne pay_owner    
    ; print
    call clearMsgBox
    call print_buy
    ; input-loop for buy
    call key_release
buy_loop:
    ; if 0: skip
    mov r9, [KBDAddress]
    cmp r9, 0x10
    jeq done_buy
    ; if 1: change owner
    cmp r9, 0x11
    jne buy_loop
    ; check if player has enough money, -1 because index conflict
    mov r9, [beer_price + r0 - 1]
    cmp [player_wallets + r1], r9
    ; jump if not enough money
    jlt player_lost
    ; player_wallet - price
    sub [player_wallets + r1], r9
    ; change owner
    mov [lot_owner + r8], r1
    mov r0, r1
    call draw_lot
    jmp done_buy
pay_owner:
    ; if player is inactive, skip pay
    clr r15
    mov r14, [lot_owner + r8]
    cmp [player_active + r14], r15
    jeq done_buy
    ; Get the rent of current lot
    mov r9, [beer_rent + r0 - 1]
    ; player_wallet - rent
    cmp [player_wallets + r1], r9
    ; jump if not enough money
    jlt pay_owner_remaining
    sub [player_wallets + r1], r9
    ; give lot_owner rent
    push r10
    mov r10, [lot_owner + r8]
    add [player_wallets + r10], r9
    pop r10
    jmp done_buy

; assume we get to player_lost, because set current_player wallet to 0
pay_owner_remaining:
    push r10
    push r11
    ; get lot_owner
    mov r10, [lot_owner + r8]
    ; get remaining money from current_player
    mov r11, [player_wallets + r1]
    ; add money to lot_owner
    add [player_wallets + r10], r11
    pop r11
    pop r10

player_lost:
    clr r9
    mov [player_wallets + r1], r9
    mov [player_active + r1], r9
    mov r9, -1
    add [active_count], r9
    mov r0, [current_player]
    call print_player_lost

done_buy:
    pop r15
    pop r14
    pop r12
    pop r9
    pop r8
    ret

; Function for drawing the house on the current board_pos
; r0 = current_player
draw_lot:
    push r9
    push r10
    push r11
    push r12
    ; Get player board pos
    mov r9, [player_board_pos + r0]
    ; Get lot pos
    mov r10, [lot_icon_pos + r9]
    ; Get which lot_icon
    mov r11, [board_type + r9]
    mov r12, [lot_icon + r11]
    ; top-left
    mov [VRAM_START + r10], r12
    ; top-right
    inc r12
    mov [VRAM_START + r10 + 1], r12
    ; bottom-left
    inc r12
    mov [VRAM_START + r10 + 80], r12
    ; bottom-right
    inc r12 
    mov [VRAM_START + r10 + 81], r12
    pop r12
    pop r11
    pop r10
    pop r9
    ret
; end of buy routine

; r0 = current_player
give_money_go:
    push r10
    push r11
    push r12
    mov r11, 1
    clr r10
    ; Allow money?
    cmp r10, [player_money_go + r0]
    jeq money_go_done
    ; have we passed go?
    mov r12, GO_LOT
    cmp [player_board_pos + r0], r12
    jlt money_go_done
    mov r10, MONEY_GO
    ; Give money to current_player
    add [player_wallets + r0], r10
    sub [player_money_go + r0], r11
money_go_done:
    pop r12
    pop r11
    pop r10
    ret

; Print routines
clearMsgBox:
    push r15
    push r11
    clr r11
    clr r15
clearLoop:
    mov [VRAM_START + MESSAGE_START + r11], r15
    inc r11
    cmp r11, 37
    jne clearLoop
    pop r11
    pop r15
    ret

print_runs_left:
    mov r0, RUNS_LEFT_MSG
    mov r1, [runs_left]
    call print_number
    ret

print_throw_dice:
    push r8
    mov r8, [dice_message]
    mov [VRAM_START + MESSAGE_START], r8
    mov r8, [dice_message + 1]
    mov [VRAM_START + MESSAGE_START + 1], r8
    mov r8, [dice_message + 2]
    mov [VRAM_START + MESSAGE_START + 2], r8
    mov r8, [dice_message + 3]
    mov [VRAM_START + MESSAGE_START + 3], r8
    mov r8, [dice_message + 4]
    mov [VRAM_START + MESSAGE_START + 4], r8
    mov r8, [dice_message + 5]
    mov [VRAM_START + MESSAGE_START + 5], r8
    mov r8, [dice_message + 6]
    mov [VRAM_START + MESSAGE_START + 6], r8
    mov r8, [dice_message + 7]
    mov [VRAM_START + MESSAGE_START + 7], r8
    mov r8, [dice_message + 8]
    mov [VRAM_START + MESSAGE_START + 8], r8
    mov r8, [dice_message + 9]
    mov [VRAM_START + MESSAGE_START + 9], r8
    mov r8, [dice_message + 10]
    mov [VRAM_START + MESSAGE_START + 10], r8
    mov r8, [dice_message + 11]
    mov [VRAM_START + MESSAGE_START + 11], r8
    mov r8, [dice_message + 12]
    mov [VRAM_START + MESSAGE_START + 12], r8
    mov r8, [dice_message + 13]
    mov [VRAM_START + MESSAGE_START + 13], r8
    mov r8, [dice_message + 14]
    mov [VRAM_START + MESSAGE_START + 14], r8
    mov r8, [dice_message + 15]
    mov [VRAM_START + MESSAGE_START + 15], r8
    mov r8, [dice_message + 16]
    mov [VRAM_START + MESSAGE_START + 16], r8
    mov r8, [dice_message + 17]
    mov [VRAM_START + MESSAGE_START + 17], r8
    mov r8, [dice_message + 18]
    mov [VRAM_START + MESSAGE_START + 18], r8
    mov r8, [dice_message + 19]
    mov [VRAM_START + MESSAGE_START + 19], r8
    mov r8, [dice_message + 20]
    mov [VRAM_START + MESSAGE_START + 20], r8
    pop r8
    ret

; r0 = dice result
print_dice_result:
    add r0, 30
    mov [VRAM_START + DICE_RESULT], r0
    ret

print_buy:
    push r8    
    mov r8, [buy_message]
    mov [VRAM_START + MESSAGE_START], r8
    mov r8, [buy_message + 1]
    mov [VRAM_START + MESSAGE_START + 1], r8
    mov r8, [buy_message + 2]
    mov [VRAM_START + MESSAGE_START + 2], r8
    mov r8, [buy_message + 3]
    mov [VRAM_START + MESSAGE_START + 3], r8
    mov r8, [buy_message + 4]
    mov [VRAM_START + MESSAGE_START + 4], r8
    mov r8, [buy_message + 5]
    mov [VRAM_START + MESSAGE_START + 5], r8
    mov r8, [buy_message + 6]
    mov [VRAM_START + MESSAGE_START + 6], r8
    mov r8, [buy_message + 7]
    mov [VRAM_START + MESSAGE_START + 7], r8
    mov r8, [buy_message + 8]
    mov [VRAM_START + MESSAGE_START + 8], r8
    mov r8, [buy_message + 9]
    mov [VRAM_START + MESSAGE_START + 9], r8
    mov r8, [buy_message + 10]
    mov [VRAM_START + MESSAGE_START + 10], r8
    mov r8, [buy_message + 11]
    mov [VRAM_START + MESSAGE_START + 11], r8
    mov r8, [buy_message + 12]
    mov [VRAM_START + MESSAGE_START + 12], r8
    mov r8, [buy_message + 13]
    mov [VRAM_START + MESSAGE_START + 13], r8
    mov r8, [buy_message + 14]
    mov [VRAM_START + MESSAGE_START + 14], r8
    mov r8, [buy_message + 15]
    mov [VRAM_START + MESSAGE_START + 15], r8
    mov r8, [buy_message + 16]
    mov [VRAM_START + MESSAGE_START + 16], r8
    mov r8, [buy_message + 17]
    mov [VRAM_START + MESSAGE_START + 17], r8
    mov r8, [buy_message + 18]
    mov [VRAM_START + MESSAGE_START + 18], r8
    mov r8, [buy_message + 19]
    mov [VRAM_START + MESSAGE_START + 19], r8
    mov r8, [buy_message + 20]
    mov [VRAM_START + MESSAGE_START + 20], r8
    mov r8, [buy_message + 21]
    mov [VRAM_START + MESSAGE_START + 21], r8
    mov r8, [buy_message + 22]
    mov [VRAM_START + MESSAGE_START + 22], r8
    mov r8, [buy_message + 23]
    mov [VRAM_START + MESSAGE_START + 23], r8
    mov r8, [buy_message + 24]
    mov [VRAM_START + MESSAGE_START + 24], r8
    mov r8, [buy_message + 25]
    mov [VRAM_START + MESSAGE_START + 25], r8
    mov r8, [buy_message + 26]
    mov [VRAM_START + MESSAGE_START + 26], r8
    mov r8, [buy_message + 27]
    mov [VRAM_START + MESSAGE_START + 27], r8
    mov r8, [buy_message + 28]
    mov [VRAM_START + MESSAGE_START + 28], r8
    mov r8, [buy_message + 29]
    mov [VRAM_START + MESSAGE_START + 29], r8
    mov r8, [buy_message + 30]
    mov [VRAM_START + MESSAGE_START + 30], r8
    pop r8
    ret

; r0 = current_player
print_player_lost:
    push r8
    push r9
    mov r9, [player_money_pos + r0]
    mov r8, [lost_message]
    mov [VRAM_START + r9 + 11], r8
    mov r8, [lost_message + 1]
    mov [VRAM_START + r9 + 12], r8
    mov r8, [lost_message + 2]
    mov [VRAM_START + r9 + 13], r8
    mov r8, [lost_message + 3]
    mov [VRAM_START + r9 + 14], r8
    mov r8, [lost_message + 4]
    mov [VRAM_START + r9 + 15], r8
    mov r8, [lost_message + 5]
    mov [VRAM_START + r9 + 16], r8
    mov r8, [lost_message + 6]
    mov [VRAM_START + r9 + 17], r8
    mov r8, [lost_message + 7]
    mov [VRAM_START + r9 + 18], r8
    mov r8, [lost_message + 8]
    mov [VRAM_START + r9 + 19], r8
    pop r9
    pop r8
    ret

print_player_won:
    push r8
    mov r8, [win_message]
    mov [VRAM_START + WIN_MSG], r8
    mov r8, [win_message + 1]
    mov [VRAM_START + WIN_MSG + 1], r8
    mov r8, [win_message + 2]
    mov [VRAM_START + WIN_MSG + 2], r8
    mov r8, [win_message + 3]
    mov [VRAM_START + WIN_MSG + 3], r8
    mov r8, [win_message + 4]
    mov [VRAM_START + WIN_MSG + 4], r8
    mov r8, [win_message + 5]
    mov [VRAM_START + WIN_MSG + 5], r8
    mov r8, [win_message + 6]
    mov [VRAM_START + WIN_MSG + 6], r8

    mov r8, [current_player]
    add r8, 31
    mov [VRAM_START + WIN_MSG + 7], r8

    mov r8, [win_message + 6]
    mov [VRAM_START + WIN_MSG + 8], r8
    mov r8, [win_message + 7]
    mov [VRAM_START + WIN_MSG + 9], r8
    mov r8, [win_message + 8]
    mov [VRAM_START + WIN_MSG + 10], r8
    mov r8, [win_message + 9]
    mov [VRAM_START + WIN_MSG + 11], r8

    pop r8
    ret

print_game_over:
    push r8
    mov r8, [game_over_message]
    mov [VRAM_START + GAME_OVER_MSG], r8
    mov r8, [game_over_message + 1]
    mov [VRAM_START + GAME_OVER_MSG + 1], r8
    mov r8, [game_over_message + 2]
    mov [VRAM_START + GAME_OVER_MSG + 2], r8
    mov r8, [game_over_message + 3]
    mov [VRAM_START + GAME_OVER_MSG + 3], r8
    mov r8, [game_over_message + 4]
    mov [VRAM_START + GAME_OVER_MSG + 4], r8
    mov r8, [game_over_message + 5]
    mov [VRAM_START + GAME_OVER_MSG + 5], r8
    mov r8, [game_over_message + 6]
    mov [VRAM_START + GAME_OVER_MSG + 6], r8
    mov r8, [game_over_message + 7]
    mov [VRAM_START + GAME_OVER_MSG + 7], r8
    mov r8, [game_over_message + 8]
    mov [VRAM_START + GAME_OVER_MSG + 8], r8

    pop r8
    ret