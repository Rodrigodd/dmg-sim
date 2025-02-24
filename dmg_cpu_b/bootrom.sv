
module bootrom(
	input logic [15:0] a,
	output logic [7:0] d);

	logic [7:0] brom[0:255];

	integer i;

	initial begin
		string bootrom_file;
		int f, _;

		bootrom_file = "";
		_ = $value$plusargs("BOOTROM=%s", bootrom_file);

		f = 0;
		if (bootrom_file != "") begin
			f = $fopen(bootrom_file, "rb");
			if (!f)
				$error("Failed to open boot ROM file %s for reading. Using all-zero boot ROM.", bootrom_file);
		end
		if (f) begin
			_ = $fread(brom, f);
			$fclose(f);
		end else
			for (i = 0; i < $size(brom); i++) brom[i] = '0;

		$display("loaded bootrom file %s", bootrom_file);
	end
	assign d = brom[a[7:0]];

endmodule
