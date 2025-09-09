# python run_simulation.py Legend\ of\ Zelda,\ The\ -\ Link\'s\ Awakening\ \(USA,\ Europe\).gb --output zelda --secs 0.5
run() {
    echo "Running $1"
    python3 run_simulation.py "$2" --output "sim/$1" --secs 1.5 &
}

run hblank_ly_scx_ /home/rodrigodd/repos/gameroy/core/tests/gameboy-test-roms/mooneye-test-suite/acceptance/ppu/hblank_ly_scx_timing-GS.gb
run intr_1_2_timin /home/rodrigodd/repos/gameroy/core/tests/gameboy-test-roms/mooneye-test-suite/acceptance/ppu/intr_1_2_timing-GS.gb
run intr_2_0_timin /home/rodrigodd/repos/gameroy/core/tests/gameboy-test-roms/mooneye-test-suite/acceptance/ppu/intr_2_0_timing.gb
run intr_2_mode0_t /home/rodrigodd/repos/gameroy/core/tests/gameboy-test-roms/mooneye-test-suite/acceptance/ppu/intr_2_mode0_timing.gb
run intr_2_mode0_t2 /home/rodrigodd/repos/gameroy/core/tests/gameboy-test-roms/mooneye-test-suite/acceptance/ppu/intr_2_mode0_timing_sprites.gb
run intr_2_mode3_t /home/rodrigodd/repos/gameroy/core/tests/gameboy-test-roms/mooneye-test-suite/acceptance/ppu/intr_2_mode3_timing.gb
run intr_2_oam_ok_ /home/rodrigodd/repos/gameroy/core/tests/gameboy-test-roms/mooneye-test-suite/acceptance/ppu/intr_2_oam_ok_timing.gb
run lcdon_timing-G /home/rodrigodd/repos/gameroy/core/tests/gameboy-test-roms/mooneye-test-suite/acceptance/ppu/lcdon_timing-GS.gb
run lcdon_write_ti /home/rodrigodd/repos/gameroy/core/tests/gameboy-test-roms/mooneye-test-suite/acceptance/ppu/lcdon_write_timing-GS.gb
run stat_irq_block /home/rodrigodd/repos/gameroy/core/tests/gameboy-test-roms/mooneye-test-suite/acceptance/ppu/stat_irq_blocking.gb
run stat_lyc_onoff /home/rodrigodd/repos/gameroy/core/tests/gameboy-test-roms/mooneye-test-suite/acceptance/ppu/stat_lyc_onoff.gb
run vblank_stat_in /home/rodrigodd/repos/gameroy/core/tests/gameboy-test-roms/mooneye-test-suite/acceptance/ppu/vblank_stat_intr-GS.gb

wait
