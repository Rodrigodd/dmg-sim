`default_nettype none

module dffr_bp #(
		parameter logic INITIAL_Q = '0
	) (
		input  logic clk, nreset, d,
		(*init=1'b0*)
		output logic q
	);


	$dffsr #(
		.WIDTH(1),
		.CLK_POLARITY(1'b1),
		.SET_POLARITY(1'b1),
		.CLR_POLARITY(1'b0),
	) dffsr (
		.CLK(clk),
		.SET(1'b0),
		.CLR(nreset),
		.D(d),
		.Q(q)
	);

	// bit ff, initff;
	// initial begin
	// 	initff = /*isunknown(INITIAL_Q))*/0 ? /*random*/0 : INITIAL_Q;
	// 	ff     = initff;
	// end
	//
	// always_ff @(posedge clk, negedge nreset) begin
	// 	if (nreset)
	// 		ff <= /*isunknown(d))*/0 ? initff : d;
	// 	else
	// 		ff <= 0;
	// end
	//
	// assign #T_DFFR_BP q = ff;

endmodule
