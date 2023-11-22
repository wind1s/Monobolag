onerror {resume}
quietly WaveActivateNextPane {} 0

vcom "+acc" ../uprogCPU/ALU.vhd ../uprogCPU/K1.vhd ../uprogCPU/K2.vhd ../uprogCPU/K3.vhd ../uprogCPU/MMU.vhd ../uprogCPU/regTable.vhd ../uprogCPU/uMem.vhd ../uprogCPU/uprogCPU.vhd ../uprogCPU/CPU_test/PM.vhd ../uprogCPU/CPU_test/DM.vhd ../uprogCPU/CPU_test/Stack.vhd ../uprogCPU/MicroPC.vhd
vcom "+acc" ../uprogCPU/CPU_test/uprogCPU_tb.vhd
vsim uprogCPU_tb

add wave -noupdate -divider uprogTest_tb

add wave -noupdate /uprogCPU_tb/clk
add wave -noupdate /uprogCPU_tb/rst
add wave -noupdate /uprogCPU_tb/IOWriteEnable
add wave -noupdate -radix binary /uprogCPU_tb/IOChipSelect

add wave -noupdate /uprogCPU_tb/tb_running


add wave -noupdate -divider CPU

add wave -noupdate /uprogCPU_tb/cpu/UARTAddress
add wave -noupdate /uprogCPU_tb/cpu/UARTData
add wave -noupdate /uprogCPU_tb/cpu/DATA_BUS
add wave -noupdate /uprogCPU_tb/cpu/ADDR_BUS
add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/HR
add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/PC


add wave -noupdate -divider IR

add wave -noupdate /uprogCPU_tb/cpu/IR
add wave -noupdate -radix binary /uprogCPU_tb/cpu/OP
add wave -noupdate -radix binary /uprogCPU_tb/cpu/IR_Mod
add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/RdAddr
add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/RaAddr
add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/IR_Address
add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/IR_Konstant


add wave -noupdate -divider uMemory

add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/uPC
add wave -noupdate /uprogCPU_tb/cpu/uM
add wave -noupdate -radix binary /uprogCPU_tb/cpu/ALU_OP
add wave -noupdate -radix binary /uprogCPU_tb/cpu/TDB
add wave -noupdate -radix binary /uprogCPU_tb/cpu/FDB
add wave -noupdate -radix binary /uprogCPU_tb/cpu/TAB
add wave -noupdate -radix binary /uprogCPU_tb/cpu/P
add wave -noupdate -radix binary /uprogCPU_tb/cpu/SEQ
add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/uADR


add wave -noupdate -divider ALU

add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/AR
add wave -noupdate -radix binary /uprogCPU_tb/cpu/ALUComp/Operation
add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/ALUComp/A
add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/ALUComp/B
add wave -noupdate /uprogCPU_tb/cpu/ALUComp/IR_address
add wave -noupdate /uprogCPU_tb/cpu/ALUComp/Rx
add wave -noupdate /uprogCPU_tb/cpu/ALUComp/Z
add wave -noupdate /uprogCPU_tb/cpu/ALUComp/Zc
add wave -noupdate /uprogCPU_tb/cpu/ALUComp/N
add wave -noupdate /uprogCPU_tb/cpu/ALUComp/Nc
add wave -noupdate /uprogCPU_tb/cpu/ALUComp/C
add wave -noupdate /uprogCPU_tb/cpu/ALUComp/Cc
add wave -noupdate /uprogCPU_tb/cpu/ALUComp/V
add wave -noupdate /uprogCPU_tb/cpu/ALUComp/Vc


add wave -noupdate -divider RegisterTable

add wave -noupdate /uprogCPU_tb/cpu/RegisterTable/Modcode
add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/RegisterTable/RaAddress
add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/RegisterTable/RdAddress
add wave -noupdate /uprogCPU_tb/cpu/RegisterTable/RdWriteEnable
add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/RegisterTable/Rd
add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/RegisterTable/Rx
add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/RegisterTable/RaOut
add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/RegisterTable/RdOut


add wave -noupdate -divider MMU

add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/MMUComp/AddressOut
add wave -noupdate /uprogCPU_tb/cpu/MMUComp/DataOut
add wave -noupdate /uprogCPU_tb/cpu/MMUComp/DataIn
add wave -noupdate /uprogCPU_tb/cpu/MMUComp/DatabusIn
add wave -noupdate /uprogCPU_tb/cpu/MMUComp/DatabusOut
add wave -noupdate -radix unsigned /uprogCPU_tb/cpu/MMUComp/AddressBusIn
add wave -noupdate /uprogCPU_tb/cpu/MMUComp/WriteEnableOut
add wave -noupdate /uprogCPU_tb/cpu/MMUComp/WriteEnableIn
add wave -noupdate /uprogCPU_tb/cpu/MMUComp/StartCPU
add wave -noupdate /uprogCPU_tb/cpu/MMUComp/UARTAddress
add wave -noupdate /uprogCPU_tb/cpu/MMUComp/UARTData
add wave -noupdate -radix binary /uprogCPU_tb/cpu/MMUComp/ChipSelect
add wave -noupdate /uprogCPU_tb/cpu/MMUComp/CS_PM
add wave -noupdate /uprogCPU_tb/cpu/MMUComp/CS_DM
add wave -noupdate /uprogCPU_tb/cpu/MMUComp/CS_Stack
add wave -noupdate /uprogCPU_tb/cpu/MMUComp/CS_VR
add wave -noupdate /uprogCPU_tb/cpu/MMUComp/CS_KBD



TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {100 ns} 0}
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
WaveRestoreZoom {0 ns} {10 us}

restart -f
run 100 us