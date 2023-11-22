# Makefile for hardware implementation on Xilinx FPGAs and ASICs
# Author: Andreas Ehliar <ehliar@isy.liu.se>
# 
# T is the testbench file for this project
# S is the synthesizable sources for this project
# U is the UCF file
# PART is the part

# Important makefile targets:
# make lab.sim		GUI simulation
# make lab.simc		batch simulation
# make lab.synth	Synthesize
# make lab.route	Route the design
# make lab.bitgen	Generate bit file
# make lab.timing	Generate timing report
# make lab.clean	Use whenever you change settings in the Makefile!
# make lab.prog		Downloads the bitfile to the FPGA. NOTE: Does not
#                       rebuild bitfile if source files have changed!
# make clean            Removes all generated files for all projects. Also
#                       backup files (*~) are removed.
# 
# VIKTIG NOTERING: 	Om du ändrar vilka filer som finns med i projektet så måste du köra
#                  	make lab.clean
#
# Syntesrapporten ligger i lab-synthdir/xst/synth/design.syr
# Maprapporten (bra att kolla i för arearapportens skull) ligger i lab-synthdir/layoutdefault/design_map.mrp
# Timingrapporten (skapas av make lab.timing) ligger i lab-synthdir/layoutdefault/design.trw

# (Or proj2.simc, proj2.sim, etc, depending on the name of the
# project)

XILINX_INIT = source /opt/xilinx_ise/14.7/settings64.sh;
PART=xc6slx16-3-csg324


monobolag.%: S=monobolag.vhd spriteTable.vhd VGA/VIDEO_RAM.vhd VGA/VGA-MOTOR/PIX.vhd VGA/VGA-MOTOR/SPRITES.vhd VGA/VGA-MOTOR/TILE_ROM.vhd VGA/VGA-MOTOR/VGA_MOTOR.vhd UARTProgrammer/UARTProgrammer.vhd HEX/PmodKYPD.vhd CPU/uprogCPU/ALU.vhd CPU/uprogCPU/DM.vhd CPU/uprogCPU/K1.vhd CPU/uprogCPU/K2.vhd CPU/uprogCPU/K3.vhd CPU/uprogCPU/LUT_RAM.vhd CPU/uprogCPU/MMU.vhd CPU/uprogCPU/PM.vhd CPU/uprogCPU/regTable.vhd CPU/uprogCPU/Stack.vhd CPU/uprogCPU/uMem.vhd CPU/uprogCPU/uprogCPU.vhd CPU/uprogCPU/MicroPC.vhd
monobolag.%: T=monobolag_tb.vhd
monobolag.%: U=Nexys3_Master.ucf


# Det här är ett exempel på hur man kan skriva en testbänk som är
# relevant, även om man kör en simulering i batchläge (make batchlab.simc)
#batchlab.%: S=leddriver.vhd
#batchlab.%: T=
#batchlab.%: U=Nexys3_Master.ucf


# Misc functions that are good to have
include build/util.mk
# Setup simulation environment
include build/vsim.mk
# Setup synthesis environment
include build/xst.mk
# Setup backend flow environment
include build/xilinx-par.mk
# Setup tools for programming the FPGA
include build/digilentprog.mk
