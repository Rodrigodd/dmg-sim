`default_nettype none

module drlatch (
		input  logic c, nreset, d,
		(*init=1'b0*)
		output logic q
	);

	// TODO: replace with $dlatchsr or something like that.
	$dlatchsr #(
		.WIDTH(1),
		.EN_POLARITY(1),
		.SET_POLARITY(1),
		.CLR_POLARITY(0),
	) mydrlatch (
		.EN(c),
		.SET(1'b0),
		.CLR(nreset),
		.D(d),
		.Q(q)
	);

	// logic l;
	//
	// initial l = /*random*/0;
	//
	// always_latch begin
	// 	if (!nreset)
	// 		l = 0;
	// 	else if (c)
	// 		l = d;
	// end
	//
	// assign q = l;

endmodule
