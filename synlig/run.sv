`default_nettype none

module dmg_cpu_b_gameboy;

	logic clk;
	logic reset;
	logic nrst;

	/* Clock (crystal) pins */
	logic xi, xo;

	/* Display pins */
	logic cpg, cp, cpl, fr, st, s;
	logic ld0, ld1;

	/* Audio pins */
	// real rout, lout;

	bit has_rom, has_ram;
	bit has_mbc1, has_mbc5;

	logic cpu_clkin_t9, cpu_clkin_t10;


	import snd_dump::write_header;
	import snd_dump::write_bit4_as_int8;
	import snd_dump::write_real_as_int16;

	int fvid, sample_idx;
	vid_dump vdump(.cpg(cpg), .cp(cp), .cpl(cpl), .fr(fr), .st(st), .s(s), .ld0(ld0), .ld1(ld1), .t(sample_idx), .f(fvid));

	DMG gb(
		.xi(xi), .xo(xo),
		.nrst(nrst),
		.cpg(cpg), .cp(cp), .cpl(cpl), .fr(fr), .st(st), .s(s), .ld0(ld0), .ld1(ld1),
		// .rout(rout), .lout(lout),
		.has_rom(has_rom), .has_ram(has_ram),
		.has_mbc1(has_mbc1), .has_mbc5(has_mbc5),
		.cpu_clkin_t9(cpu_clkin_t9), .cpu_clkin_t10(cpu_clkin_t10),
		.reset(reset)
	);

	task automatic xi_tick();
		/* Simulate the 4 MiHz crystal that is attached to the XI and XO pins */
		#120ns xi = xo;

		clk = xi;
	endtask

	task automatic cyc(input int num);
		if (xi)
			xi_tick();
		repeat (num * 2)
			xi_tick();
	endtask

	initial begin
		string rom_file;
		int    f, _;
		byte   mbc_type, ram_size;
		string error_message;

		has_rom  = 0;
		has_ram  = 0;
		has_mbc1 = 0;
		has_mbc5 = 0;

		rom_file = "";
		_ = $value$plusargs("ROM=%s", rom_file);

		f = 0;
		if (rom_file != "") begin
			f = $fopen(rom_file, "rb");
			if (!f)
				$fatal($ferror(f, error_message), "Failed to open cartridge ROM file %s for reading: %s", rom_file, error_message);
		end
		if (f) begin
			_ = $fread(gb.cart_rom, f);
			$fclose(f);
			has_rom = 1;
		end

		if (has_rom) begin
			mbc_type = gb.cart_rom['h147];
			ram_size = gb.cart_rom['h149];

			unique case (mbc_type)
				'h00, 'h08, 'h09: ;
				'h01, 'h02, 'h03: has_mbc1 = 1;
				'h05, 'h06:       $error("MBC2 not supported yet.");
				'h0b, 'h0c, 'h0d: $error("MMM01 not supported yet.");
				'h0f, 'h10, 'h11,
				'h12, 'h13:       $error("MBC3 not supported yet.");
				'h19, 'h1a, 'h1b,
				'h1c, 'h1d, 'h1e: has_mbc5 = 1;
				'h20:             $error("MBC6 not supported yet.");
				'h22:             $error("MBC7 not supported yet.");
				'hfc:             $error("MAC-GBD not supported yet.");
				'hfd:             $error("TAMA5 not supported yet.");
				'hfe:             $error("HuC3 not supported yet.");
				'hff:             $error("HuC1 not supported yet.");
				default:          $error("Unsupported MBC type.");
			endcase

			has_ram = |ram_size;
		end
	end

	int sim_mcycs;

	initial begin
		string dumpfile, ch_file, snd_file, vid_file;
		real   sim_seconds;
		int    _;
		int    fch[1:4];
		int    fmix;
		bit    dump_channels, dump_sound, dump_video;
		string error_message;

		dumpfile = "";
		_ = $value$plusargs("DUMPFILE=%s", dumpfile);

		ch_file = "";
		_ = $value$plusargs("CH_FILE=%s", ch_file);
		dump_channels = ch_file != "";

		snd_file = "";
		_ = $value$plusargs("SND_FILE=%s", snd_file);
		dump_sound = snd_file != "";

		vid_file = "";
		_ = $value$plusargs("VID_FILE=%s", vid_file);
		dump_video = vid_file != "";

		sim_seconds = 6.0; /* Enough time for the boot ROM */
		_ = $value$plusargs("SECS=%f", sim_seconds);

		sim_mcycs = $rtoi(sim_seconds * 1048576.0);

		$dumpfile(dumpfile);
		$dumpvars(0, dmg_cpu_b_gameboy);

		if (dump_channels) for (int i = 1; i <= 4; i++) begin
			string filename;
			$sformat(filename, ch_file, i);
			fch[i] = $fopen(filename, "wb");
			write_header(fch[i], 65536, 1, 0);
			$display("dumping audio to %s", filename);
		end
		if (dump_sound) begin
			fmix = $fopen(snd_file, "wb");
			write_header(fmix, 65536, 2, 1);
			$display("dumping video to %s", snd_file);
		end

		fvid = 0;
		if (dump_video) begin
			fvid = $fopen(vid_file, "wb");
			if (!fvid)
				$fatal($ferror(fvid, error_message), "Failed to open video dump file %s for writing: %s", vid_file, error_message);
			$display("dumping video to %s", vid_file);
		end

		sample_idx = 0;

		xi   = 0;
		nrst = 0;

		clk   = 0;

		cyc(64);
		nrst = 1;

		forever begin
			cyc(128);

			if (dump_channels) begin
				// write_bit4_as_int8(fch[1], dmg.ch1_out);
				// write_bit4_as_int8(fch[2], dmg.ch2_out);
				// write_bit4_as_int8(fch[3], dmg.wave_dac_d);
				// write_bit4_as_int8(fch[4], dmg.ch4_out);
			end
			// if (dump_sound) begin
			// 	write_real_as_int16(fmix, lout);
			// 	write_real_as_int16(fmix, rout);
			// end
			sample_idx++;
		end
	end


	initial begin
		string time_str, prev_time_str;

		#1ms;
		@(negedge reset);
		$sformat(time_str, "%.4f", $itor(sim_mcycs) / 1048576.0);
		$display("System reset done -- will simulate %s seconds", time_str);
		$fflush(32'h8000_0001);
		prev_time_str = time_str;

		while (sim_mcycs) begin
			sim_mcycs--;
			if (sim_mcycs % 1024 == 0) begin
				$sformat(time_str, "%.4f", $itor(sim_mcycs) / 1048576.0);
				if (time_str != prev_time_str && time_str != "0.0") begin
					$display("%s seconds remaining", time_str);
					$fflush(32'h8000_0001);
					prev_time_str = time_str;
				end
			end
			@(posedge cpu_clkin_t9);
			@(posedge cpu_clkin_t10);
		end

		$finish;
	end
endmodule

