`default_nettype none

module dlatch_a #(
		parameter logic INITIAL_Q = '0
	) (
		input  logic c, d,
		(*init=1'b0*)
		output logic q
	);

	$dlatch #(
		.WIDTH(1),
		.EN_POLARITY(1'b1),
	) dlatch (
		.EN(c),
		.D(d),
		.Q(q)
	);

	// logic l;
	//
	// initial l = /*random*/0;
	//
	// always_latch begin
	// 	if (c)
	// 		l = d;
	// end
	//
	// assign q = l;

endmodule
