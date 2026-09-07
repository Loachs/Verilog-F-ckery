module retardmaxedbullshit(

/*
READ THIS BEFORE YOU DO ANYTHING

{--------------------------------}
You must have over 281 pins to
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

input clk;

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

output [2:0] r1c2x,
output [2:0] r1c2y,

output [2:0] r1c3x,
output [2:0] r1c3y,

output [2:0] r1c4x,
output [2:0] r1c4y,

output [2:0] r1c5x,
output [2:0] r1c5y,

output [2:0] r1c6x,
output [2:0] r1c6y,

// End of first row 

output [2:0] r2c1x,
output [2:0] r2c1y,

output [2:0] r2c2x,
output [2:0] r2c2y,

output [2:0] r2c3x,
output [2:0] r2c3y,

output [2:0] r2c4x,
output [2:0] r2c4y,

output [2:0] r2c5x,
output [2:0] r2c5y,

output [2:0] r2c6x,
output [2:0] r2c6y,

// End of second row

output [2:0] r3c1x,
output [2:0] r3c1y,

output [2:0] r3c2x,
output [2:0] r3c2y,

output [2:0] r3c3x,
output [2:0] r3c3y,

output [2:0] r3c4x,
output [2:0] r3c4y,

output [2:0] r3c5x,
output [2:0] r3c5y,

output [2:0] r3c6x,
output [2:0] r3c6y,

// End of third row

output [2:0] r4c1x,
output [2:0] r4c1y,

output [2:0] r4c2x,
output [2:0] r4c2y,

output [2:0] r4c3x,
output [2:0] r4c3y,

output [2:0] r4c4x,
output [2:0] r4c4y,

output [2:0] r4c5x,
output [2:0] r4c5y,

output [2:0] r4c6x,
output [2:0] r4c6y,

// End of fourth row

output [2:0] r5c1x,
output [2:0] r5c1y,

output [2:0] r5c2x,
output [2:0] r5c2y,

output [2:0] r5c3x,
output [2:0] r5c3y,

output [2:0] r5c4x,
output [2:0] r5c4y,

output [2:0] r5c5x,
output [2:0] r5c5y,

output [2:0] r5c6x,
output [2:0] r5c6y,

// End of fifth row

output [2:0] r6c1x,
output [2:0] r6c1y,

output [2:0] r6c2x,
output [2:0] r6c2y,

output [2:0] r6c3x,
output [2:0] r6c3y,

output [2:0] r6c4x,
output [2:0] r6c4y,

output [2:0] r6c5x,
output [2:0] r6c5y,

output [2:0] r6c6x,
output [2:0] r6c6y

// End of sixth row
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

assign r1c1x = xval[0][0];
assign r1c1y = yval[0][0];

assign r1c2x = xval[0][1];
assign r1c2y = yval[0][1];

assign r1c3x = xval[0][2];
assign r1c3y = yval[0][2];

assign r1c4x = xval[0][3];
assign r1c4y = yval[0][3];

assign r1c5x = xval[0][4];
assign r1c5y = yval[0][4];

assign r1c6x = xval[0][5];
assign r1c6y = yval[0][5];

// End of first row 

assign r2c1x = xval[1][0];
assign r2c1y = yval[1][0];

assign r2c2x = xval[1][1];
assign r2c2y = yval[1][1];

assign r2c3x = xval[1][2];
assign r2c3y = yval[1][2];

assign r2c4x = xval[1][3];
assign r2c4y = yval[1][3];

assign r2c5x = xval[1][4];
assign r2c5y = yval[1][4];

assign r2c6x = xval[1][5];
assign r2c6y = yval[1][5];

// End of second row

assign r3c1x = xval[2][0];
assign r3c1y = yval[2][0];

assign r3c2x = xval[2][1];
assign r3c2y = yval[2][1];

assign r3c3x = xval[2][2];
assign r3c3y = yval[2][2];

assign r3c4x = xval[2][3];
assign r3c4y = yval[2][3];

assign r3c5x = xval[2][4];
assign r3c5y = yval[2][4];

assign r3c6x = xval[2][5];
assign r3c6y = yval[2][5];

// End of third row

assign r4c1x = xval[3][0];
assign r4c1y = yval[3][0];

assign r4c2x = xval[3][1];
assign r4c2y = yval[3][1];

assign r4c3x = xval[3][2];
assign r4c3y = yval[3][2];

assign r4c4x = xval[3][3];
assign r4c4y = yval[3][3];

assign r4c5x = xval[3][4];
assign r4c5y = yval[3][4];

assign r4c6x = xval[3][5];
assign r4c6y = yval[3][5];

// End of fourth row

assign r5c1x = xval[4][0];
assign r5c1y = yval[4][0];

assign r5c2x = xval[4][1];
assign r5c2y = yval[4][1];

assign r5c3x = xval[4][2];
assign r5c3y = yval[4][2];

assign r5c4x = xval[4][3];
assign r5c4y = yval[4][3];

assign r5c5x = xval[4][4];
assign r5c5y = yval[4][4];

assign r5c6x = xval[4][5];
assign r5c6y = yval[4][5];

// End of fifth row

assign r6c1x = xval[5][0];
assign r6c1y = yval[5][0];

assign r6c2x = xval[5][1];
assign r6c2y = yval[5][1];

assign r6c3x = xval[5][2];
assign r6c3y = yval[5][2];

assign r6c4x = xval[5][3];
assign r6c4y = yval[5][3];

assign r6c5x = xval[5][4];
assign r6c5y = yval[5][4];

assign r6c6x = xval[5][5];
assign r6c6y = yval[5][5];

// End of sixth row

endmodule
