module retardcurvatureshit(

input [8:0] xval,
// 12 pin input

output reg [7:0] curve,
output reg [7:0] diag,
output reg [7:0] nothing
// 24 pin output

);

reg [3:0] bits;
reg [2:0]row1;
reg [2:0]row2;
reg [2:0]row3;
reg [2:0]col1;
reg [2:0]col2;
reg [2:0]col3;

always @* begin
	diag = 8'b0;
	
	//Diag
	begin : diag_Val
		if (xval[0] & xval[4] & xval[8] & !(xval[6] | xval[2])) begin
			diag = 8'b10000000;
			disable diag_Val;
		end
	
		if (xval[2] & xval[4] & xval[6] & !(xval[0] | xval[8])) begin
			diag = 8'b01000000;
			disable diag_Val;
		end
	
		if (((xval[1] & xval[3]) | (xval[5] & xval[7]) | ((xval[2] | xval[6]) & xval[4])) & (!(xval[0] | xval[8]))) begin
			diag = 8'b00100000;
			disable diag_Val;
		end
	
		if (((xval[1] & xval[5]) | (xval[3] & xval[7]) | ((xval[0] | xval[8]) & xval[4])) & (!(xval[2] | xval[6]))) begin
			diag = 8'b00010000;
			disable diag_Val;	
		end
	end
end

always @* begin	 
			 
	row1 = {xval[0], xval[1], xval[2]};
	row2 = {xval[3], xval[4], xval[5]};
	row3 = {xval[6], xval[7], xval[8]};
	
	col1 = {xval[0], xval[3], xval[6]};
	col2 = {xval[1], xval[4], xval[7]};
	col3 = {xval[2], xval[5], xval[8]};
	
	curve = 8'b0;
	
	// curve
	begin : curve_Val
		if (!xval[0] & xval[1] & xval[2] & xval[3] & xval[6] & !(xval[5] | xval[7] |xval[8])) begin
			curve = 8'b10000000;
			disable curve_Val;
		end
		
		if (!xval[2] & xval[0] & xval[1] & xval[5] & xval[8] & !(xval[3] | xval[6] |xval[7])) begin
			curve = 8'b01000000;
			disable curve_Val;
		end
	
		if (!xval[8] & xval[6] & xval[7] & xval[2] & xval[5] & !(xval[0] | xval[1] |xval[3])) begin
			curve = 8'b00100000;
			disable curve_Val;
		end

		if (!xval[6] & xval[0] & xval[3] & xval[7] & xval[8] & !(xval[1] | xval[2] |xval[5])) begin
			curve = 8'b00010000;
			disable curve_Val;
		end

		if ((row1 || row3) & (col1 || col3)) begin
			curve = 8'b00001000;
			disable curve_Val;
		end

		if (((row1 || row3) & (xval[3] | xval[5])) | ((col1 || col3) & (xval[1] | xval[7]))) begin
			curve = 8'b00000100;
			disable curve_Val;
		end

		if (row2 & (row1 | row3) | (col2 & (col1 | col2))) begin
			curve = 8'b00000010;
			disable curve_Val;
		end

		if (row1 || row2 || row3 || col1 || col2 || col3) begin
			curve = 8'b00000001;
			disable curve_Val;
		end

		if (((xval[0] | xval[6]) & xval[3]) | ((xval[1] | xval[7]) & xval[4]) | ((xval[2] | xval[8]) & xval[5])) begin
			curve = 8'b00000000;
			disable curve_Val;
		end

		if (((xval[0] | xval[2]) & xval[1]) | ((xval[3] | xval[5]) & xval[4]) | ((xval[6] | xval[8]) & xval[7])) begin
			curve = 8'b10000001;
			disable curve_Val;
		end
	end
end

always @* begin
	
	bits = 4'b0;
	for (int i = 0; i < 9; i = i + 1) begin
		if (xval[i] == 1) begin
			bits = bits + 1;
		end
	end

	nothing = 8'b0;	
	// nothing
	begin : nothing_val
		if (bits <= 1) begin 
			nothing = 8'b10000000;
			disable nothing_val;
		end
	
		if (bits == 2) begin
			nothing = 8'b01000000;
			disable nothing_val;
		end

		if (bits == 3) begin
			nothing = 8'b00100000;
			disable nothing_val;
		end
	
		else begin
			nothing = 8'b00010000;
			disable nothing_val;
		end
	end
end

endmodule
