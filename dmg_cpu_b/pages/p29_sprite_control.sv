`default_nettype none

module sprite_control(
		inout tri logic [7:0]  d,
		input logic     [7:0]  oam_b_nd, v,
		inout tri logic [12:0] nma,

		input logic clk1, clk2, clk3, clk4, clk5, reset_video, nreset_video, oam_b_cpu_nrd,

		input logic ff40_d1, ff40_d2,

		input  logic nxymu, ynaz, ykok, zure, ywos, ekes, cehu, ewam, cyvy, zako, xeba,
		input  logic ylev, ytub, feha, dama, cyco, daje, ydot, ywap, fyma, cogy, byva,
		input  logic cota, nyzos, sela, xyvo, anom, feto, seca, nbaxo, azyb,
		input  logic wenu, cucu, cuca, cega, besu,
		output logic fepo, fado, deny, gugy, xyme, gygy, gowo, gyma, fame, dydo, furo,
		output logic wuty, dosy, wuzo, gafy, xaho, ejad, wunu, wupa, gamy, doku, dyna,
		output logic texy, dege, daby, dabu, gysa, wuvu_nq, xupy, abez, xoce, catu, xyso,
		output logic buza, avap, tyfo_nq, tuvo, tacu, xefy, xono, xado, puco,
		output logic cacu, buzy, fuke, zape, wuse, zuru, fefo, gecy, wabe,
		output logic feka, xyha, yfag, cexu, akol, bymy, fuxu, enob, geny,
		output logic weme, wufa, faka, cyla, dymo, bucy, wofo, wylu, ewot,
		output logic asys, ahof, byvy
	);

	logic byjo, azem, aror, xage, yloz, dego, dydu, ydug, ygem, efyl, dyka, ybez, egom;
	logic fefy, fove, wefu, geze, guva, gaja, fuma, enut, gupo, gede, emol, webo, wuto;
	logic gyfy, wuna, xyla, gono, gaba, weja, gega, wase, wyla, xoja, gyte, favo, gutu;
	logic geke, gyga, foxa, guze;
	logic dyba, fono, exuq, wapo, womy, wafy, xudy, gota, egav, cedy, eboj;
	logic dubu, goro, guky, wacy, feve, wohu, gake, foko, efev, dywe;

	logic yceb, zuca, WONE, zaxe, xafu, yses, zeca, ydyv;
	logic xele, ypon, xuvo, zysa, yweg, xabu, ytux, yfap;
	logic ywok, xegu, yjex, xyju, ybog, wyso, xote, yzab, xuso;
	logic abon, fugy, gavo, wyga, wune, gotu, gegu, xehe;
	logic ebos, dasa, fuky, fuve, fepu, fofa, femo, gusu;
	logic eruc, enef, feco, gyky, gopu, fuwa, goju, wuhu;
	logic eruc_c, enef_c, feco_c, gyky_c, gopu_c, fuwa_c, goju_c, wuhu_c;
	logic gace, guvu, gyda, gewy, govu, wota, gese, spr_match;
	logic tobu, vonu, wuky, wago, cyvu, bore, buvy, xuqu;
	logic baxe, aras, agag, abem, dyso, fufo, gejy, famu;

	logic xyva, xota, xyfy, wuvu, ales, abov, balu, wosu, bagy, wojo, ceno, byba;
	logic ceha, doba, care, bebu, dyty;

	logic seba, toxe, tuly, tese, tepa, tyfo, tyno, saky, tytu, toma;
	logic vusa, tyso, tame, sycu, topu, raca, vywa, peby, weny, nybe;

	logic baky, dezy, cake, bese, cuxy, bego, dybe;
	logic eden, cypy, cape, caxu, fycu, fone, ekud, elyg;
	logic gebu, womu, guna, foco, dewy, dezo, dogu, cugu, cupe, cuva;
	logic wyxo, xujo, gape, guve, caho, cemy, cato, cado, cecu, byby;
	logic gyfo, weka, gyvo, gusa, buka, dyhu, decu, bede, duke, buco;

	dffr_bp dffr_fono(wuty, byva, guze, fono);
	dffr_bp dffr_exuq(wuty, byva, foxa, exuq);
	dffr_bp dffr_wapo(wuty, byva, gutu, wapo);
	dffr_bp dffr_womy(wuty, byva, xoja, womy);
	dffr_bp dffr_wafy(wuty, byva, gega, wafy);
	dffr_bp dffr_xudy(wuty, byva, gono, xudy);
	dffr_bp dffr_gota(wuty, byva, gyfy, gota);
	dffr_bp dffr_egav(wuty, byva, emol, egav);
	dffr_bp dffr_cedy(wuty, byva, enut, cedy);
	dffr_bp dffr_eboj(wuty, byva, guva, eboj);
	assign #T_INV  byjo = !ceha;
	assign #T_AND  azem = byjo && nxymu;
	assign #T_AND  aror = azem && ff40_d1;
	assign #T_NAND xage = !(aror && ynaz && ykok);
	assign #T_NAND yloz = !(aror && zure && ywos);
	assign #T_NAND dego = !(aror && ekes && cehu);
	assign #T_NAND dydu = !(aror && ewam && cyvy);
	assign #T_NAND ydug = !(aror && zako && xeba);
	assign #T_NAND ygem = !(aror && ylev && ytub);
	assign #T_NAND efyl = !(aror && feha && dama);
	assign #T_NAND dyka = !(aror && cyco && daje);
	assign #T_NAND ybez = !(aror && ydot && ywap);
	assign #T_NAND egom = !(aror && fyma && cogy);
	assign #T_NAND fefy = !(xage && yloz && dego && dydu && ydug);
	assign #T_NAND fove = !(ygem && efyl && dyka && ybez && egom);
	assign #T_OR   fepo = fefy || fove;
	assign #T_INV  wefu = !ydug;
	assign #T_OR   geze = wefu || '0;
	assign #T_NOR  guva = !(ydug || '0);
	assign #T_INV  gaja = !dydu;
	assign #T_OR   fuma = gaja || geze;
	assign #T_NOR  enut = !(dydu || geze);
	assign #T_INV  gupo = !dego;
	assign #T_OR   gede = gupo || fuma;
	assign #T_NOR  emol = !(dego || fuma);
	assign #T_INV  webo = !yloz;
	assign #T_OR   wuto = webo || gede;
	assign #T_NOR  gyfy = !(yloz || gede);
	assign #T_INV  wuna = !xage;
	assign #T_OR   xyla = wuna || wuto;
	assign #T_NOR  gono = !(xage || wuto);
	assign #T_INV  gaba = !egom;
	assign #T_OR   weja = gaba || xyla;
	assign #T_NOR  gega = !(egom || xyla);
	assign #T_INV  wase = !ybez;
	assign #T_OR   wyla = wase || weja;
	assign #T_NOR  xoja = !(ybez || weja);
	assign #T_INV  gyte = !dyka;
	assign #T_OR   favo = gyte || wyla;
	assign #T_NOR  gutu = !(dyka || wyla);
	assign #T_INV  geke = !efyl;
	assign #T_OR   gyga = geke || favo;
	assign #T_NOR  foxa = !(efyl || favo);
	assign #T_NOR  guze = !(ygem || gyga);
	assign #T_INV  fado = !guze;
	assign #T_INV  deny = !foxa;
	assign #T_INV  gugy = !gutu;
	assign #T_INV  xyme = !xoja;
	assign #T_INV  gygy = !gega;
	assign #T_INV  gowo = !gono;
	assign #T_INV  gyma = !gyfy;
	assign #T_INV  fame = !emol;
	assign #T_INV  dydo = !enut;
	assign #T_INV  furo = !guva;
	assign #T_INV  dyba = !byva;
	assign #T_OR   dubu = dyba || fono;
	assign #T_OR   goro = dyba || exuq;
	assign #T_OR   guky = dyba || wapo;
	assign #T_OR   wacy = dyba || womy;
	assign #T_OR   feve = dyba || wafy;
	assign #T_OR   wohu = dyba || xudy;
	assign #T_OR   gake = dyba || gota;
	assign #T_OR   foko = dyba || egav;
	assign #T_OR   efev = dyba || cedy;
	assign #T_OR   dywe = dyba || eboj;
	assign #T_INV  dosy = !dubu;
	assign #T_INV  wuzo = !goro;
	assign #T_INV  gafy = !guky;
	assign #T_INV  xaho = !wacy;
	assign #T_INV  ejad = !feve;
	assign #T_INV  wunu = !wohu;
	assign #T_INV  wupa = !gake;
	assign #T_INV  gamy = !foko;
	assign #T_INV  doku = !efev;
	assign #T_INV  dyna = !dywe;

	dffr_bp dffr_tobu(clk5, nxymu, tuly, tobu);
	dffr_bp dffr_vonu(clk5, nxymu, tobu, vonu);
	dlatch_a latch_xegu(!ywok, yceb, xegu);
	dlatch_a latch_yjex(!ywok, zuca, yjex);
	dlatch_a latch_xyju(!ywok, WONE, xyju);
	dlatch_a latch_ybog(!ywok, zaxe, ybog);
	dlatch_a latch_wyso(!ywok, xafu, wyso);
	dlatch_a latch_xote(!ywok, yses, xote);
	dlatch_a latch_yzab(!ywok, zeca, yzab);
	dlatch_a latch_xuso(!ywok, ydyv, xuso);
	dlatch_b latch_yceb(clk3, oam_b_nd[1], yceb);
	dlatch_b latch_zuca(clk3, oam_b_nd[2], zuca);
	dlatch_b latch_wone(clk3, oam_b_nd[3], WONE);
	dlatch_b latch_zaxe(clk3, oam_b_nd[4], zaxe);
	dlatch_b latch_xafu(clk3, oam_b_nd[5], xafu);
	dlatch_b latch_yses(clk3, oam_b_nd[6], yses);
	dlatch_b latch_zeca(clk3, oam_b_nd[7], zeca);
	dlatch_b latch_ydyv(clk3, oam_b_nd[0], ydyv);
	assign #T_TRIB xele = !oam_b_cpu_nrd ? !yceb : 'z;
	assign #T_TRIB ypon = !oam_b_cpu_nrd ? !zuca : 'z;
	assign #T_TRIB xuvo = !oam_b_cpu_nrd ? !WONE : 'z;
	assign #T_TRIB zysa = !oam_b_cpu_nrd ? !zaxe : 'z;
	assign #T_TRIB yweg = !oam_b_cpu_nrd ? !xafu : 'z;
	assign #T_TRIB xabu = !oam_b_cpu_nrd ? !yses : 'z;
	assign #T_TRIB ytux = !oam_b_cpu_nrd ? !zeca : 'z;
	assign #T_TRIB yfap = !oam_b_cpu_nrd ? !ydyv : 'z;
	assign #T_INV  ywok = !cota;
	assign #T_INV  abon = !texy;
	assign #T_TRI  fugy = !abon ? !(!xegu) : 'z;
	assign #T_TRI  gavo = !abon ? !(!yjex) : 'z;
	assign #T_TRI  wyga = !abon ? !(!xyju) : 'z;
	assign #T_TRI  wune = !abon ? !(!ybog) : 'z;
	assign #T_TRI  gotu = !abon ? !(!wyso) : 'z;
	assign #T_TRI  gegu = !abon ? !(!xote) : 'z;
	assign #T_TRI  xehe = !abon ? !(!yzab) : 'z;
	assign #T_INV  ebos = !v[0];
	assign #T_INV  dasa = !v[1];
	assign #T_INV  fuky = !v[2];
	assign #T_INV  fuve = !v[3];
	assign #T_INV  fepu = !v[4];
	assign #T_INV  fofa = !v[5];
	assign #T_INV  femo = !v[6];
	assign #T_INV  gusu = !v[7];
	assign #T_ADD  { eruc_c, eruc } = ebos + !xuso + '0;
	assign #T_ADD  { enef_c, enef } = dasa + !xegu + eruc_c;
	assign #T_ADD  { feco_c, feco } = fuky + !yjex + enef_c;
	assign #T_ADD  { gyky_c, gyky } = fuve + !xyju + feco_c;
	assign #T_ADD  { gopu_c, gopu } = fepu + !ybog + gyky_c;
	assign #T_ADD  { fuwa_c, fuwa } = fofa + !wyso + gopu_c;
	assign #T_ADD  { goju_c, goju } = femo + !xote + fuwa_c;
	assign #T_ADD  { wuhu_c, wuhu } = gusu + !yzab + goju_c;
	assign #T_INV  dege = !eruc;
	assign #T_INV  daby = !enef;
	assign #T_INV  dabu = !feco;
	assign #T_INV  gysa = !gyky;
	assign #T_INV  gace = !gopu;
	assign #T_INV  guvu = !fuwa;
	assign #T_INV  gyda = !goju;
	assign #T_INV  gewy = !wuhu;
	assign #T_OR   govu = ff40_d2 || gyky;
	assign #T_NAND wota = !(gace && guvu && gyda && gewy && wuhu_c && govu);
	assign #T_INV  gese = !wota;
	assign #T_INV  wuky = !nyzos;
	assign #T_XOR  wago = wuky != wenu;
	assign #T_XOR  cyvu = wuky != cucu;
	assign #T_XOR  bore = wuky != cuca;
	assign #T_XOR  buvy = wuky != cega;
	assign #T_INV  xuqu = !(!vonu);
	assign #T_TRI  baxe = !abon ? !cyvu : 'z;
	assign #T_TRI  aras = !abon ? !bore : 'z;
	assign #T_TRI  agag = !abon ? !buvy : 'z;
	assign #T_TRI  abem = !abon ? !xuqu : 'z;
	assign #T_TRI  dyso = !abon ? !0 : 'z;
	assign #T_INV  fufo = !ff40_d2;
	assign #T_AO   gejy = (!xuso && fufo) || (ff40_d2 && wago);
	assign #T_TRI  famu = !abon ? !gejy : 'z;
	assign d[1] = xele;
	assign d[2] = ypon;
	assign d[3] = xuvo;
	assign d[4] = zysa;
	assign d[5] = yweg;
	assign d[6] = xabu;
	assign d[7] = ytux;
	assign d[0] = yfap;
	assign nma[5]  = fugy;
	assign nma[6]  = gavo;
	assign nma[7]  = wyga;
	assign nma[8]  = wune;
	assign nma[9]  = gotu;
	assign nma[10] = gegu;
	assign nma[11] = xehe;
	assign nma[1]  = baxe;
	assign nma[2]  = aras;
	assign nma[3]  = agag;
	assign nma[0]  = abem;
	assign nma[12] = dyso;
	assign nma[4]  = famu;
	assign spr_match = gese;

	dffr_bp dffr_wuvu(xota, nreset_video, !wuvu, wuvu);
	dffr_bp dffr_wosu(xyfy, nreset_video, !wuvu, wosu);
	dffr_bp dffr_ceno(xupy, abez,         besu,  ceno);
	dffr_bp dffr_catu(xupy, abez,         abov,  catu);
	dffr_bp dffr_byba(xupy, bagy,         feto,  byba);
	dffr_bp dffr_doba(clk2, bagy,         byba,  doba);
	assign #T_INV  xyva = !clk1;
	assign #T_INV  xota = !xyva;
	assign #T_INV  xyfy = !xota;
	assign #T_INV  ales = !xyvo;
	assign #T_AND  abov = sela && ales;
	assign #T_INV  balu = !anom;
	assign #T_INV  xupy = !(!wuvu);
	assign #T_INV  abez = !reset_video;
	assign #T_INV  bagy = !balu;
	assign #T_NOR  wojo = !(!wosu || !wuvu);
	assign #T_INV  xoce = !wosu;
	assign #T_INV  xyso = !wojo;
	assign #T_INV  ceha = !(!ceno);
	assign #T_AND  buza = !ceno && nxymu;
	assign #T_AND  care = xoce && ceha && spr_match;
	assign #T_OR   bebu = doba || balu || !byba;
	assign #T_INV  dyty = !care;
	assign #T_INV  avap = !bebu;
	assign wuvu_nq = !wuvu;

	dffr_bp dffr_seba(clk4,  nxymu, vonu,  seba);
	dffr_bp dffr_toxe(toma,  seca,  !toxe, toxe);
	dffr_bp dffr_tuly(!toxe, seca,  !tuly, tuly);
	dffr_bp dffr_tese(!tuly, seca,  !tese, tese);
	dffr_bp dffr_tyfo(clk4,  '1,    toxe,  tyfo);
	assign #T_INV  tepa = !nxymu;
	assign #T_NAND tyno = !(toxe && seba && vonu);
	assign #T_NOR  saky = !(tuly || vonu);
	assign #T_INV  tytu = !toxe;
	assign #T_OR   vusa = !tyfo || tyno;
	assign #T_OR   tyso = saky || tepa;
	assign #T_NOR  tuvo = !(tepa || tuly || tese);
	assign #T_NAND tame = !(tese && toxe);
	assign #T_NOR  sycu = !(tytu || tepa || tyfo);
	assign #T_NAND tacu = !(tytu && tyfo);
	assign #T_INV  wuty = !vusa;
	assign #T_INV  texy = !tyso;
	assign #T_AND  topu = tuly && sycu;
	assign #T_AND  raca = vonu && sycu;
	assign #T_INV  xefy = !wuty;
	assign #T_AND  xono = nbaxo && texy;
	assign #T_NAND toma = !(clk4 && tame);
	assign #T_INV  vywa = !topu;
	assign #T_INV  peby = !raca;
	assign #T_INV  weny = !vywa;
	assign #T_INV  nybe = !peby;
	assign #T_INV  xado = !weny;
	assign #T_INV  puco = !nybe;
	assign tyfo_nq = !tyfo;

	dffr_bp dffr_dezy(clk1,  nreset_video, dyty,  dezy);
	dffr_bp dffr_bese(cake,  azyb,         !bese, bese);
	dffr_bp dffr_cuxy(!bese, azyb,         !cuxy, cuxy);
	dffr_bp dffr_bego(!cuxy, azyb,         !bego, bego);
	dffr_bp dffr_dybe(!bego, azyb,         !dybe, dybe);
	assign #T_AND  baky = cuxy && dybe;
	assign #T_OR   cake = baky || dezy;
	assign #T_INV  eden = !bese;
	assign #T_INV  cypy = !cuxy;
	assign #T_INV  cape = !bego;
	assign #T_INV  caxu = !dybe;
	assign #T_INV  fycu = !eden;
	assign #T_INV  fone = !cypy;
	assign #T_INV  ekud = !cape;
	assign #T_INV  elyg = !caxu;
	assign #T_NAND gebu = !(eden && fone && cape && caxu);
	assign #T_NAND womu = !(eden && fone && ekud && caxu);
	assign #T_NAND guna = !(fycu && fone && ekud && caxu);
	assign #T_NAND foco = !(fycu && fone && cape && caxu);
	assign #T_NAND dewy = !(eden && cypy && cape && elyg);
	assign #T_NAND dezo = !(eden && cypy && cape && caxu);
	assign #T_NAND dogu = !(fycu && cypy && cape && elyg);
	assign #T_NAND cugu = !(fycu && cypy && ekud && caxu);
	assign #T_NAND cupe = !(eden && cypy && ekud && caxu);
	assign #T_NAND cuva = !(fycu && cypy && cape && caxu);
	assign #T_OR   wyxo = dyty || gebu;
	assign #T_OR   xujo = dyty || womu;
	assign #T_OR   gape = dyty || guna;
	assign #T_OR   guve = dyty || foco;
	assign #T_OR   caho = dyty || dewy;
	assign #T_OR   cemy = dyty || dezo;
	assign #T_OR   cato = dyty || dogu;
	assign #T_OR   cado = dyty || cugu;
	assign #T_OR   cecu = dyty || cupe;
	assign #T_OR   byby = dyty || cuva;
	assign #T_INV  gyfo = !wyxo;
	assign #T_INV  weka = !xujo;
	assign #T_INV  gyvo = !gape;
	assign #T_INV  gusa = !guve;
	assign #T_INV  buka = !caho;
	assign #T_INV  dyhu = !cemy;
	assign #T_INV  decu = !cato;
	assign #T_INV  bede = !cado;
	assign #T_INV  duke = !cecu;
	assign #T_INV  buco = !byby;
	assign #T_INV  cacu = !gyfo;
	assign #T_INV  buzy = !gyfo;
	assign #T_INV  fuke = !gyfo;
	assign #T_INV  zape = !weka;
	assign #T_INV  wuse = !weka;
	assign #T_INV  zuru = !weka;
	assign #T_INV  fefo = !gyvo;
	assign #T_INV  gecy = !gyvo;
	assign #T_INV  wabe = !gyvo;
	assign #T_INV  feka = !gusa;
	assign #T_INV  xyha = !gusa;
	assign #T_INV  yfag = !gusa;
	assign #T_INV  cexu = !buka;
	assign #T_INV  akol = !buka;
	assign #T_INV  bymy = !buka;
	assign #T_INV  fuxu = !dyhu;
	assign #T_INV  enob = !dyhu;
	assign #T_INV  geny = !dyhu;
	assign #T_INV  weme = !decu;
	assign #T_INV  wufa = !decu;
	assign #T_INV  faka = !decu;
	assign #T_INV  cyla = !bede;
	assign #T_INV  dymo = !bede;
	assign #T_INV  bucy = !bede;
	assign #T_INV  wofo = !duke;
	assign #T_INV  wylu = !duke;
	assign #T_INV  ewot = !duke;
	assign #T_INV  asys = !buco;
	assign #T_INV  ahof = !buco;
	assign #T_INV  byvy = !buco;

endmodule
