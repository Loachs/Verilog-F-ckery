module retardcurvatureshit(

input [8:0] xval,
input [2:0] muxcnt,
// 12 pin input

output [7:0] curve,
output [7:0] diag,
output [7:0] nothing
// 24 pin output

);

reg [3:0] bits

always @* begin
	bits = xval[0] + xval[1] + xval[2] +
			 xval[3] + xval[4] + xval[5] +
			 xval[6] + xval[7] + xval[8];
			 
	wire [2:0]row1 = xval[0] + xval[1] + xval[2];
	wire [2:0]row2 = xval[3] + xval[4] + xval[5];
	wire [2:0]row3 = xval[4] + xval[7] + xval[8];
	
	wire [2:0]col1 = xval[0] + xval[3] + xval[6];
	wire [2:0]col2 = xval[1] + xval[4] + xval[7];
	wire [2:0]col3 = xval[2] + xval[5] + xval[8];
	
	
	curve =		8b'0;
	diag =		8b'0;
	nothing =	8b'0;
	
	//Diag
	begin : diag_Val
		if (xval[0] & xval[4] & xval[8] & !(xval[6] | xval[2])) begin : 
			diag = //high val
			disable diag_Val;
		end
			
		if (xval[2] & xval[4] & xval[6] & !(xval[0] | xval[8])) begin :
			diag = // High Val
			disable diag_Val;
		end
		
		if (((xval[1] & xval[3]) | (xval[5] & xval[7]) | ((xval[2] | xval[6]) & xval[4])) & (!(xval[0] | xval[9]))) begin :
			diag = // mid val
			disable diag_Val;
		end
		
		if (((xval[1] & xval[5]) | (xval[3] & xval[7]) | ((xval[0] | xval[8]) & xval[4])) & (!(xval[2] | xval[6]))) begin :
			diag = // mid val
			disable diag_Val;	
		end
	end
	
	// curve
	begin : curve_Val
		if (!xval[0] & xval[1] & xval[2] & xval[3] & xval[6] & !(xval[5] | xval[7] |xval[8])) begin :
			curve = // high val
			disable curve_Val;
		end
		
		if (!xval[2] & xval[0] & xval[1] & xval[5] & xval[8] & !(xval[3] | xval[6] |xval[7])) begin :
			curve = // high val
			disable curve_Val;
		end
		
		if (!xval[8] & xval[6] & xval[7] & xval[2] & xval[5] & !(xval[0] | xval[1] |xval[3])) begin :
			curve = // high val
			disable curve_Val;
		end
		
		if (!xval[6] & xval[0] & xval[3] & xval[7] & xval[8] & !(xval[1] | xval[2] |xval[5])) begin :
			curve = // high val
			disable curve_Val;
		end
		
		if ((row[1] | row[3]) & (col[1] | col[3])) begin :
			curve = // high val
			disable curve_Val;
		end
		
		if (((row[1] | row[3]) & (xval[3] | xval[5])) | ((col[1] | col[3]) & (xval[1] | xval[7]))) begin :
			curve = //mid val
		end
		
		if ((row[2] & (row[1] | row[3]) | (col[2] & (col[1] | col[2])) begin :
			curve = // Nothing
			disable curve_Val;
		end
		
		if (row[1] | row[2] | row[3] | col[1] | col[2] | col[3]) begin :
			curve = // nothing
			disable curve_Val;
		end
		
		if (((xval[0] | xval[6]) & xval[3]) | ((xval[1] | xval[7]) & xval[4]) | ((xval[2] | xval[8]) & xval[5]) begin :
			curve = //nothing
			disable curve_Val;
		end
		
		if (((xval[0] | xval[2]) & xval[1]) | ((xval[3] | xval[5]) & xval[4]) | ((xval[6] | xval[8]) & xval[7]) begin :
			curve = // nothing
			disable curve_Val;
		end
	end
	
	// nothing
	begin : nothing_val
		if (bits <= 1) begin : 
			nothing = // High
			disable nothing_val;
		end
		
		if (bits = 2) begin :
			nothing = //mid
			disable nothing_val;
		end

		if (bits = 3) begin :
			nothing = //low
			disable nothing_val;
		end
		
		else begin :
			nothing = //zero
			disable nothing_val;
		end
	end
end
endmodule
		nothing = //zero
	break
	
	
