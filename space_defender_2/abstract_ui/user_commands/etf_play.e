note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PLAY
inherit
	ETF_PLAY_INTERFACE
create
	make
feature -- command
	play(row: INTEGER_32 ; column: INTEGER_32 ; g_threshold: INTEGER_32 ; f_threshold: INTEGER_32 ; c_threshold: INTEGER_32 ; i_threshold: INTEGER_32 ; p_threshold: INTEGER_32)
		require else
			play_precond(row, column, g_threshold, f_threshold, c_threshold, i_threshold, p_threshold)
    	do
			-- perform some update on the model state
			if model.in_setup then
				model.set_error_output_msg(model.error.play_in_setup)
			elseif model.in_game then
				model.increment_error_state_counter
				model.set_error_output_msg (model.error.play_in_game)
			else
				if (g_threshold <= f_threshold) and (f_threshold <= c_threshold) and (c_threshold <= i_threshold) and (i_threshold<=p_threshold)  then
					model.set_parameters (row, column, g_threshold, f_threshold, c_threshold, i_threshold, p_threshold)
					model.cursor := 1
					model.set_setup_array
					model.toggle_in_setup
					model.setup_array[model.cursor].select_choice(model.ship.choice_selected[model.cursor].pos)
					model.set_success_output_msg (model.setup_array[model.cursor].output)
				else
					model.toggle_is_error
					model.set_error_output_msg (model.error.thresold_value)
				end



			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
