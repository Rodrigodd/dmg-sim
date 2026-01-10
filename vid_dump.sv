`default_nettype none

module vid_dump(
		// timestamp
		input int   t,
		// output file handle
		input int   f,
		// display enable(?) pixel clock, display enable latch(?)
		input logic cpg, cp, cpl,
		// odd-frame(?), hsync, vsync
		input logic fr, st, s,
		// pixel data
		input logic ld0, ld1
	);

	bit [1:0] line[0:159];
	int       pxidx, lineidx;
	bit       dis;
	bit       stop = 0;

	// DEBUG:
	bit [1:0] pix_out;
	assign pix_out = { ld1, ld0 };

	initial pxidx   = 0;
	initial lineidx = 0;
	initial dis     = 1;

	// Signal decoding based on this blog post by Tobias Wirtl:
	// https://www.embedded-ideas.de/posts/241209_dmg_display_capture/

	// 1. Wait for rising edge of vsync to start new frame
	always @(posedge s) begin
		pxidx   = 0;
		lineidx = 0;
		if (f) $fwrite(f, "%c%c%c%cV", t[7:0], t[15:8], t[23:16], t[31:24]);
	end

	// 2. Wait for the falling edge on the HSYNC line and capture data lines
	// directly as the first pixel.
	always @(negedge st) begin
		pxidx = 0;
		line[pxidx] = { ld1, ld0 };
		pxidx++;
	end

	int j;
	byte pxout;

	// 3. Wait for the falling edge on the CLOCK line and capture data as the next pixel.
	// 4. Repeat step 3 for the next 158 pixels.
	always @(negedge cp) begin
		if (0 < pxidx && pxidx < 160) begin
			line[pxidx] = { ld1, ld0 };
			pxidx++;
			if (pxidx == 160) begin
				/* Latch line:
				 *   4 byte little endian timestamp + "L" + 40 bytes pixel data
				 *  or
				 *   4 byte little endian timestamp + "l" + 40 bytes pixel data
				 *  depending on current direction */
				if (f) begin
					if (fr)
						$fwrite(f, "%c%c%c%cL", t[7:0], t[15:8], t[23:16], t[31:24]);
					else
						$fwrite(f, "%c%c%c%cl", t[7:0], t[15:8], t[23:16], t[31:24]);
					j     = 0;
					pxout = 0;
					for (int i = 0; i < 160; i++) begin
						if (pxidx)
							pxout = (pxout & ~(3 << ((i & 3) * 2))) | (line[j] << ((i & 3) * 2));
						j++;
						if (j >= pxidx) /* Repeat available pixels if less than 160 are in buffer */
							j = 0;
						if (&i[1:0])
							$fwrite(f, "%c", pxout);
					end
				end
				lineidx++;
			end
		end
	end

	// Detect display enable/disable changes
	always @(negedge cpl, posedge stop) begin
		if (!cpg && !dis) begin
			/* Disable display:
			 *   4 byte little endian timestamp + "D" */
			if (f) $fwrite(f, "%c%c%c%cD", t[7:0], t[15:8], t[23:16], t[31:24]);
			dis = 1;
		end else if (cpg && dis) begin
			/* Enable display:
			 *   4 byte little endian timestamp + "E" */
			if (f) $fwrite(f, "%c%c%c%cE", t[7:0], t[15:8], t[23:16], t[31:24]);
			dis = 0;
		end
	end

endmodule

