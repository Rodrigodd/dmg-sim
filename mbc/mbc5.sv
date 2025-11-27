`default_nettype none

module mbc5(
		input  logic         nrst,
		input  logic [15:12] a,
		input  logic [7:0]   d,
		input  logic         nwr,
		input  logic         ncs,

		output logic [22:14] ra,
		output logic [16:13] aa,
		output logic         ncs_ram
	);

	logic       ena;
	logic [8:0] rom_bank;
	logic [3:0] ram_bank;

	always_ff @(posedge nwr, negedge nrst) begin
		if (~nrst) begin
			ena      <= 0;
			rom_bank <= 0;
			ram_bank <= 0;
		end else unique0 case (a)
			0: ena           <= d[3:0] == 'ha;
			2: rom_bank[7:0] <= d;
			3: rom_bank[8]   <= d[0];
			4: ram_bank      <= d[3:0];
		endcase
	end

	assign ncs_ram = ~(ena && ~ncs && ~a[14]);

	assign ra = (~nrst || ~a[14]) ? 0 : rom_bank;

	assign aa = a[14] ? ram_bank : 0;

endmodule
