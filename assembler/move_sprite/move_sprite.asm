move_sprite:
    mul r0, 2
    mov [SPRITE_1X + r0], r1
    mov [SPRITE_1Y + r0], r2
    ret

get_key:
    mov r8, [KBDAddress]
    mov r9, 0b10000
    and r9, r8
    jeq get_key
    and r8, 0b1111
    ret

delay:
    mov r8, 0x1fff
delay_loop:
    dec r8
    jne delay_loop
    ret

start:
    clr r14
    clr r15
move_loop:
    call get_key
    cmp r8, 2
    jeq dec_y
    cmp r8, 4
    jeq dec_x
    cmp r8, 6
    jeq inc_x
    cmp r8, 8
    jne move_loop
inc_y:
    inc r15
    jmp done_move
inc_x:
    inc r14
    jmp done_move
dec_x:
    dec r14
    jmp done_move
dec_y:
    dec r15
    jmp done_move

done_move:
    call delay
    clr r0
    mov r1, r14
    mov r2, r15
    call move_sprite
    jmp move_loop