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
	
	if (xval[0] & xval[4] & xval[8] & !(xval[6] | xval[2]))
		diag = //high val
	break
		
	if (xval[2] & xval[4] & xval[6] & !(xval[0] | xval[8]))
		diag = // High Val
	break
	
	if (((xval[1] & xval[3]) | (xval[5] & xval[7]) | ((xval[2] | xval[6]) & xval[4])) & (!(xval[0] | xval[9])))
		diag = // mid val
	break
	
	if (((xval[1] & xval[5]) | (xval[3] & xval[7]) | ((xval[0] | xval[8]) & xval[4])) & (!(xval[2] | xval[6])))
		diag = // mid val	
	break
	
	// curve
	if (!xval[0] & xval[1] & xval[2] & xval[3] & xval[6] & !(xval[5] | xval[7] |xval[8]))
		curve = // high val
	break
	
	if (!xval[2] & xval[0] & xval[1] & xval[5] & xval[8] & !(xval[3] | xval[6] |xval[7]))
		curve = // high val
	break
	
	if (!xval[8] & xval[6] & xval[7] & xval[2] & xval[5] & !(xval[0] | xval[1] |xval[3]))
		curve = // high val
	break
	
	if (!xval[6] & xval[0] & xval[3] & xval[7] & xval[8] & !(xval[1] | xval[2] |xval[5]))
		curve = // high val
	break
	
	if ((row[1] | row[3]) & (col[1] | col[3]))
		curve = // high val
	break
	
	if (((row[1] | row[3]) & (xval[3] | xval[5])) | ((col[1] | col[3]) & (xval[1] | xval[7])))
		curve = //mid val
	break
	
	if ((row[2] & (row[1] | row[3]) | (col[2] & (col[1] | col[2]))
		curve = // Nothing
	break
	
	if (row[1] | row[2] | row[3] | col[1] | col[2] | col[3])
		curve = // nothing
	break
	
	if (((xval[0] | xval[6]) & xval[3]) | ((xval[1] | xval[7]) & xval[4]) | ((xval[2] | xval[8]) & xval[5])
		curve = //nothing
	break
	
	if (((xval[0] | xval[2]) & xval[1]) | ((xval[3] | xval[5]) & xval[4]) | ((xval[6] | xval[8]) & xval[7])
		curve = // nothing
	break
	
	// nothing
	
	if (bits <= 1)
		nothing = // High
	break
	
	if (bits = 2)
		nothing = //mid
	break

	if (bits = 3)
		nothing = //low
	break
	
	else 
		nothing = //zero
	break
	
	
