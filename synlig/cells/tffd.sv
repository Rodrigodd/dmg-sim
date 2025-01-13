`timescale 1ns/1ns
`default_nettype none

// Toogle flip-flop with asynchronous load
module tffd #(
		parameter logic INITIAL_Q = '0
	) (
		input  logic nclk, load, d,
		(*init=1'b0*)
		output logic q
	);

	$dffsr #(
		.WIDTH(1),
		.CLK_POLARITY(1'b0),
		.SET_POLARITY(1'b1),
		.CLR_POLARITY(1'b1),
	) dffsr (
		.CLK(nclk),
		.SET(load & d),
		.CLR(load & ~d),
		.D(~q),
		.Q(q)
	);

	// bit ff, initff;
	// initial begin
	// 	initff = /*isunknown(INITIAL_Q))*/0 ? /*random*/0 : INITIAL_Q;
	// 	ff     = initff;
	// end
	//
	// bit load_negedge;
	// initial load_negedge = 0;
	// always @(negedge load) load_negedge <= 1;
	//
	// always @(negedge nclk, posedge load_negedge) begin
	// 	if (load_negedge)
	// 		ff <= /*isunknown(d))*/0 ? initff : d;
	// 	else
	// 		ff <= ~ff;
	//
	// 	if (load_negedge)
	// 		load_negedge <= 0;
	// end
	//
	// assign q = load ? d : ff;

endmodule
