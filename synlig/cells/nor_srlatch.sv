`timescale 1ns/1ns
`default_nettype none

module nor_srlatch(
		input  logic s, r,
		output logic q, nq
	);

	$sr #(
		.WIDTH(1),
		.SET_POLARITY(1'b1),
		.CLR_POLARITY(1'b1)
	) sr (
		.SET(s),
		.CLR(r),
		.Q(q),
	);


	// TODO: the original cell could latch to 0,0 if `s` and `r` goes directly
	// from 1,1 to 0,0, but hopefully that is not a behavor the system relies
	// on (it would also be very unstable, I believe).
	assign nq = (~q) && (~s);

endmodule
