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
		model.set_cursor_back (state)
			if model.cursor > 0 then
				model.set_output_msg (model.setup_array[model.cursor].output)
			else
				model.toggle_in_setup
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
