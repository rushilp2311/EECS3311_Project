note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SETUP_SELECT
inherit
	ETF_SETUP_SELECT_INTERFACE
create
	make
feature -- command
	setup_select(value: INTEGER_32)
		require else
			setup_select_precond(value)
    	do
			-- perform some update on the model state
			if model.setup_array[model.cursor].in_range (value) then
				if model.is_error = true then
					model.toggle_is_error
				end
				model.setup_array[model.cursor].select_choice (value)
				model.set_success_output_msg (model.setup_array[model.cursor].output)

			else
			if model.is_error = false then
					model.toggle_is_error
				end
			
				model.set_error_output_msg (model.error.option_out_of_range)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
