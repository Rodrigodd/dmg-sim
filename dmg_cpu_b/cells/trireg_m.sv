`timescale 1ns/1ns
// Keep the last value driven on the bus when the bus is in high-impedance
// state, simulating capacitive charge on the bus. A `trireg` net from
// SystemVerilog would be a better representation for it, but that is not
// supported by Icarus Verilog.
module trireg_m (inout tri logic a);
	logic a_cap;
	always @(a) a_cap = a;
	assign (weak1, weak0) a = a_cap;
endmodule // BusKeeper
