note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SETUP_NEXT
inherit
	ETF_SETUP_NEXT_INTERFACE
create
	make
feature -- command
	setup_next(state: INTEGER_32)
		require else
			setup_next_precond(state)
    	do
			-- perform some update on the model state
			-- TODO validaton

			if  model.in_setup then
				model.set_cursor_next (state)
				if model.cursor > 0 and model.cursor < 5 then
					model.setup_array[model.cursor].select_choice (1)
					model.set_success_output_msg (model.setup_array[model.cursor].output)
				else
					model.toggle_in_setup
					model.toggle_in_game
				end
			else
				model.toggle_is_error
				model.set_error_output_msg (model.error.setup_next_outside_setup)
			end

			if model.in_game and not (model.is_error) then
				across 1 |..| 3 as msa
				loop
					model.setup_array[msa.item].select_choice (model.ship.choice_selected[msa.item].pos)
				end
				model.play
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
