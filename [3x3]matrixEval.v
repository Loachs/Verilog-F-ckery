input [8:0] xval,
input [2:0] muxcnt,
input clk,
// 13 pin input

output [7:0] curve,
output [7:0] diag,
output [7:0] nothing
// 24 pin output

);

wire [5:0] xv;

always @* begin
	case (muxcnt)
		3'b000: begin 
			xv[0] = xval;
		end
		3'b001: begin
			xv[1] = xval;
		end
		3'b010: begin 
			xv[2] = xval;
		end
		3'b011: begin
			xv[3] = xval;
		end
		3'b100: begin 
			xv[4] = xval;
		end
		3'b101: begin
			xv[5] = xval;
		end
	endcase
end
endmodule
