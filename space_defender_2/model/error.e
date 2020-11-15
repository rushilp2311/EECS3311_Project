note
	description: "Summary description for {ERROR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR
create
	make
feature {NONE}
	make
		do
			play_in_setup := "Already in setup mode."
			play_in_game := "Already in a game. Please abort to start a new one."
			thresold_value := "Thresold values are not non-decreasing."
			setup_next_outside_setup := "Command can only be used in setup mode."
			setup_back_outside_setup := "Command can only be used in setup mode."
			setup_select_outside_setup := "Command can only be used in setup mode (excluding summary in setup)."
			abort_in_game := "Command can only be used in setup mode or in game."
			option_out_of_range := "Menu option selceted out of range."
			move_in_game := "Command can only be used in game."
			move_outside_board := "Cannot move outside of board."
			move_same_location := "Already there."
			move_outside_range := "Out of movement range."
			move_outside_board := "Cannot move outside of board."
			move_resource := "Not enough resources to move."
			pass_in_game := "Command can only be used in game."
			fire_in_game := "Command can only be used in game."
			fire_resource := "Not enough resources to fire."
			special_in_game := "Command can only be used in game."
			special_resource := "Not enough resources to use special."
		end
feature
	play_in_setup:STRING
	play_in_game:STRING
	thresold_value:STRING
	setup_next_outside_setup:STRING
	setup_back_outside_setup:STRING
	setup_select_outside_setup:STRING
	option_out_of_range:STRING
	abort_in_game:STRING
	move_in_game:STRING
	move_outside_board:STRING
	move_same_location:STRING
	move_outside_range:STRING
	move_resource:STRING
	pass_in_game:STRING
	fire_in_game:STRING
	fire_resource:STRING
	special_in_game:STRING
	special_resource:STRING

end
