`timescale 1ns/1ns
`default_nettype none

// Toogle flip-flop with asynchronous load
module tffd #(
		parameter logic INITIAL_Q = '0
	) (
		input  logic nclk, load, d,
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

endmodule
