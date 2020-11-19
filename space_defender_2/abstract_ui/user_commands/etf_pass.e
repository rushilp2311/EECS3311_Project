note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PASS
inherit
	ETF_PASS_INTERFACE
create
	make
feature -- command
	pass
    	do
			-- perform some update on the model state
			if model.in_setup then
				if model.is_error = false then
					model.toggle_is_error
				end
				model.set_error_output_msg (model.error.pass_in_game)
			elseif (not model.in_game) then
				if model.is_error = false then
					model.toggle_is_error
				end

				model.set_error_output_msg (model.error.pass_in_game)
			else
				if model.is_error = true then
					model.toggle_is_error
				end

			end


			etf_cmd_container.on_change.notify ([Current])
    	end

end
