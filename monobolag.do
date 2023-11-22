onerror {resume}
quietly WaveActivateNextPane {} 0


vcom "+acc" ../monobolag.vhd ../spriteTable.vhd ../VGA/VIDEO_RAM.vhd ../VGA/VGA-MOTOR/PIX.vhd ../VGA/VGA-MOTOR/SPRITES.vhd ../VGA/VGA-MOTOR/TILE_ROM.vhd ../VGA/VGA-MOTOR/VGA_MOTOR.vhd ../UARTProgrammer/UARTProgrammer.vhd ../HEX/PmodKYPD.vhd ../CPU/uprogCPU/ALU.vhd ../CPU/uprogCPU/DM.vhd ../CPU/uprogCPU/K1.vhd ../CPU/uprogCPU/K2.vhd ../CPU/uprogCPU/K3.vhd ../CPU/uprogCPU/LUT_RAM.vhd ../CPU/uprogCPU/MMU.vhd ../CPU/uprogCPU/PM.vhd ../CPU/uprogCPU/regTable.vhd ../CPU/uprogCPU/Stack.vhd ../CPU/uprogCPU/uMem.vhd ../CPU/uprogCPU/uprogCPU.vhd

add wave -noupdate -divider monobolag
add wave -noupdate /lab_tb/clk
add wave -noupdate /lab_tb/rst
add wave -noupdate /lab_tb/rx
add wave -noupdate /lab_tb/seg
add wave -noupdate /lab_tb/an
add wave -noupdate -divider lab
add wave -noupdate /lab_tb/uut/clk
add wave -noupdate /lab_tb/uut/rst
add wave -noupdate /lab_tb/uut/rx
add wave -noupdate -radix unsigned /lab_tb/uut/pos
add wave -noupdate -radix hexadecimal /lab_tb/uut/tal
add wave -noupdate -divider UART_Bootloader
add wave -noupdate -divider CPU
add wave -noupdate -divider VGA
add wave -noupdate -divider HEX_keyboard

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {88676 ns} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ns} {525 us}
