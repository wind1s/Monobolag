onerror {resume}
quietly WaveActivateNextPane {} 0

vcom "+acc" ../UARTProgrammer.vhd ../../leddriver.vhd
vcom "+acc" ../UARTProgrammer_tb.vhd
vsim UARTProgrammer_tb

add wave -noupdate -divider UARTPorts
add wave -noupdate /UARTProgrammer_tb/uart/clk
add wave -noupdate /UARTProgrammer_tb/uart/rst
add wave -noupdate /UARTProgrammer_tb/uart/rx
add wave -noupdate /UARTProgrammer_tb/uart/StartCPU
add wave -noupdate /UARTProgrammer_tb/uart/UARTData
add wave -noupdate -radix unsigned /UARTProgrammer_tb/uart/UARTAddress
add wave -noupdate /UARTProgrammer_tb/uart/UARTWriteEnable


add wave -noupdate -divider UARTInternal
add wave -noupdate /UARTProgrammer_tb/uart/sreg
add wave -noupdate -radix unsigned /UARTProgrammer_tb/uart/pos
add wave -noupdate /UARTProgrammer_tb/uart/we
add wave -noupdate /UARTProgrammer_tb/uart/Data
add wave -noupdate -radix unsigned /UARTProgrammer_tb/uart/Address
add wave -noupdate /UARTProgrammer_tb/uart/rx1
add wave -noupdate /UARTProgrammer_tb/uart/rx2
add wave -noupdate /UARTProgrammer_tb/uart/ce_styr
add wave -noupdate /UARTProgrammer_tb/uart/sp
add wave -noupdate /UARTProgrammer_tb/uart/lp
add wave -noupdate -radix unsigned /UARTProgrammer_tb/uart/clock
add wave -noupdate -radix unsigned /UARTProgrammer_tb/uart/bit_counter

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
run 5000 us