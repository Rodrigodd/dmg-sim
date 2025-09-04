module DMG(
	/* Clock (crystal) pins */
	input wire xi,
	output wire xo,

	input nrst,

	/* Display pins */
	output cpg, cp, cpl, fr, st, s,
	output ld0, ld1,

	/* Audio pins */
	// output real rout, lout,

	input has_rom, has_ram,
	input has_mbc1, has_mbc5,

	output cpu_clkin_t9, cpu_clkin_t10,

	output reset
);
	/* External cartridge bus */
	logic            phi;
	logic            nrd, nwr, ncs;
	tri logic [15:0] a_pin;
	tri logic [7:0]  d_pin;

	/* External video bus */
	logic            nmoe, nmwr, nmcs;
	logic     [12:0] ma_pin;
	tri logic [7:0]  md_pin;

	/* Serial link port pins */
	logic     sout;
	tri logic sin;
	tri logic sck;

	/* Button pins */
	tri logic p10, p11, p12, p13;
	logic     p14, p15;

	// assign p10 = 0;
	// assign p11 = 0;
	// assign p12 = 0;
	// assign p13 = 0;

	/* Connections to SM83 CPU core */
	logic cpu_out_t1;       /* CPU out T1  - Goes to unbonded pin; Some test pin? */
	logic cpu_clkin_t2;     /* CPU in  T2  - 1 MiHz clock; complement of T3 */
	logic cpu_clkin_t3;     /* CPU in  T3  - 1 MiHz clock; complement of T2 */
	logic cpu_clkin_t4;     /* CPU in  T4  - 1 MiHz clock; complement of T5 */
	logic cpu_clkin_t5;     /* CPU in  T5  - 1 MiHz clock; complement of T4 */
	logic cpu_clkin_t6;     /* CPU in  T6  - 1 MiHz clock; complement of T7 */
	logic cpu_clkin_t7;     /* CPU in  T7  - 1 MiHz clock; complement of T6 */
	logic cpu_clkin_t8;     /* CPU in  T8  - 1 MiHz clock */
	// logic cpu_clkin_t9;     /* CPU in  T9  - 1 MiHz clock; complement of T10 */
	// logic cpu_clkin_t10;    /* CPU in  T10 - 1 MiHz clock; complement of T9 */
	logic cpu_clk_ena;      /* CPU out T11 - Enable clocks; active-high */
	logic cpu_in_t12;       /* CPU in  T12 - Synchonous reset; active-high */
	logic cpu_in_t13;       /* CPU in  T13 - Asynchonous reset; active-high */
	logic cpu_xo_ena;       /* CPU out T14 - Enable crystal oscillator; active-high */
	logic cpu_in_t15;       /* CPU in  T15 - Crystal oscillator stable; active-high */
	logic cpu_in_t16;       /* CPU in  T16 - Goes to unbonded pin; Some test pin? */
	logic cpu_raw_rd;       /* CPU out R1  - Memory read signal; active-high */
	logic cpu_raw_wr;       /* CPU out R2  - Memory write signal; active-high */
	logic cpu_in_r3;        /* CPU in  R3  - High when T1=1 T2=0 */
	logic cpu_in_r4;        /* CPU in  R4  - High when address is 0xFExx or 0xFFxx */
	logic cpu_in_r5;        /* CPU in  R5  - High when address is 0x00xx and boot ROM is still visible */
	logic cpu_in_r6;        /* CPU in  R6  - High when T1=0 T2=1 */
	logic cpu_out_r7;       /* CPU out R7  - External memory request; active-high */
	logic cpu_irq0_ack;     /* CPU out R14 - IRQ0 acknowledge; active-high */
	logic cpu_irq0_trig;    /* CPU in  R15 - IRQ0 trigger; active-high */
	logic cpu_irq1_ack;     /* CPU out R16 - IRQ1 acknowledge; active-high */
	logic cpu_irq1_trig;    /* CPU in  R17 - IRQ1 trigger; active-high */
	logic cpu_irq2_ack;     /* CPU out R18 - IRQ2 acknowledge; active-high */
	logic cpu_irq2_trig;    /* CPU in  R19 - IRQ2 trigger; active-high */
	logic cpu_irq3_ack;     /* CPU out R20 - IRQ3 acknowledge; active-high */
	logic cpu_irq3_trig;    /* CPU in  R21 - IRQ3 trigger; active-high */
	logic cpu_irq4_ack;     /* CPU out R22 - IRQ4 acknowledge; active-high */
	logic cpu_irq4_trig;    /* CPU in  R23 - IRQ4 trigger; active-high */
	logic cpu_irq5_ack;     /* CPU out R24 - IRQ5 acknowledge; active-high */
	logic cpu_irq5_trig;    /* CPU in  R25 - IRQ5 trigger; active-high */
	logic cpu_irq6_ack;     /* CPU out R26 - IRQ6 acknowledge; active-high */
	logic cpu_irq6_trig;    /* CPU in  R27 - IRQ6 trigger; active-high */
	logic cpu_irq7_ack;     /* CPU out R28 - IRQ7 acknowledge; active-high */
	logic cpu_irq7_trig;    /* CPU in  R29 - IRQ7 trigger; active-high */
	tri logic [7:0]  d;     /* CPU I/O B1-B8  */
	tri logic [15:0] cpu_a; /* CPU out B9-B24 */
	logic cpu_wakeup;       /* CPU in  B25 - Wake from STOP mode; active-high */

	logic [7:0] video_ram[0:8191];
	logic [7:0] work_ram[0:8191];

	(*keep*) logic [7:0]  cart_rom[0:8388607];
	logic [7:0]  cart_ram[0:262143];
	logic [22:0] cart_rom_adr;
	logic [17:0] cart_ram_adr;
	logic        cart_rom_cs, cart_ram_cs;

	logic [18:14] mbc1_ra;
	logic [14:13] mbc1_aa;
	logic         mbc1_ncs_rom, mbc1_ncs_ram, mbc1_cs_ram;

	logic [22:14] mbc5_ra;
	logic [16:13] mbc5_aa;
	logic         mbc5_ncs_ram;

	assign reset = cpu_in_t12;

	// See dmgcpu/ports.md
	SM83Core cpu(
		.M1(cpu_out_t1),         // out T1 
		.CLK1(cpu_clkin_t2),     // in  T2 
		.CLK2(cpu_clkin_t3),     // in  T3 
		.CLK3(cpu_clkin_t4),     // in  T4 
		.CLK4(cpu_clkin_t5),     // in  T5 
		.CLK5(cpu_clkin_t6),     // in  T6 
		.CLK6(cpu_clkin_t7),     // in  T7 
		.CLK7(cpu_clkin_t8),     // in  T8 
		.CLK8(cpu_clkin_t9),     // in  T9 
		.CLK9(cpu_clkin_t10),    // in  T10
		.CLK_ENA(cpu_clk_ena),   // out T11
		.SYNC_RESET(cpu_in_t12), // in  T12
		.RESET(cpu_in_t13),      // in  T13
		.OSC_ENA(cpu_xo_ena),    // out T14
		.OSC_STABLE(cpu_in_t15), // in  T15
		// .in(cpu_in_t16),      // in  T16
		.RD(cpu_raw_rd),         // out R1 
		.WR(cpu_raw_wr),         // out R2 
		.BUS_DISABLE(cpu_in_r3), // in  R3 
		.MMIO_REQ(cpu_in_r4),    // in  R4 
		.IPL_REQ(cpu_in_r5),     // in  R5 
		.IPL_DISABLE(cpu_in_r6), // in  R6 
		.MREQ(cpu_out_r7),       // out R7 

		.CPU_IRQ_ACK({
			cpu_irq7_ack, // out R28
			cpu_irq6_ack, // out R26
			cpu_irq5_ack, // out R24
			cpu_irq4_ack, // out R22
			cpu_irq3_ack, // out R20
			cpu_irq2_ack, // out R18
			cpu_irq1_ack, // out R16
			cpu_irq0_ack  // out R14
		}),

		.CPU_IRQ_TRIG({
			cpu_irq7_trig, // in  R29
			cpu_irq6_trig, // in  R27
			cpu_irq5_trig, // in  R25
			cpu_irq4_trig, // in  R23
			cpu_irq3_trig, // in  R21
			cpu_irq2_trig, // in  R19
			cpu_irq1_trig, // in  R17
			cpu_irq0_trig  // in  R15
		}),
		.D(d),             // I/O B1-B8  
		.A(cpu_a),         // out B9-B24 
		.WAKE(cpu_wakeup), // in  B25 
		.NMI(1'b0)
	);

	dmg_cpu_b dmg(
		 .xi(xi), .xo(xo), .t1('0), .t2('0), .nrst(nrst), .phi(phi), .nrd(nrd),
		 .nwr(nwr), .ncs(ncs), .nmoe(nmoe), .nmwr(nmwr), .nmcs(nmcs),
		 .d_pin(d_pin), .md_pin(md_pin), .a_pin(a_pin), .ma_pin(ma_pin),
		 .sout(sout), .sin(sin), .sck(sck), .p10(p10), .p11(p11), .p12(p12),
		 .p13(p13), .p14(p14), .p15(p15), .cpg(cpg), .cp(cp), .cpl(cpl),
		 .fr(fr), .st(st), .s(s), .ld0(ld0), .ld1(ld1), 
		 // .rout(rout), .lout(lout), .vin(0.0),
		 .unbonded_pad0('1),
		 .unbonded_pad1(), .cpu_out_t1(cpu_out_t1),
		 .cpu_clkin_t2(cpu_clkin_t2), .cpu_clkin_t3(cpu_clkin_t3),
		 .cpu_clkin_t4(cpu_clkin_t4), .cpu_clkin_t5(cpu_clkin_t5),
		 .cpu_clkin_t6(cpu_clkin_t6), .cpu_clkin_t7(cpu_clkin_t7),
		 .cpu_clkin_t8(cpu_clkin_t8), .cpu_clkin_t9(cpu_clkin_t9),
		 .cpu_clkin_t10(cpu_clkin_t10), .cpu_clk_ena(cpu_clk_ena),
		 .cpu_in_t12(cpu_in_t12), .cpu_in_t13(cpu_in_t13),
		 .cpu_xo_ena(cpu_xo_ena), .cpu_in_t15(cpu_in_t15),
		 .cpu_in_t16(cpu_in_t16), .cpu_raw_rd(cpu_raw_rd),
		 .cpu_raw_wr(cpu_raw_wr), .cpu_in_r3(cpu_in_r3), .cpu_in_r4(cpu_in_r4),
		 .cpu_in_r5(cpu_in_r5), .cpu_in_r6(cpu_in_r6), .cpu_out_r7(cpu_out_r7),
		 .cpu_irq0_ack(cpu_irq0_ack), .cpu_irq0_trig(cpu_irq0_trig),
		 .cpu_irq1_ack(cpu_irq1_ack), .cpu_irq1_trig(cpu_irq1_trig),
		 .cpu_irq2_ack(cpu_irq2_ack), .cpu_irq2_trig(cpu_irq2_trig),
		 .cpu_irq3_ack(cpu_irq3_ack), .cpu_irq3_trig(cpu_irq3_trig),
		 .cpu_irq4_ack(cpu_irq4_ack), .cpu_irq4_trig(cpu_irq4_trig),
		 .cpu_irq5_ack(cpu_irq5_ack), .cpu_irq5_trig(cpu_irq5_trig),
		 .cpu_irq6_ack(cpu_irq6_ack), .cpu_irq6_trig(cpu_irq6_trig),
		 .cpu_irq7_ack(cpu_irq7_ack), .cpu_irq7_trig(cpu_irq7_trig), .d(d),
		 .cpu_a(cpu_a), .cpu_wakeup(cpu_wakeup));

	// integer i;
	// initial for (i = 0; i < 8192; i++) video_ram[i] = /*random*/0;
	always_ff @(posedge nmwr) if (~nmcs) video_ram[ma_pin] <= /*isunknown(md_pin))*/0 ? /*random*/0 : md_pin;
	logic [7:0] video_ram_d = video_ram[ma_pin];
	logic video_ram_wr = ~nmcs && ~nmoe;
	assign md_pin = (video_ram_wr) ? video_ram_d : 8'hzz;

	// initial for (i = 0; i < 8192; i++) work_ram[i] = /*random*/0;
	always_ff @(posedge nwr) if (~ncs && a_pin[14]) work_ram[a_pin[12:0]] <= /*isunknown(d_pin))*/0 ? /*random*/0 : d_pin;
	logic [7:0] work_ram_d = work_ram[a_pin[12:0]];
	logic work_ram_wr = ~ncs && a_pin[14] && ~nrd;
	assign d_pin = (work_ram_wr) ? work_ram_d : 8'hzz;

	logic [7:0] cart_rom_d = cart_rom[cart_rom_adr];
	logic cart_rom_wr = has_rom && cart_rom_cs && ~nrd;
	assign d_pin = (cart_rom_wr) ? cart_rom_d : 8'hzz;
	// initial for (i = 0; i < 262144; i++) cart_ram[i] = /*random*/0;
	always_ff @(posedge nwr) if (has_ram && cart_ram_cs) cart_ram[cart_ram_adr] <= /*isunknown(d_pin))*/0 ? /*random*/0 : d_pin;
	logic [7:0] cart_ram_d = cart_ram[cart_rom_adr];
	logic cart_ram_wr = has_ram && cart_ram_cs && ~nrd;
	assign d_pin = (cart_ram_wr) ? cart_ram_d : 8'hzz;

	mbc1 mbc1_chip(
		.nrst,
		.a(a_pin[15:13]),
		.d(d_pin[4:0]),
		.nrd, .nwr, .ncs,
		.ra(mbc1_ra),
		.aa(mbc1_aa),
		.ncs_rom(mbc1_ncs_rom),
		.ncs_ram(mbc1_ncs_ram),
		.cs_ram(mbc1_cs_ram)
	);

	mbc5 mbc5_chip(
		.nrst,
		.a(a_pin[15:12]),
		.d(d_pin),
		.nwr, .ncs,
		.ra(mbc5_ra),
		.aa(mbc5_aa),
		.ncs_ram(mbc5_ncs_ram)
	);

	assign cart_rom_adr = has_mbc1 ? { mbc1_ra, a_pin[13:0] } :
	                      has_mbc5 ? { mbc5_ra, a_pin[13:0] } :
	                                 a_pin[14:0];
	assign cart_ram_adr = has_mbc1 ? { mbc1_aa, a_pin[12:0] } :
	                      has_mbc5 ? { mbc5_aa, a_pin[12:0] } :
	                                 a_pin[12:0];
	assign cart_rom_cs  = has_mbc1 ? ~mbc1_ncs_rom :
	                      has_mbc5 ? ~a_pin[15] :
	                                 ~a_pin[15];
	assign cart_ram_cs  = has_mbc1 ? (~mbc1_ncs_ram && mbc1_cs_ram) :
	                      has_mbc5 ? ~mbc5_ncs_ram :
	                                 (~ncs && a_pin[13]);

endmodule
