module reaction_time_game (
	input logic clk, 					// basic clk function ofc
	
	input logic start_game, 		// button press to start game
	
	input logic reset,  				// allows the user to play again (FSM function)
	
	input logic button_press, 		// Need to add debounce {What user will click to play}
											
	//end of inputs										
	
	output logic light_start, 		// Light that turns on and starts timer (green)
											
	output logic light_end,			// Gets Displayed once the game ends	
											
	output logic [3:0] sevseg1		// Display output rating 0-9 {3:0 max is 4 bits}
	);
	
	// {ideas: (a - means end state)
		// state 0 - game hasnt started {button press to cont} [clk, start_game]
		// state 1 - random delay is triggered {rand time to cont} [clk, random_delay]
		// state 2a - user clicks before light turns on will display state (5/4b)
		// state 2b - light turns on, reaction timer counts timesince press [clk, reaction_timer, button_press]
		// state 3a - light end lights up (meaning you missed it)[clk, reaction_timer, light_end]
		// state 3b - reaction gets registered and displayed on sev seg [clk, reaction_timer, sevseg1]
		// state (3b/2a/3a) game is in end state and can only be reset [clk, reset, light_end] -> state 0
		
	logic random_delay;		// random wait delay after the game starts
	
	logic reaction_timer; 	// Used to find out the reaction time to rate
