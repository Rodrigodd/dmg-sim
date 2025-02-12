`timescale 1ns/1ns
`default_nettype none

// D flip-flop with asynchronous set and reset
module dffsr #(
		parameter logic INITIAL_Q = '0
	) (
		input  logic clk, nset, nreset, d,
		output logic q
	);

	// $dffsr #(
	// 	.WIDTH(1),
	// 	.CLK_POLARITY(1'b1),
	// 	.SET_POLARITY(1'b0),
	// 	.CLR_POLARITY(1'b0),
	// ) dffsr (
	// 	.CLK(clk),
	// 	.SET(nset),
	// 	.CLR(nreset),
	// 	.D(d),
	// 	.Q(q)
	// );

	bit ff;
	initial begin
		ff <=  INITIAL_Q;
	end

	bit nset_posedge;
	initial nset_posedge = 0;
	always @(posedge nset) nset_posedge <= 1;

	bit nreset_posedge;
	initial nreset_posedge = 0;
	always @(posedge nreset) nreset_posedge <= 1;

	wire set = ~nset;
	wire reset = ~nreset;

	always @(posedge clk , posedge set, posedge reset) begin
		if (reset)
			ff <= 0;
		else if (set)
			ff <= 1;
		else
			ff <= d;
	end

	assign q = ff;

endmodule
