note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SETUP_BACK
inherit
	ETF_SETUP_BACK_INTERFACE
create
	make
feature -- command
	setup_back(state: INTEGER_32)
		require else
			setup_back_precond(state)
    	do
			-- perform some update on the model state

		if  model.in_setup then
			model.set_cursor_back (state)
			if model.cursor > 0 and model.cursor <= 5 then
				model.set_success_output_msg (model.setup_array[model.cursor].output)
			else
				model.toggle_in_setup
				model.toggle_in_game
			end
		else
			if model.is_error = false then
				model.toggle_is_error
			end
			model.increment_error_state_counter
			model.set_error_output_msg (model.error.setup_back_outside_setup)
		end
		etf_cmd_container.on_change.notify ([Current])
    	end

end
