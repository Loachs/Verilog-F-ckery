module retardmaxedbullshit(

input [7:0] rows [0:7],
input [2:0] muxcnt,

output logic [8:0] c [0:5]
); 

wire [8:0] xval [0:5][0:5];

genvar r, j;
generate 
	for (r = 0; r < 6; r = r + 1) begin : row
		for (j = 0; j < 6; j = j + 1) begin : column
			assign xval[r][j] = {
			rows[r] [7-j -: 3],
			rows[r+1] [7-j -: 3],
			rows[r+2] [7-j -: 3]
			};
		end
	end
endgenerate

always @* begin
	if (muxcnt <= 3'b101) begin
		for (int i = 0; i < 6; i = i + 1) begin
			c[i] = xval[i][muxcnt];
		end
	end
	else begin
		for (int i = 0; i < 6; i = i + 1) begin
			c[i] = 9'b0;
		end
	end
end
endmodule
