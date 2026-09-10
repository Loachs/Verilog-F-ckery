module retardadderthing(

input [8:0]curve_val,
input [8:0]diag_val,
input [8:0]nothing_val,
input [3:0]muxcnt,
input [3:0]row, // tells system what row we are on

output [9:0]weighted_pick
);

wire [5:0] curvehold [0:8];
wire [5:0] diaghold [0:8];
wire [5:0] nothhold [0:8];

wire [71:0] addcurve;
wire [71:0] adddiag;
wire [71:0] addnoth;

addcurve = 72'b0;
addhold = 72'b0;
addnoth = 72'b0;

always @* begin
	case(muxcnt)
		begin : muxcnt_check
			if (muxcnt >= 3'b110) begin
				disable muxcnt_check 
			end
		end
		muxcnt : begin curvehold[muxcnt] = curve_val[muxcnt];
							diaghold[muxcnt] = diag_val[muxcnt];
							nothhold[muxcnt] = noth_val[muxcnt];
		end
	end
end

always @* begin
	for (int i = 0; i < 6; i = i + 1) begin
		addcurve[i * 9 - 1 -: 9] = curvehold[i];
		adddiag[i * 9 - 1 -: 9] = addhold[i];
		addnoth[i * 9 - 1 -: 9] = diaghold[i];
	end
end
endmodule 
