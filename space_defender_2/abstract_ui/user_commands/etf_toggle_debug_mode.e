note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_TOGGLE_DEBUG_MODE
inherit
	ETF_TOGGLE_DEBUG_MODE_INTERFACE
create
	make
feature -- command
	toggle_debug_mode
    	do
			-- perform some update on the model state
			model.increment_error_state_counter
			model.toggle_toggle_mode
			if model.in_toggle_mode then
				model.set_success_output_msg ("  In debug mode.")
			else
				model.set_success_output_msg ("  Not in debug mode.")
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
