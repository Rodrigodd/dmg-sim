DMG_CPU_B = dmg.proc.sv ../dmg_cpu_b/cells/trireg_m.sv

# SM83 = ../dmgcpu/HDL/sm83/Icarus/sm83.yosys.v
SM83 = \
../dmgcpu/HDL/sm83/_GekkioNames.v \
../dmgcpu/HDL/sm83/ALU.v \
../dmgcpu/HDL/sm83/Bottom.v \
../dmgcpu/HDL/sm83/DataMux.v \
../dmgcpu/HDL/sm83/Decoder1.v \
../dmgcpu/HDL/sm83/Decoder2.v \
../dmgcpu/HDL/sm83/Decoder3.v \
../dmgcpu/HDL/sm83/IDU.v \
../dmgcpu/HDL/sm83/IRNots.v \
../dmgcpu/HDL/sm83/IRQ.v \
../dmgcpu/HDL/sm83/Regs.v \
../dmgcpu/HDL/sm83/SeqCells.v \
../dmgcpu/HDL/sm83/Seq.v \
../dmgcpu/HDL/sm83/Thingy.v \
../dmgcpu/HDL/sm83/Top.v \
# ../sm83/sm83.sv \
../sm83/sm83_adr_inc.sv \
../sm83/sm83_alu.sv \
../sm83/sm83_alu_control.sv \
../sm83/sm83_alu_flags.sv \
../sm83/sm83_control.sv \
../sm83/sm83_decode.sv \
../sm83/sm83_int.sv \
../sm83/sm83_io.sv \
../sm83/sm83_sequencer.sv

AV_DUMP = \
../snd_dump.sv \
../vid_dump.sv

MBC = \
../mbc/mbc1.sv \
../mbc/mbc5.sv

TIMESCALE = ../timescale.f


IVERILOG = iverilog
IVERILOG_FLAGS = -g2012 -f $(TIMESCALE) -pfileline=1 -gsupported-assertions -Wall -Wfloating-nets
VVP = vvp
VVP_FLAGS = -N

dmg_cpu_b_gameboy.vvp: ../dmg_cpu_b_gameboy.sv $(DMG_CPU_B) $(SM83) $(AV_DUMP) $(MBC) $(TIMESCALE)
	$(IVERILOG) $(IVERILOG_FLAGS) -o $@ $(AV_DUMP) ../dmg_cpu_b_gameboy.sv $(DMG_CPU_B) $(SM83) $(MBC)

sim-gameboy $(DMG_CPU_B_GAMEBOY_VVP_OUT): dmg_cpu_b_gameboy.vvp
	$(VVP) $(VVP_FLAGS) $< -fst-speed +DUMPFILE=dmg_cpu_b_gameboy \
						   +SND_FILE=dmg_cpu_b_gameboy.snd \
						   +VID_FILE=dmg_cpu_b_gameboy.vid \
	                       +BOOTROM="$(BOOTROM)" \
	                       +ROM="$(ROM)" \
	                       +SECS=$(SECS)
