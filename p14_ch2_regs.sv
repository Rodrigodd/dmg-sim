`default_nettype none

module ch2_regs(
		inout tri logic [7:0] d,

		input logic apu_wr, apu_reset, napu_reset2, ncpu_rd, net03,

		input  logic ff16, ff17, ff18, ff19,
		output logic nff16_wr, ff16_d6, nff16_d6, ff16_d7, nff16_d7,
		output logic ff17_d0, nff17_d0, ff17_d1, nff17_d1, ff17_d2, nff17_d2,
		output logic ff17_d3, nff17_d3, ff17_d4, ff17_d5, ff17_d6, ff17_d7,
		output logic ff19_d6, nff19_d6, ff19_d7,

		output logic ch2_ftick, beny,

		input logic elox_q, anuj, duce, doca, cogu, erog, dera, gypa
	);

	logic agyn, asyp, bygo, coro, bacu, budu, bamy, bera, ceka, cecy;
	dffr_a dffr_bamy(budu, napu_reset2, d[7], bamy); // check clk edge
	dffr_a dffr_bera(budu, napu_reset2, d[6], bera); // check clk edge
	assign #T_NAND agyn = !(apu_wr && ff16);
	assign #T_INV  asyp = !agyn;
	assign #T_NOR  beny = !(asyp || apu_reset || elox_q);
	assign #T_INV  bygo = !ncpu_rd;
	assign #T_NAND coro = !(ff16 && bygo);
	assign #T_AND  bacu = ff16 && apu_wr;
	assign #T_INV  budu = !bacu;
	assign #T_TRI  ceka = !coro ? bamy : 'z; /* takes !q output of dffr */
	assign #T_TRI  cecy = !coro ? bera : 'z; /* takes !q output of dffr */
	assign nff16_wr = agyn;
	assign ff16_d7  = bamy;
	assign nff16_d7 = !bamy;
	assign ff16_d6  = bera;
	assign nff16_d6 = !bera;
	assign d[7] = ceka;
	assign d[6] = cecy;

	logic kypu, jenu, kysa, jupy, jany, jefu;
	logic ff19_d0, ff19_d1, ff19_d2;
	dffr_a dffr_jupy(kysa, kypu, d[2], jupy); // check clk edge
	dffr_a dffr_jany(kysa, kypu, d[1], jany); // check clk edge
	dffr_a dffr_jefu(kysa, kypu, d[0], jefu); // check clk edge
	assign #T_INV  kypu = !apu_reset;
	assign #T_AND  jenu = ff19 && apu_wr;
	assign #T_INV  kysa = !jenu;
	assign ff19_d2 = jupy;
	assign ff19_d1 = jany;
	assign ff19_d0 = jefu;

	logic enuf, jybu, fyry, guru, gure, gexa, gere, jede;
	logic gata, fore, gage, gura, gufe, hava, hore, hyfu;
	logic hupe, gene, hyry, horo, here, havu, hyre, huvu;
	dffr_a dffr_gata(enuf, jybu, d[4], gata); // check clk edge
	dffr_a dffr_fore(enuf, jybu, d[3], fore); // check clk edge
	dffr_a dffr_gage(enuf, jybu, d[7], gage); // check clk edge
	dffr_a dffr_gura(enuf, jybu, d[6], gura); // check clk edge
	dffr_a dffr_gufe(enuf, jybu, d[5], gufe); // check clk edge
	dffr_a dffr_hava(jede, jybu, d[2], hava); // check clk edge
	dffr_a dffr_hore(jede, jybu, d[1], hore); // check clk edge
	dffr_a dffr_hyfu(jede, jybu, d[0], hyfu); // check clk edge
	assign #T_AND  enuf = ff17 && apu_wr;
	assign #T_INV  jybu = !apu_reset;
	assign #T_INV  fyry = !ff17;
	assign #T_OR   guru = fyry || ncpu_rd;
	assign #T_INV  gure = !ff17;
	assign #T_OR   gexa = gure || ncpu_rd;
	assign #T_AND  gere = apu_wr && ff17;
	assign #T_INV  jede = !gere;
	assign #T_TRI  hupe = !guru ? gata : 'z; /* takes !q output of dffr */
	assign #T_TRI  gene = !guru ? fore : 'z; /* takes !q output of dffr */
	assign #T_TRI  hyry = !guru ? gage : 'z; /* takes !q output of dffr */
	assign #T_TRI  horo = !guru ? gura : 'z; /* takes !q output of dffr */
	assign #T_TRI  here = !guru ? gufe : 'z; /* takes !q output of dffr */
	assign #T_TRI  havu = !gexa ? hava : 'z; /* takes !q output of dffr */
	assign #T_TRI  hyre = !gexa ? hore : 'z; /* takes !q output of dffr */
	assign #T_TRI  huvu = !gexa ? hyfu : 'z; /* takes !q output of dffr */
	assign ff17_d4  = gata;
	assign ff17_d3  = fore;
	assign nff17_d3 = !fore;
	assign ff17_d7  = gage;
	assign ff17_d6  = gura;
	assign ff17_d5  = gufe;
	assign ff17_d2  = hava;
	assign nff17_d2 = !hava;
	assign ff17_d1  = hore;
	assign nff17_d1 = !hore;
	assign ff17_d0  = hyfu;
	assign nff17_d0 = !hyfu;
	assign d[4] = hupe;
	assign d[3] = gene;
	assign d[7] = hyry;
	assign d[6] = horo;
	assign d[5] = here;
	assign d[2] = havu;
	assign d[1] = hyre;
	assign d[0] = huvu;

	logic dosa, exuc, hude, esur, fyxo, fery, guza, futy, edep;
	logic fofe, fova, fedy, fome, fora, goda, gumy, gupu;
	logic done, dynu, ezof, cyvo, fuxo, gano, goca, gane, gane_nq;
	logic fava, fajy, fegu, fose, gero, gaky, gadu, gazo;
	logic foge, fape, deta, gote, etap, hypo;
	logic gala, hero, hepu, hevy, jeke, jaro, huna;
	dffr_a dffr_fofe(esur, hude, d[0], fofe); // check clk edge
	dffr_a dffr_fova(esur, hude, d[1], fova); // check clk edge
	dffr_a dffr_fedy(esur, hude, d[2], fedy); // check clk edge
	dffr_a dffr_fome(esur, hude, d[3], fome); // check clk edge
	dffr_a dffr_fora(esur, hude, d[4], fora); // check clk edge
	dffr_a dffr_goda(fyxo, hude, d[5], goda); // check clk edge
	dffr_a dffr_gumy(fyxo, hude, d[6], gumy); // check clk edge
	dffr_a dffr_gupu(fyxo, hude, d[7], gupu); // check clk edge
	dffr_a dffr_etap(deta, dera, d[7], etap); // check clk edge
	tffd tffd_done(doca, cogu, fofe,    done);
	tffd tffd_dynu(done, cogu, fova,    dynu);
	tffd tffd_ezof(dynu, cogu, fedy,    ezof);
	tffd tffd_cyvo(ezof, cogu, fome,    cyvo);
	tffd tffd_fuxo(edep, erog, fora,    fuxo);
	tffd tffd_gano(fuxo, erog, goda,    gano);
	tffd tffd_goca(gano, erog, gumy,    goca);
	tffd tffd_gane(goca, erog, gupu,    gane);
	tffd tffd_hero(hepu, gypa, ff19_d2, hero);
	tffd tffd_hepu(hevy, gypa, ff19_d1, hepu);
	tffd tffd_hevy(gala, gypa, ff19_d0, hevy);
	assign #T_AND  dosa = ff18 && apu_wr;
	assign #T_AND  exuc = ff18 && apu_wr;
	assign #T_INV  hude = !apu_reset;
	assign #T_INV  esur = !dosa;
	assign #T_INV  fyxo = !exuc;
	assign #T_INV  fery = !ff18;
	assign #T_NOR  guza = !(fery || fape);
	assign #T_INV  futy = !guza;
	assign #T_INV  edep = cyvo; /* takes !q output of tffd */
	assign #T_TRI  fava = !futy ? done : 'z; /* takes !q output of tffd */
	assign #T_TRI  fajy = !futy ? dynu : 'z; /* takes !q output of tffd */
	assign #T_TRI  fegu = !futy ? ezof : 'z; /* takes !q output of tffd */
	assign #T_TRI  fose = !futy ? cyvo : 'z; /* takes !q output of tffd */
	assign #T_TRI  gero = !futy ? fuxo : 'z; /* takes !q output of tffd */
	assign #T_TRI  gaky = !futy ? gano : 'z; /* takes !q output of tffd */
	assign #T_TRI  gadu = !futy ? goca : 'z; /* takes !q output of tffd */
	assign #T_TRI  gazo = !futy ? gane : 'z; /* takes !q output of tffd */
	assign #T_INV  foge = !ncpu_rd;
	assign #T_NAND fape = !(foge && net03);
	assign #T_NAND deta = !(apu_wr && ff19);
	assign #T_INV  gote = !ff19;
	assign #T_OR   hypo = gote || fape;
	assign #T_INV  gala = !gane_nq;
	assign #T_TRI  jeke = !hypo ? hero : 'z; /* takes !q output of tffd */
	assign #T_TRI  jaro = !hypo ? hepu : 'z; /* takes !q output of tffd */
	assign #T_TRI  huna = !hypo ? hevy : 'z; /* takes !q output of tffd */
	assign gane_nq   = !gane;
	assign d         = { gazo, gadu, gaky, gero, fose, fegu, fajy, fava };
	assign ff19_d7   = etap;
	assign ch2_ftick = hero;
	assign d[2]      = jeke;
	assign d[1]      = jaro;
	assign d[0]      = huna;

	logic gado, huma, evyf, fazo, emer, gojy;
	dffr_a dffr_emer(evyf, fazo, d[6], emer); // check clk edge
	assign #T_INV  gado = !ncpu_rd;
	assign #T_NAND huma = !(ff19 && gado);
	assign #T_NAND evyf = !(anuj && ff19);
	assign #T_INV  fazo = !apu_reset;
	assign #T_TRI  gojy = !huma ? !emer : 'z;
	assign ff19_d6  = emer;
	assign nff19_d6 = !emer;
	assign d[6]     = gojy;

endmodule
