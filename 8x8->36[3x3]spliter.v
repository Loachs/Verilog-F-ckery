module retardmaxedbullshit(

/*
READ THIS BEFORE YOU DO ANYTHING

{--------------------------------}
You must have over 104 pins to
allocate to use this because
of this code -READ THIS-
I will be working to decrease this
{--------------------------------}

All rows will be either 1 or 0 ex: 001-001-100 (dashes represent a 3 split)
A lot of the purpose of this part is to split the values up into more managable chunks
Due to the fact that most of this will be done by hand and im fucking lazy

The main goal of the neural input splitter is to make 36 3x3 boxes, the reason for this is
because we have an 8x8 grid I want to chunk it down to size and I can do that by essentially
doing this C++ code below

	for (int i = 0; i <= 5; i++)
		for (int j = 0; j <= 5; j++)
	  
This essentially is a simple matrix sort algorithm that will allow us to get all 36 3x3 grids on the 
8x8 board, I will also output a position value that is unique to each 3x3 grid. I will be doing this
because I want a position vector (most of this will be vectors work)
*/

input [7:0] row1,
input [7:0] row2,
input [7:0] row3,
input [7:0] row4,
input [7:0] row5,
input [7:0] row6,
input [7:0] row7,
input [7:0] row8,

input clk, // Our constant clock value

input [2:0] muxcnt, // This is what will control out mux
/*
READ THIS
The mux count will max out at 3 bits. We will use our mux to
go through the values 0-5, this is because we are working in a 
6x6 matrix therefore by capping out mux at 6 we can use it as a
positional vector for when we calculate rows and columns
This is also to reduce the pin count by 180, since currently we 
have 216 output pins and since we mux by 6, that goes down to 
36 exits which saves us a total of 180 pins - total pin count will
end up being 104 once we are done
*/

/*
The outputs will be notated as rNcN where r is the row N is the location of the row in 
relation to the 6x6 grid of 3x3s. c is the column and N is the location of the column in relation to
the 6x6 grid of 3x3s. x and y dictate if its the x values or y values

The order in which the vectors will be first vector is x row which can be visualized as 010 or whatever
it will start top to down, as for the y column it will be read left to right and it will be the second
vector in the pair.

I have decided against doing a multidimensional packed vector for my outputs, I believe that this will
help make it easier in the future to separate vectors, aswell my experience in the past with them
has made troubleshooting a lot harder especialy when we get in the realm of having a fuck ton.

I dont think I can use a generate function for my output declaration
*/

output [2:0] r1c1x,
output [2:0] r1c1y, 

output [2:0] r2c1x,
output [2:0] r2c1y,

output [2:0] r3c1x,
output [2:0] r3c1y,

output [2:0] r4c1x,
output [2:0] r4c1y,

output [2:0] r5c1x,
output [2:0] r5c1y,

output [2:0] r6c1x,
output [2:0] r6c1y
); 

/*
I dont want to fucking write out like a fuck ton of lines so I will "automate" it
this is the same thing as doing {wire r1c1x [2:0] = row1 [2:0];}
*/ 

wire [7:0] rows [0:7];
assign rows[0] = row1;
assign rows[1] = row2;
assign rows[2] = row3;
assign rows[3] = row4;
assign rows[4] = row5;
assign rows[5] = row6;
assign rows[6] = row7;
assign rows[7] = row8;

/*
This is just helping with out generate loop that we will have underneath, it will allow me to
increment the row value without needing to make a loop for every singl row / column
*/

wire [2:0] xval [0:5][0:5];
wire [2:0] yval [0:5][0:5];

/*
This will be used in our generate loop, it will allow us to
*/

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
			
			assign xval[r][c] = mid;
			assign yval[r][c] = {top[1], mid[1], bot[1]};
		end
	end
endgenerate

/*
For the generate loop we get our generate variables we will call them r and c, r for row and c for
column, we will use a double for loop which increments. The reason we do this is so we can pass through
every possible section. we can do this by subtracting our mini matrix (3x3) by our bigger matrix (8x8)
and then adding the center point (1) this essentially lets us run a path in the center section to hit all
targets. this is wht we have out system stop at 6. it will go right 6 times then go back to 0 and go down
it will repeat until it finishes.

we wire up a three vector top, bot, and mid. these are three point vectors to hold the vector data
essentially they will all hold columns of three values so we can grab them from our data table.

We then assign the top, mid, and bottom vals based off the previous rows and columns for the first
vector it adds 1 and 2, this is because we have a 3x3 vector we are able to reach as for the second
vector it starts at 7 and gets decreased by c, the vector then moves a total of 3 bits which allows
us to get the entire 3x3 matrix

we then end our loop by putting the values from the rows and columns into our yval[r][c] and xval[r][c]

*/

wire [5:0] x1 [0:5];
assign x1[0] = r1c1x;
assign x1[1] = r2c1x;
assign x1[2] = r3c1x;
assign x1[3] = r4c1x;
assign x1[4] = r5c1x;
assign x1[5] = r6c1x;

wire [5:0] y1 [0:5];
assign y1[0] = r1c1y;
assign y1[1] = r2c1y;
assign y1[2] = r3c1y;
assign y1[3] = r4c1y;
assign y1[4] = r5c1y;
assign y1[5] = r6c1y;

/*
Created a vector form of the rows and columns output, this is so we can use it
in the future and it will work in our generate loop underneath
*/

genvar i;
generate
	for (i = 0; i < 6; i = i + 1) begin : count
		always @* begin 
			case (muxcnt)
				3'b000: x1[0] = xval[0][i];
				3'b001: x1[1] = xval[1][i];
				3'b010: x1[2] = xval[2][i];
				3'b011: x1[3] = xval[3][i];
				3'b100: x1[4] = xval[4][i];
				3'b101: x1[5] = xval[5][i];
				
				3'b000: y1[0] = yval[i][0];
				3'b001: y1[1] = yval[i][1];
				3'b010: y1[2] = yval[i][2];
				3'b011: y1[3] = yval[i][3];
				3'b100: y1[4] = yval[i][4];
				3'b101: y1[5] = yval[i][5];
			endcase
		end
	end
endgenerate

assign r1c1x = xval[0][0];
assign r1c1y = yval[0][0];

assign r2c1x = xval[0][1];
assign r2c1y = yval[1][0];

assign r3c1x = xval[0][2];
assign r3c1y = yval[2][0];

assign r4c1x = xval[0][3];
assign r4c1y = yval[3][0];

assign r5c1x = xval[0][4];
assign r5c1y = yval[4][0];

assign r6c1x = xval[0][5];
assign r6c1y = yval[5][0];

endmodule


