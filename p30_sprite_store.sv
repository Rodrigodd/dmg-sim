`default_nettype none

module sprite_store(
		input logic [7:0] oam_a,

		input logic xupy, buza, fepo, dege, daby, dabu, gysa,
		input logic deny, akol, xyme, wuse, gowo, wylu, gugy, fefo, dydo, byvy,
		input logic gygy, dymo, gyma, feka, fame, buzy, fado, wufa, furo, geny,
		input logic bymy, zuru, ewot, wabe, ahof, bucy, xyha, fuke, faka, enob,

		output logic weza, wuco, wyda, zysu, wyse, wuzy,
		output logic wenu, cucu, cuca, cega
	);

	logic cyke, wuda, xecu, yduf, xobe, zuze, xedy, xadu;
	logic weza_o, wuco_o, wyda_o, zysu_o, wyse_o, wuzy_o;
	logic wenu_o, cucu_o, cuca_o, cega_o;
	logic adyb, apob, apyv, afen, akyh, apoc, bujy, boso, ahac, bazu;
	logic axuv, bada, apev, bado, bexy, byhe, afym, azap, afut, afyx;
	logic wocy, elyc, wabo, ezoc, wywy, wato, zudo, ybuk, zyto, ykoz;
	logic gecu, foxy, gohu, fogo, gacy, gabo, zube, zumy, zexo, zafu;
	logic waja, woxy, xyre, weru, wepy, wuxu, bydo, buce, bove, bevy;
	logic xynu, xege, xabo, wanu, xefe, xave, cumu, capo, cono, caju;
	logic evyt, waba, etad, elep, wygo, wako, wana, waxe, wabu, ypoz;
	logic fuzo, gesy, fysu, fefa, gyno, gule, xygo, xyna, xaku, ygum;
	logic bemo, cyby, bety, cegy, celu, cubo, befe, byro, baco, ahum;
	logic cajy, cuza, coma, cufa, cebo, cadu, abug, ames, abop, arof;
	logic dalo, daly, duza, waga, dyny, dobo, awat, bace, bodu, buja;
	logic ekap, etav, ebex, goru, etym, ekop, aned, acep, abux, abeg;
	logic dezu, efud, dony, dowa, dygo, enap, zypo, zexe, yjem, ywav;
	logic dafu, deba, duha, duny, dese, devy, zury, zuro, zene, zylu;
	logic axec, cyro, cuvu, apon, afoz, cube, zaby, zuke, wuxe, were;
	logic boxa, buna, bulu, beca, byhu, buhe, ykuk, ylov, xazy, xosy;
	logic yhal, yrad, xyra, ynev, zojy, zaro, cawo, byme, coho, gate;
	logic xufo, xute, xotu, xyfe, yzor, yber, dewu, cana, dysy, fofo;
	logic zetu, zece, zave, woko, zumu, zedy, gofo, wehe, ajal, buky;
	logic ygus, ysok, yzep, wyte, zony, ywak, fyhy, gyho, bozu, cufo;
	dffr_b dffr_xecu(!cyke, '1, oam_a[7], xecu);
	dffr_b dffr_yduf(!cyke, '1, oam_a[6], yduf);
	dffr_b dffr_xobe(!cyke, '1, oam_a[5], xobe);
	dffr_b dffr_zuze(!cyke, '1, oam_a[4], zuze);
	dffr_b dffr_xedy(!cyke, '1, oam_a[3], xedy);
	dffr_b dffr_xadu(!cyke, '1, oam_a[2], xadu);
	dff dff_axuv(akol, weza, axuv);
	dff dff_bada(akol, wuco, bada);
	dff dff_apev(akol, wyda, apev);
	dff dff_bado(akol, zysu, bado);
	dff dff_bexy(akol, wyse, bexy);
	dff dff_byhe(akol, wuzy, byhe);
	dff dff_afym(bymy, wenu, afym);
	dff dff_azap(bymy, cucu, azap);
	dff dff_afut(bymy, cega, afut);
	dff dff_afyx(bymy, cuca, afyx);
	dff dff_gecu(wuse, weza, gecu);
	dff dff_foxy(wuse, wuco, foxy);
	dff dff_gohu(wuse, wyda, gohu);
	dff dff_fogo(wuse, zysu, fogo);
	dff dff_gacy(wuse, wyse, gacy);
	dff dff_gabo(wuse, wuzy, gabo);
	dff dff_zube(zuru, wenu, zube);
	dff dff_zumy(zuru, cucu, zumy);
	dff dff_zexo(zuru, cega, zexo);
	dff dff_zafu(zuru, cuca, zafu);
	dff dff_xynu(wylu, weza, xynu);
	dff dff_xege(wylu, wuco, xege);
	dff dff_xabo(wylu, wyda, xabo);
	dff dff_wanu(wylu, zysu, wanu);
	dff dff_xefe(wylu, wyse, xefe);
	dff dff_xave(wylu, wuzy, xave);
	dff dff_cumu(ewot, wenu, cumu);
	dff dff_capo(ewot, cucu, capo);
	dff dff_cono(ewot, cega, cono);
	dff dff_caju(ewot, cuca, caju);
	dff dff_fuzo(fefo, weza, fuzo);
	dff dff_gesy(fefo, wuco, gesy);
	dff dff_fysu(fefo, wyda, fysu);
	dff dff_fefa(fefo, zysu, fefa);
	dff dff_gyno(fefo, wyse, gyno);
	dff dff_gule(fefo, wuzy, gule);
	dff dff_xygo(wabe, wenu, xygo);
	dff dff_xyna(wabe, cucu, xyna);
	dff dff_xaku(wabe, cega, xaku);
	dff dff_ygum(wabe, cuca, ygum);
	dff dff_cajy(byvy, weza, cajy);
	dff dff_cuza(byvy, wuco, cuza);
	dff dff_coma(byvy, wyda, coma);
	dff dff_cufa(byvy, zysu, cufa);
	dff dff_cebo(byvy, wyse, cebo);
	dff dff_cadu(byvy, wuzy, cadu);
	dff dff_abug(ahof, wenu, abug);
	dff dff_ames(ahof, cucu, ames);
	dff dff_abop(ahof, cega, abop);
	dff dff_arof(ahof, cuca, arof);
	dff dff_ekap(dymo, weza, ekap);
	dff dff_etav(dymo, wuco, etav);
	dff dff_ebex(dymo, wyda, ebex);
	dff dff_goru(dymo, zysu, goru);
	dff dff_etym(dymo, wyse, etym);
	dff dff_ekop(dymo, wuzy, ekop);
	dff dff_aned(bucy, wenu, aned);
	dff dff_acep(bucy, cucu, acep);
	dff dff_abux(bucy, cega, abux);
	dff dff_abeg(bucy, cuca, abeg);
	dff dff_dafu(feka, weza, dafu);
	dff dff_deba(feka, wuco, deba);
	dff dff_duha(feka, wyda, duha);
	dff dff_duny(feka, zysu, duny);
	dff dff_dese(feka, wyse, dese);
	dff dff_devy(feka, wuzy, devy);
	dff dff_zury(xyha, wenu, zury);
	dff dff_zuro(xyha, cucu, zuro);
	dff dff_zene(xyha, cega, zene);
	dff dff_zylu(xyha, cuca, zylu);
	dff dff_boxa(buzy, weza, boxa);
	dff dff_buna(buzy, wuco, buna);
	dff dff_bulu(buzy, wyda, bulu);
	dff dff_beca(buzy, zysu, beca);
	dff dff_byhu(buzy, wyse, byhu);
	dff dff_buhe(buzy, wuzy, buhe);
	dff dff_ykuk(fuke, wenu, ykuk);
	dff dff_ylov(fuke, cucu, ylov);
	dff dff_xazy(fuke, cega, xazy);
	dff dff_xosy(fuke, cuca, xosy);
	dff dff_xufo(wufa, weza, xufo);
	dff dff_xute(wufa, wuco, xute);
	dff dff_xotu(wufa, wyda, xotu);
	dff dff_xyfe(wufa, zysu, xyfe);
	dff dff_yzor(wufa, wyse, yzor);
	dff dff_yber(wufa, wuzy, yber);
	dff dff_dewu(faka, wenu, dewu);
	dff dff_cana(faka, cucu, cana);
	dff dff_dysy(faka, cega, dysy);
	dff dff_fofo(faka, cuca, fofo);
	dff dff_ygus(geny, weza, ygus);
	dff dff_ysok(geny, wuco, ysok);
	dff dff_yzep(geny, wyda, yzep);
	dff dff_wyte(geny, zysu, wyte);
	dff dff_zony(geny, wyse, zony);
	dff dff_ywak(geny, wuzy, ywak);
	dff dff_fyhy(enob, wenu, fyhy);
	dff dff_gyho(enob, cucu, gyho);
	dff dff_bozu(enob, cega, bozu);
	dff dff_cufo(enob, cuca, cufo);
	assign #T_INV  cyke = !xupy;
	assign #T_INV  wuda = !cyke;
	assign #T_TRI  weza_o = !buza ? !(!xecu) : 'z;
	assign #T_TRI  wuco_o = !buza ? !(!yduf) : 'z;
	assign #T_TRI  wyda_o = !buza ? !(!xobe) : 'z;
	assign #T_TRI  zysu_o = !buza ? !(!zuze) : 'z;
	assign #T_TRI  wyse_o = !buza ? !(!xedy) : 'z;
	assign #T_TRI  wuzy_o = !buza ? !(!xadu) : 'z;
	assign #T_TRI  wenu_o = !fepo ? !gysa : 'z;
	assign #T_TRI  cucu_o = !fepo ? !dege : 'z;
	assign #T_TRI  cega_o = !fepo ? !dabu : 'z;
	assign #T_TRI  cuca_o = !fepo ? !daby : 'z;
	assign #T_TRI  adyb = !deny ? !(!axuv) : 'z;
	assign #T_TRI  apob = !deny ? !(!bada) : 'z;
	assign #T_TRI  apyv = !deny ? !(!apev) : 'z;
	assign #T_TRI  afen = !deny ? !(!bado) : 'z;
	assign #T_TRI  akyh = !deny ? !(!bexy) : 'z;
	assign #T_TRI  apoc = !deny ? !(!byhe) : 'z;
	assign #T_TRI  bujy = !deny ? !(!afym) : 'z;
	assign #T_TRI  boso = !deny ? !(!azap) : 'z;
	assign #T_TRI  ahac = !deny ? !(!afut) : 'z;
	assign #T_TRI  bazu = !deny ? !(!afyx) : 'z;
	assign #T_TRI  wocy = !xyme ? !(!gecu) : 'z;
	assign #T_TRI  elyc = !xyme ? !(!foxy) : 'z;
	assign #T_TRI  wabo = !xyme ? !(!gohu) : 'z;
	assign #T_TRI  ezoc = !xyme ? !(!fogo) : 'z;
	assign #T_TRI  wywy = !xyme ? !(!gacy) : 'z;
	assign #T_TRI  wato = !xyme ? !(!gabo) : 'z;
	assign #T_TRI  zudo = !xyme ? !(!zube) : 'z;
	assign #T_TRI  ybuk = !xyme ? !(!zumy) : 'z;
	assign #T_TRI  zyto = !xyme ? !(!zexo) : 'z;
	assign #T_TRI  ykoz = !xyme ? !(!zafu) : 'z;
	assign #T_TRI  waja = !gowo ? !(!xynu) : 'z;
	assign #T_TRI  woxy = !gowo ? !(!xege) : 'z;
	assign #T_TRI  xyre = !gowo ? !(!xabo) : 'z;
	assign #T_TRI  weru = !gowo ? !(!wanu) : 'z;
	assign #T_TRI  wepy = !gowo ? !(!xefe) : 'z;
	assign #T_TRI  wuxu = !gowo ? !(!xave) : 'z;
	assign #T_TRI  bydo = !gowo ? !(!cumu) : 'z;
	assign #T_TRI  buce = !gowo ? !(!capo) : 'z;
	assign #T_TRI  bove = !gowo ? !(!cono) : 'z;
	assign #T_TRI  bevy = !gowo ? !(!caju) : 'z;
	assign #T_TRI  evyt = !gugy ? !(!fuzo) : 'z;
	assign #T_TRI  waba = !gugy ? !(!gesy) : 'z;
	assign #T_TRI  etad = !gugy ? !(!fysu) : 'z;
	assign #T_TRI  elep = !gugy ? !(!fefa) : 'z;
	assign #T_TRI  wygo = !gugy ? !(!gyno) : 'z;
	assign #T_TRI  wako = !gugy ? !(!gule) : 'z;
	assign #T_TRI  wana = !gugy ? !(!xygo) : 'z;
	assign #T_TRI  waxe = !gugy ? !(!xyna) : 'z;
	assign #T_TRI  wabu = !gugy ? !(!xaku) : 'z;
	assign #T_TRI  ypoz = !gugy ? !(!ygum) : 'z;
	assign #T_TRI  bemo = !dydo ? !(!cajy) : 'z;
	assign #T_TRI  cyby = !dydo ? !(!cuza) : 'z;
	assign #T_TRI  bety = !dydo ? !(!coma) : 'z;
	assign #T_TRI  cegy = !dydo ? !(!cufa) : 'z;
	assign #T_TRI  celu = !dydo ? !(!cebo) : 'z;
	assign #T_TRI  cubo = !dydo ? !(!cadu) : 'z;
	assign #T_TRI  befe = !dydo ? !(!abug) : 'z;
	assign #T_TRI  byro = !dydo ? !(!ames) : 'z;
	assign #T_TRI  baco = !dydo ? !(!abop) : 'z;
	assign #T_TRI  ahum = !dydo ? !(!arof) : 'z;
	assign #T_TRI  dalo = !gygy ? !(!ekap) : 'z;
	assign #T_TRI  daly = !gygy ? !(!etav) : 'z;
	assign #T_TRI  duza = !gygy ? !(!ebex) : 'z;
	assign #T_TRI  waga = !gygy ? !(!goru) : 'z;
	assign #T_TRI  dyny = !gygy ? !(!etym) : 'z;
	assign #T_TRI  dobo = !gygy ? !(!ekop) : 'z;
	assign #T_TRI  awat = !gygy ? !(!aned) : 'z;
	assign #T_TRI  bace = !gygy ? !(!acep) : 'z;
	assign #T_TRI  bodu = !gygy ? !(!abux) : 'z;
	assign #T_TRI  buja = !gygy ? !(!abeg) : 'z;
	assign #T_TRI  dezu = !gyma ? !(!dafu) : 'z;
	assign #T_TRI  efud = !gyma ? !(!deba) : 'z;
	assign #T_TRI  dony = !gyma ? !(!duha) : 'z;
	assign #T_TRI  dowa = !gyma ? !(!duny) : 'z;
	assign #T_TRI  dygo = !gyma ? !(!dese) : 'z;
	assign #T_TRI  enap = !gyma ? !(!devy) : 'z;
	assign #T_TRI  zypo = !gyma ? !(!zury) : 'z;
	assign #T_TRI  zexe = !gyma ? !(!zuro) : 'z;
	assign #T_TRI  yjem = !gyma ? !(!zene) : 'z;
	assign #T_TRI  ywav = !gyma ? !(!zylu) : 'z;
	assign #T_TRI  axec = !fame ? !(!boxa) : 'z;
	assign #T_TRI  cyro = !fame ? !(!buna) : 'z;
	assign #T_TRI  cuvu = !fame ? !(!bulu) : 'z;
	assign #T_TRI  apon = !fame ? !(!beca) : 'z;
	assign #T_TRI  afoz = !fame ? !(!byhu) : 'z;
	assign #T_TRI  cube = !fame ? !(!buhe) : 'z;
	assign #T_TRI  zaby = !fame ? !(!ykuk) : 'z;
	assign #T_TRI  zuke = !fame ? !(!ylov) : 'z;
	assign #T_TRI  wuxe = !fame ? !(!xazy) : 'z;
	assign #T_TRI  were = !fame ? !(!xosy) : 'z;
	assign #T_TRI  yhal = !fado ? !(!xufo) : 'z;
	assign #T_TRI  yrad = !fado ? !(!xute) : 'z;
	assign #T_TRI  xyra = !fado ? !(!xotu) : 'z;
	assign #T_TRI  ynev = !fado ? !(!xyfe) : 'z;
	assign #T_TRI  zojy = !fado ? !(!yzor) : 'z;
	assign #T_TRI  zaro = !fado ? !(!yber) : 'z;
	assign #T_TRI  cawo = !fado ? !(!dewu) : 'z;
	assign #T_TRI  byme = !fado ? !(!cana) : 'z;
	assign #T_TRI  coho = !fado ? !(!dysy) : 'z;
	assign #T_TRI  gate = !fado ? !(!fofo) : 'z;
	assign #T_TRI  zetu = !furo ? !(!ygus) : 'z;
	assign #T_TRI  zece = !furo ? !(!ysok) : 'z;
	assign #T_TRI  zave = !furo ? !(!yzep) : 'z;
	assign #T_TRI  woko = !furo ? !(!wyte) : 'z;
	assign #T_TRI  zumu = !furo ? !(!zony) : 'z;
	assign #T_TRI  zedy = !furo ? !(!ywak) : 'z;
	assign #T_TRI  gofo = !furo ? !(!fyhy) : 'z;
	assign #T_TRI  wehe = !furo ? !(!gyho) : 'z;
	assign #T_TRI  ajal = !furo ? !(!bozu) : 'z;
	assign #T_TRI  buky = !furo ? !(!cufo) : 'z;
	assign weza_tri = weza_o;
	assign wuco_tri = wuco_o;
	assign wyda_tri = wyda_o;
	assign zysu_tri = zysu_o;
	assign wyse_tri = wyse_o;
	assign wuzy_tri = wuzy_o;
	assign wenu_tri = wenu_o;
	assign cucu_tri = cucu_o;
	assign cega_tri = cega_o;
	assign cuca_tri = cuca_o;
	assign weza_tri = adyb;
	assign wuco_tri = apob;
	assign wyda_tri = apyv;
	assign zysu_tri = afen;
	assign wyse_tri = akyh;
	assign wuzy_tri = apoc;
	assign wenu_tri = bujy;
	assign cucu_tri = boso;
	assign cega_tri = ahac;
	assign cuca_tri = bazu;
	assign weza_tri = wocy;
	assign wuco_tri = elyc;
	assign wyda_tri = wabo;
	assign zysu_tri = ezoc;
	assign wyse_tri = wywy;
	assign wuzy_tri = wato;
	assign wenu_tri = zudo;
	assign cucu_tri = ybuk;
	assign cega_tri = zyto;
	assign cuca_tri = ykoz;
	assign weza_tri = waja;
	assign wuco_tri = woxy;
	assign wyda_tri = xyre;
	assign zysu_tri = weru;
	assign wyse_tri = wepy;
	assign wuzy_tri = wuxu;
	assign wenu_tri = bydo;
	assign cucu_tri = buce;
	assign cega_tri = bove;
	assign cuca_tri = bevy;
	assign weza_tri = evyt;
	assign wuco_tri = waba;
	assign wyda_tri = etad;
	assign zysu_tri = elep;
	assign wyse_tri = wygo;
	assign wuzy_tri = wako;
	assign wenu_tri = wana;
	assign cucu_tri = waxe;
	assign cega_tri = wabu;
	assign cuca_tri = ypoz;
	assign weza_tri = bemo;
	assign wuco_tri = cyby;
	assign wyda_tri = bety;
	assign zysu_tri = cegy;
	assign wyse_tri = celu;
	assign wuzy_tri = cubo;
	assign wenu_tri = befe;
	assign cucu_tri = byro;
	assign cega_tri = baco;
	assign cuca_tri = ahum;
	assign weza_tri = dalo;
	assign wuco_tri = daly;
	assign wyda_tri = duza;
	assign zysu_tri = waga;
	assign wyse_tri = dyny;
	assign wuzy_tri = dobo;
	assign wenu_tri = awat;
	assign cucu_tri = bace;
	assign cega_tri = bodu;
	assign cuca_tri = buja;
	assign weza_tri = dezu;
	assign wuco_tri = efud;
	assign wyda_tri = dony;
	assign zysu_tri = dowa;
	assign wyse_tri = dygo;
	assign wuzy_tri = enap;
	assign wenu_tri = zypo;
	assign cucu_tri = zexe;
	assign cega_tri = yjem;
	assign cuca_tri = ywav;
	assign weza_tri = axec;
	assign wuco_tri = cyro;
	assign wyda_tri = cuvu;
	assign zysu_tri = apon;
	assign wyse_tri = afoz;
	assign wuzy_tri = cube;
	assign wenu_tri = zaby;
	assign cucu_tri = zuke;
	assign cega_tri = wuxe;
	assign cuca_tri = were;
	assign weza_tri = yhal;
	assign wuco_tri = yrad;
	assign wyda_tri = xyra;
	assign zysu_tri = ynev;
	assign wyse_tri = zojy;
	assign wuzy_tri = zaro;
	assign wenu_tri = cawo;
	assign cucu_tri = byme;
	assign cega_tri = coho;
	assign cuca_tri = gate;
	assign weza_tri = zetu;
	assign wuco_tri = zece;
	assign wyda_tri = zave;
	assign zysu_tri = woko;
	assign wyse_tri = zumu;
	assign wuzy_tri = zedy;
	assign wenu_tri = gofo;
	assign cucu_tri = wehe;
	assign cega_tri = ajal;
	assign cuca_tri = buky;
	assign weza = weza_tri;
	assign wuco = wuco_tri;
	assign wyda = wyda_tri;
	assign zysu = zysu_tri;
	assign wyse = wyse_tri;
	assign wuzy = wuzy_tri;
	assign wenu = wenu_tri;
	assign cucu = cucu_tri;
	assign cega = cega_tri;
	assign cuca = cuca_tri;

	/* Icarus doesn't support trireg, so we do it like this: */
	tri logic weza_tri, wuco_tri, wyda_tri, zysu_tri, wyse_tri, wuzy_tri;
	tri logic wenu_tri, cucu_tri, cuca_tri, cega_tri;
	logic     weza_cap = $random, wuco_cap = $random, wyda_cap = $random, zysu_cap = $random;
	logic     wyse_cap = $random, wuzy_cap = $random;
	logic     wenu_cap = $random, cucu_cap = $random, cuca_cap = $random, cega_cap = $random;
	always @(weza_tri) weza_cap = weza_tri;
	always @(wuco_tri) wuco_cap = wuco_tri;
	always @(wyda_tri) wyda_cap = wyda_tri;
	always @(zysu_tri) zysu_cap = zysu_tri;
	always @(wyse_tri) wyse_cap = wyse_tri;
	always @(wuzy_tri) wuzy_cap = wuzy_tri;
	always @(wenu_tri) wenu_cap = wenu_tri;
	always @(cucu_tri) cucu_cap = cucu_tri;
	always @(cuca_tri) cuca_cap = cuca_tri;
	always @(cega_tri) cega_cap = cega_tri;
	assign (weak1, weak0) weza_tri = weza_cap;
	assign (weak1, weak0) wuco_tri = wuco_cap;
	assign (weak1, weak0) wyda_tri = wyda_cap;
	assign (weak1, weak0) zysu_tri = zysu_cap;
	assign (weak1, weak0) wyse_tri = wyse_cap;
	assign (weak1, weak0) wuzy_tri = wuzy_cap;
	assign (weak1, weak0) wenu_tri = wenu_cap;
	assign (weak1, weak0) cucu_tri = cucu_cap;
	assign (weak1, weak0) cuca_tri = cuca_cap;
	assign (weak1, weak0) cega_tri = cega_cap;

endmodule
