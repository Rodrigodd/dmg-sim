`default_nettype none
`timescale 1ns/100ps

module channel1(
		d, apu_wr, apu_reset, napu_reset6, nphi, net03,
		ff11, ff11_d6, nff11_d6, ff11_d7, nff11_d7, ff14, ff14_d6, nff14_d6,
		nff10_d0, nff10_d1, nff10_d2, nff10_d4, nff10_d5, nff10_d6,
		ff12_d0, ff12_d1, ff12_d2, ff12_d3, ff12_d4, ff12_d5, ff12_d6, ff12_d7,
		nff12_d0, nff12_d1, nff12_d2, nff12_d3,
		ch1_restart, ch1_shift_clk, ch1_ld_shift, ch1_freq_upd1, ch1_freq_upd2,
		nch1_active, nch1_amp_en,
		atys, gexu, copu, cope, cate, abol, kyly, adad,
		byfe_128hz, bufy_256hz, horu_512hz, dyfa_1mhz, ajer_2mhz,
		ch1_out
	);

	input wire [7:0] d;

	input wire apu_wr, apu_reset, napu_reset6, nphi, net03;
	input wire ff11, ff11_d6, nff11_d6, ff11_d7, nff11_d7, ff14, ff14_d6, nff14_d6;
	input wire nff10_d0, nff10_d1, nff10_d2, nff10_d4, nff10_d5, nff10_d6;
	input wire ff12_d0, ff12_d1, ff12_d2, ff12_d3, ff12_d4, ff12_d5, ff12_d6, ff12_d7;
	input wire nff12_d0, nff12_d1, nff12_d2, nff12_d3;

	output wire ch1_restart, ch1_shift_clk, ch1_ld_shift, ch1_freq_upd1, ch1_freq_upd2;
	output wire nch1_active, nch1_amp_en;
	input  wire atys, copu, cate, abol;
	output wire gexu, cope, kyly, adad;
	input  wire byfe_128hz, bufy_256hz, horu_512hz, dyfa_1mhz, ajer_2mhz;

	output wire [3:0] ch1_out;

	wire boro, boka, cory, cero, capy, cyfa, hoca, bone, bery, femy, gepu, bugy, canu, bepe, cuso;
	wire bacy, cavy, bovy, cuno, cura, eram;
	dffr dffr_cero(!eram, cory, !cero, cero); // check clk edge
	count count_bacy(canu, bugy, d[0], bacy);
	count count_cavy(bacy, bugy, d[1], cavy);
	count count_bovy(cavy, bugy, d[2], bovy);
	count count_cuno(bovy, bugy, d[3], cuno);
	count count_cura(cuso, bepe, d[4], cura);
	count count_eram(cura, bepe, d[5], eram);
	assign #T_NAND boro = !(apu_wr && ff11);
	assign #T_INV  boka = !boro;
	assign #T_NOR  cory = !(ch1_restart || apu_reset || boka);
	assign #T_NOR  capy = !(nff14_d6 || bufy_256hz || cero);
	assign #T_AND  cyfa = cero && ff14_d6;
	assign #T_NOR  hoca = !(ff12_d3 || ff12_d4 || ff12_d5 || ff12_d6 || ff12_d7);
	assign #T_INV  bone = !atys;
	assign #T_OR   bery = bone || apu_reset || cyfa || hoca;
	assign #T_NOR  femy = !(apu_reset || hoca);
	assign #T_INV  gepu = !fyte;
	assign #T_AND  gexu = gepu && femy;
	assign #T_INV  bugy = !boro;
	assign #T_INV  canu = !capy;
	assign #T_INV  bepe = !boro;
	assign #T_INV  cuso = cuno; /* takes !q output of dff */
	assign nch1_amp_en = hoca;

	wire cala, comy, cyte, dyru, doka;
	dffr dffr_comy(cala, dyru, !comy, comy); // check clk edge
	assign #T_INV  cala = !copu;
	assign #T_INV  cyte = !comy;
	assign #T_INV  cope = !cyte;
	assign #T_NOR  dyru = !(apu_reset || ch1_restart || doka);
	assign #T_AND  doka = comy && dyfa_1mhz;

	wire dafa, cymu, bave, caxy, cypu, cupo, bury, coze, bexa;
	dffr dffr_bexa(ajer_2mhz, bury, coze, bexa); // check clk edge
	count count_caxy(cypu, cymu, nff10_d6, caxy);
	count count_cypu(cupo, cymu, nff10_d5, cypu);
	count count_cupo(cate, cymu, nff10_d4, cupo);
	assign #T_NOR  dafa = !(bexa || ch1_restart);
	assign #T_INV  cymu = !dafa;
	assign #T_AND  bave = nff10_d6 && nff10_d5 && nff10_d4;
	assign #T_NOR  bury = !(bave || apu_reset);
	assign #T_AND  coze = caxy && cypu && cupo;

	wire jone, kado, kaly, kere, jola, jova, kenu, kera, kote, kury, kuku, koro, kozy, kaza, kuxu, koma, kake;
	wire erum, fare, fyte, eget, doge, dado, dupe, duka, ezec, gefe, fyfo, feku, keko, kaba;
	wire hufu, hano, hake, koru, jade, kyno, kezu;
	wire cyto, cara, duwo, cowe, boto;
	wire hesu, heto, hyto, jufy, hevo, hoko, hemy, hafo, aceg, agof, ason, amop;
	dffr dffr_kaly(jone,       kado,        !kaly,       kaly); // check clk edge
	dffr dffr_kozy(horu_512hz, koro,        kote,        kozy); // check clk edge
	dffr dffr_fare(dyfa_1mhz,  erum,        ch1_restart, fare); // check clk edge
	dffr dffr_fyte(dyfa_1mhz,  erum,        fare,        fyte); // check clk edge
	dffr dffr_dupe(doge,       dado,        d[7],        dupe); // check clk edge
	dffr dffr_ezec(nphi,       duka,        dupe,        ezec); // check clk edge
	dffr dffr_feku(dyfa_1mhz,  eget,        fyfo,        feku); // check clk edge
	dffr dffr_kyno(kozy,       koru,        jade,        kyno); // check clk edge
	dffr dffr_duwo(cope,       napu_reset6, ch1_bit,     duwo); // check clk edge
	count count_jova(jola, kuxu,        nff12_d0, jova);
	count count_kenu(jova, kuxu,        nff12_d1, kenu);
	count count_kera(kenu, kuxu,        nff12_d2, kera);
	count count_hevo(hesu, ch1_restart, ff12_d7,  hevo);
	count count_hoko(heto, ch1_restart, ff12_d6,  hoko);
	count count_hemy(hyto, ch1_restart, ff12_d5,  hemy);
	count count_hafo(jufy, ch1_restart, ff12_d4,  hafo);
	assign #T_INV  jone = !byfe_128hz;
	assign #T_INV  kado = !apu_reset;
	assign #T_INV  kere = !kaly;
	assign #T_INV  jola = !kere;
	assign #T_AND  kote = kera && kenu && jova;
	assign #T_INV  kury = !kozy;
	assign #T_NOR  kuku = !(abol || kury);
	assign #T_NOR  koro = !(kuku || koma || ch1_restart || apu_reset);
	assign #T_NOR  kaza = !(ch1_restart || kozy);
	assign #T_INV  kuxu = !kaza;
	assign #T_NOR  koma = !(ff12_d0 || ff12_d1 || ff12_d2);
	assign #T_AND  kake = kozy && koma && kezu;
	assign #T_INV  erum = !apu_reset;
	assign #T_NOR  eget = !(apu_reset || fare);
	assign #T_NAND doge = !(apu_wr && ff14);
	assign #T_NOR  dado = !(apu_reset || ezec);
	assign #T_INV  duka = !apu_reset;
	assign #T_INV  gefe = !eget;
	assign #T_OR   fyfo = gefe || ezec;
	assign #T_OR   keko = apu_reset || feku;
	assign #T_OR   kaba = apu_reset || feku;
	assign #T_INV  kyly = !kaba;
	assign #T_NAND hufu = !(nff12_d3 && hafo && hemy && hoko && hevo);
	assign #T_NOR  hano = !(nff12_d3 || hafo || hemy || hoko || hevo);
	assign #T_INV  hake = !hufu;
	assign #T_NOR  koru = !(ch1_restart || apu_reset);
	assign #T_OR   jade = hake || hano;
	assign #T_OR   kezu = kyno || keko;
	assign #T_OR   cyto = ch1_restart || bery;
	assign #T_INV  cara = !cyto;
	assign #T_AND  cowe = cyto && duwo;
	assign #T_OR   boto = cowe || net03;
	assign #T_AOI  hesu = !((ff12_d3 && hoko) || (!hoko && nff12_d3)); // check if this is what is meant by AOI_MUX_2
	assign #T_AOI  heto = !((ff12_d3 && hemy) || (!hemy && nff12_d3)); // check if this is what is meant by AOI_MUX_2
	assign #T_AOI  hyto = !((ff12_d3 && hafo) || (!hafo && nff12_d3)); // check if this is what is meant by AOI_MUX_2
	assign #T_AOI  jufy = !((ff12_d3 && kake) || (kake && nff12_d3)); // check if this is what is meant by AOI_MUX_2
	assign #T_AND  aceg = hevo && boto;
	assign #T_AND  agof = hoko && boto;
	assign #T_AND  ason = hemy && boto;
	assign #T_AND  amop = hafo && boto;
	assign ch1_restart = feku;
	assign nch1_active = cara;
	assign ch1_out[3]  = aceg;
	assign ch1_out[2]  = agof;
	assign ch1_out[1]  = ason;
	assign ch1_out[0]  = amop;

	wire dacu, cylu, copa, caja, byra, buge, copy, atat, BYTE, epuk, evol, femu, egyp, cele, dody, egor, dapu;
	wire nno_sweep;
	dffr dffr_byte(ajer_2mhz, atat, copy, BYTE); // check clk edge
	count count_copa(dapu, cylu, nff10_d0, copa);
	count count_caja(copa, cylu, nff10_d1, caja);
	count count_byra(caja, cylu, nff10_d2, byra);
	assign #T_NOR  dacu = !(ch1_restart || bexa);
	assign #T_INV  cylu = !dacu;
	assign #T_NAND buge = !(nff10_d2 && nff10_d1 && nff10_d0);
	assign #T_AND  copy = copa && caja && byra;
	assign #T_NOR  atat = !(bexa || apu_reset);
	assign #T_INV  adad = BYTE; /* takes !q output of dff */
	assign #T_NOR  epuk = !(apu_reset || adad);
	assign #T_NOR  evol = !(bexa || fyte);
	assign #T_AND  femu = epuk && evol;
	assign #T_NOR  egyp = !(femu || dyfa_1mhz);
	assign #T_INV  cele = !nno_sweep;
	assign #T_NOR  dody = !(cele || egyp);
	assign #T_INV  egor = !dody;
	assign #T_INV  dapu = !egor;
	assign nno_sweep     = buge;
	assign ch1_shift_clk = egor;

	wire dajo, esut, eros, dape, duvo, ezoz, enek, codo, coso, cava, cevu, caxo, duna;
	wire ch1_bit;
	dffr dffr_esut(dajo,  napu_reset6, !esut, esut); // check clk edge
	dffr dffr_eros(!esut, napu_reset6, !eros, eros); // check clk edge
	dffr dffr_dape(!eros, napu_reset6, !dape, dape); // check clk edge
	assign #T_INV  dajo = !cope;
	assign #T_INV  duvo = !esut;
	assign #T_AND  ezoz = dape && eros;
	assign #T_AND  enek = ezoz && duvo;
	assign #T_INV  codo = !ezoz;
	assign #T_NOR  coso = !(ff11_d6 || ff11_d7);
	assign #T_NOR  cava = !(nff11_d6 || ff11_d7);
	assign #T_NOR  cevu = !(ff11_d6 || nff11_d7);
	assign #T_NOR  caxo = !(nff11_d6 || nff11_d7);
	assign #T_AOI  duna = !((enek && coso) || (ezoz && cava) || (dape && cevu) || (codo && caxo)); // check if this is what is meant by AOI_MUX_4
	assign ch1_bit = duna;

	wire atuv, boje, buso, kala;
	assign #T_AND  atuv = bexa && atys;
	assign #T_AND  boje = atuv && nno_sweep;
	assign #T_AND  buso = nno_sweep && atys && bexa;
	assign #T_NOR  kala = !(bexa || ch1_restart);
	assign ch1_freq_upd2 = boje;
	assign ch1_freq_upd1 = buso;
	assign ch1_ld_shift  = kala;

endmodule
