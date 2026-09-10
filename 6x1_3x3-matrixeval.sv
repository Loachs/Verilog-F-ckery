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

wire [7:0]curvecalc;
wire [7:0]diagcalc;
wire [7:0]nothcalc;

always @* begin
	case(muxcnt)
		begin : muxcnt_check
			if (muxcnt >= 3'b110) begin
				disable muxcnt_check 
			end
		muxcnt : begin curvehold[muxcnt] = curve_val[muxcnt];
							diaghold[muxcnt] = diag_val[muxcnt];
							nothhold[muxcnt] = noth_val[muxcnt];
		end
	endcase
end

curvecalc = 8'b0;
diagcalc = 8'b0;
nothcalc = 8'b0;

curvecalc = ((curvehold[0] + curvehold[1] + curvehold[2] + curvehold[3] + curvehold[4] + curvehold[5])/6);
diagcalc = ((diaghold[0] + diaghold[1] + diaghold[2] + diaghold[3] + diaghold[4] + diaghold[5])/6);
nothcalc = ((nothhold[0] + nothhold[1] + nothhold[2] + nothhold[3] + nothhold[4] + nothhold[5])/6);	

endmodule
