onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider lab_tb
add wave -noupdate /lab_tb/clk
add wave -noupdate /lab_tb/rst
add wave -noupdate -radix unsigned /lab_tb/uut/pos
add wave -noupdate -radix hexadecimal /lab_tb/uut/tal
add wave -noupdate -divider VGA_MOTOR
add wave -noupdate -radix unsigned /VGA_tb/vga_comp/VGA_MOTOR/Hsync
add wave -noupdate -radix unsigned /VGA_tb/vga_comp/VGA_MOTOR/Vsync
add wave -noupdate -radix unsigned /VGA_tb/vga_comp/VGA_MOTOR/vgaBlue
add wave -noupdate -radix unsigned /VGA_tb/vga_comp/VGA_MOTOR/vgaRed
add wave -noupdate -radix unsigned /VGA_tb/vga_comp/VGA_MOTOR/vgaGreen

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

restart -f
run 1000000 us