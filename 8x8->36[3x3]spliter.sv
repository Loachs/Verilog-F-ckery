module retardmaxedbullshit(

input [7:0] row1, row2, row3, row4,
input [7:0] row5, row6, row7, row8,
input [2:0] muxcnt,

output reg [8:0] c1, c2, c3, c4, c5, c6
); 

wire [8:0] xval [0:5] [0:5];
wire [7:0] rows [0:7];

assign rows[0] = row1;
assign rows[1] = row2;
assign rows[2] = row3;
assign rows[3] = row4;
assign rows[4] = row5;
assign rows[5] = row6;
assign rows[6] = row7;
assign rows[7] = row8;

genvar r, c;
generate 
	for (r = 0; r < 6; r = r + 1) begin : row
		for (c = 0; c < 6; c = c + 1) begin : column
			wire [2:0] top;
			wire [2:0] mid;
			wire [2:0] bot;
		
			assign top = rows[r] [7-c -: 3];
			assign mid = rows[r+1] [7-c -: 3];
			assign bot = rows[r+2] [7-c -: 3];
			
			assign xval[r][c] = {top, mid, bot};
		end
	end
endgenerate

always @* begin
	if (muxcnt <= 3'b101) begin
		c1 = xval[0][muxcnt]; c2 = xval[1][muxcnt];
		c3 = xval[2][muxcnt]; c4 = xval[3][muxcnt];
		c5 = xval[4][muxcnt]; c6 = xval[5][muxcnt];
	end
	else begin
		for (int i = 0; i < 6; i = i + 1) begin
			c1 = 9'b0; c2 = 9'b0; c3 = 9'b0;
			c4 = 9'b0; c5 = 9'b0; c6 = 9'b0;
		end
	end
end
endmodule
