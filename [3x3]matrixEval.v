module retardcurvatureshit(

input [9:0] xval,
input [9:0] yval,
input [2:0] muxcnt,
input clk,
// 22 pin input

output [7:0] curve,
output [7:0] diag,
output [7:0] nothing,
// 24 pin output

);

wire [5:0] xv [0:5];
wire [5:0] yv [0:5];
always @* begin
	case (muxcnt)
		0'b 000: begin 
			xv[0] = xval; yv[0] = yval;
		end
		0'b 001: begin
			xv[1] = xval; yv[1] = yval;
		end
		0'b 010: begin 
			xv[2] = xval; yv[2] = yval;
		end
		0'b 011: begin
			xv[3] = xval; yv[3] = yval;
		end
		0'b 100: begin 
			xv[4] = xval; yv[4] = yval;
		end
		0'b 101: begin
			xv[5] = xval; yv[5] = yval;
		end
	endcase
end

// I need to wire all the curve, diag and nothing vals 
// then input into a muxcnt to keep generalized
