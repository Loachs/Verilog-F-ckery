module stochastricbitfuckery (
	input			clk,
	input	[7:0] probability,
	input	[7:0] random_number1,
	input	[7:0] random_number2,
	input	[7:0] random_number3,
	input	[7:0] random_number4,
	output reg	stochastic_bit1,
	output reg	stochastic_bit2,
	output reg	stochastic_bit3,
	output reg	stochastic_bit4,
	output sb1asb2,
	output sb3osb4
);

always @(posedge clk) begin
	stochastic_bit1 <= (random_number1 < probability);
	stochastic_bit2 <= (random_number2 < probability);
	stochastic_bit3 <= (random_number3 < probability);
	stochastic_bit4 <= (random_number4 < probability);
	
	sb1asb2 <= stochastic_bit1 & stochastic_bit2;
	sb3osb4 <= stochastic_bit3 | stochastic_bit4;
end

endmodule
