module retardmaxedbullshit(

/*
{--------------------------------}
You must have over 176 pins to
allocate to use this because
of this code -READ THIS-
{--------------------------------}
*/

input [7:0] row1,
input [7:0] row2,
input [7:0] row3,
input [7:0] row4,
input [7:0] row5,
input [7:0] row6,
input [7:0] row7,
input [7:0] row8,
input clk,
input [2:0] muxcnt,

output reg [8:0] r1c1x,
output reg [8:0] r2c1x,
output reg [8:0] r3c1x,
output reg [8:0] r4c1x,
output reg [8:0] r5c1x,
output reg [8:0] r6c1x
); 

wire [7:0] rows [0:7];
assign rows[0] = row1;
assign rows[1] = row2;
assign rows[2] = row3;
assign rows[3] = row4;
assign rows[4] = row5;
assign rows[5] = row6;
assign rows[6] = row7;
assign rows[7] = row8;
wire [8:0] xval [0:5][0:5];

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
		r1c1x = xval[0][muxcnt];
		r2c1x = xval[1][muxcnt];
		r3c1x = xval[2][muxcnt];
		r4c1x = xval[3][muxcnt];
		r5c1x = xval[4][muxcnt];
		r6c1x = xval[5][muxcnt];
	end
	else begin
		r1c1x = 9'b0;
		r2c1x = 9'b0;
		r3c1x = 9'b0;
		r4c1x = 9'b0;
		r5c1x = 9'b0
		r6c1x = 9'b0;
	end
end
endmodule
