`default_nettype none

module dffr_c #(
		parameter logic INITIAL_Q = 'x
	) (
		input  logic clk, nreset, d,
		output logic q
	);

	bit ff, initff;
	initial begin
		initff = $isunknown(INITIAL_Q) ? $random : INITIAL_Q;
		ff     = initff;
	end

	logic dffrc_clk;
	assign dffrc_clk = dffrc_inv_clk ? !clk : clk;

	always_ff @(posedge dffrc_clk, negedge nreset) begin
		if (nreset)
			ff <= $isunknown(d) ? initff : d;
		else
			ff <= 0;
	end

	assign #T_DFFR_C q = ff;

endmodule
