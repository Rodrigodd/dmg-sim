DMG_CPU_B_PAGES = \
../dmg_cpu_b/pages/p1_clocks_reset.sv \
../dmg_cpu_b/pages/p2_interrupts.sv \
../dmg_cpu_b/pages/p3_timer.sv \
../dmg_cpu_b/pages/p4_dma.sv \
../dmg_cpu_b/pages/p5_joypad_io.sv \
../dmg_cpu_b/pages/p6_serial_link.sv \
../dmg_cpu_b/pages/p7_sys_decode.sv \
../dmg_cpu_b/pages/p8_ext_cpu_busses.sv \
../dmg_cpu_b/pages/p9_apu_control.sv \
../dmg_cpu_b/pages/p10_apu_decode.sv \
../dmg_cpu_b/pages/p11_ch1_regs.sv \
../dmg_cpu_b/pages/p12_ch1_sweep.sv \
../dmg_cpu_b/pages/p13_channel1.sv \
../dmg_cpu_b/pages/p14_ch2_regs.sv \
../dmg_cpu_b/pages/p15_channel2.sv \
../dmg_cpu_b/pages/p16_ch3_regs.sv \
../dmg_cpu_b/pages/p17_wave_ram.sv \
../dmg_cpu_b/pages/p18_channel3.sv \
../dmg_cpu_b/pages/p19_ch4_regs.sv \
../dmg_cpu_b/pages/p20_channel4.sv \
../dmg_cpu_b/pages/p21_video_control.sv \
../dmg_cpu_b/pages/p22_ppu_decode.sv \
../dmg_cpu_b/pages/p23_video_regs.sv \
../dmg_cpu_b/pages/p24_lcd_control.sv \
../dmg_cpu_b/pages/p25_vram_interface.sv \
../dmg_cpu_b/pages/p26_background.sv \
../dmg_cpu_b/pages/p27_window_map_lookup.sv \
../dmg_cpu_b/pages/p28_oam.sv \
../dmg_cpu_b/pages/p29_sprite_control.sv \
../dmg_cpu_b/pages/p30_sprite_store.sv \
../dmg_cpu_b/pages/p31_sprite_x_matchers.sv \
../dmg_cpu_b/pages/p32_bg_pixel_shifter.sv \
../dmg_cpu_b/pages/p33_sprite_pixel_shifter.sv \
../dmg_cpu_b/pages/p34_sprite_palette_shifter.sv \
../dmg_cpu_b/pages/p35_pixel_mux.sv \
../dmg_cpu_b/pages/p36_palettes.sv

DMG_CPU_B_CELLS = \
../dmg_cpu_b/cells/timing_param.sv \
../dmg_cpu_b/cells/nor_srlatch.sv \
../dmg_cpu_b/cells/nand_srlatch.sv \
../dmg_cpu_b/cells/dlatch_a.sv \
../dmg_cpu_b/cells/dlatch_b.sv \
../dmg_cpu_b/cells/drlatch.sv \
../dmg_cpu_b/cells/dffr_a.sv \
../dmg_cpu_b/cells/dffr_b.sv \
../dmg_cpu_b/cells/dffsr.sv \
../dmg_cpu_b/cells/tffd.sv \
../dmg_cpu_b/cells/trireg_m.sv

DMG_CPU_B = \
dmg.sv \
../dmg_cpu_b/dmg_cpu_b.sv \
../dmg_cpu_b/bootrom.sv \
$(DMG_CPU_B_CELLS) \
$(DMG_CPU_B_PAGES)

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
../dmgcpu/HDL/sm83/Top.v

AV_DUMP = \
../snd_dump.sv \
../vid_dump.sv

MBC = \
../mbc/mbc1.sv \
../mbc/mbc5.sv

DMG = \
dmg.purge.sv \
../dmg_cpu_b/cells/trireg_m.sv \
../dmg_cpu_b/bootrom.sv \
$(MBC)

TIMESCALE = ../timescale.f


IVERILOG = iverilog
IVERILOG_FLAGS = -g2012 -f $(TIMESCALE) -pfileline=1 -gsupported-assertions -Wall -Wfloating-nets
VVP = vvp
VVP_FLAGS = -N

YOSYS = ../../synlig/build/release/synlig/synlig

run.vvp: run.sv $(DMG) $(AV_DUMP) $(TIMESCALE) Makefile
	$(IVERILOG) $(IVERILOG_FLAGS) -o $@ $(AV_DUMP) run.sv $(DMG)

sim-gameboy $(DMG_CPU_B_GAMEBOY_VVP_OUT): run.vvp Makefile
	$(VVP) $(VVP_FLAGS) $< -fst-speed +DUMPFILE=run \
						   +SND_FILE=run.snd \
						   +VID_FILE=run.vid \
	                       +BOOTROM="$(BOOTROM)" \
	                       +ROM="$(ROM)" \
	                       +SECS=$(SECS)

yosys:
	$(YOSYS) -s synlig.ys -g

run.mkv: ../mkvid/mkimgs ../mkvid/mkvid.sh run.vid run.snd
	../mkvid/mkvid.sh run

VERILATOR=../../verilator/bin/verilator

VERILATOR_FLAGS=\
 --top-module dmg_cpu_b_gameboy\
 --cc\
 --timing\
 --Wno-fatal\
 --Wno-LATCH\
 --timescale "1ns/1ns"\
 --x-initial unique\
 --autoflush\
 # --trace-fst\
 # --trace-underscore\
 # --no-trace-top\

verilator_build/Vdmg_cpu_b_gameboy: run.sv $(DMG) $(AV_DUMP) $(TIMESCALE) Makefile
	$(VERILATOR)  $(VERILATOR_FLAGS) $(AV_DUMP) $(DMG) run.sv --binary  -j 0 -Mdir verilator_build

run_verilator: verilator_build/Vdmg_cpu_b_gameboy
	verilator_build/Vdmg_cpu_b_gameboy +verilator+rand+reset+1 \
		"+DUMPFILE=run" \
		"+SND_FILE=run.snd" \
		"+VID_FILE=run.vid" \
		"+BOOTROM=$(BOOTROM)" \
		"+ROM=$(ROM)" \
		"+SECS=$(SECS)"
 
