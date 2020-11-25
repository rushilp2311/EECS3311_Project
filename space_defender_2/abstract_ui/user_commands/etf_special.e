note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SPECIAL
inherit
	ETF_SPECIAL_INTERFACE
create
	make
feature -- command
	special
    	do
			-- perform some update on the model state
			if model.in_setup then
								if model.is_error = false then
									model.toggle_is_error
								end
								model.set_error_output_msg (model.error.special_in_game)
							elseif (not model.in_game) then
								if model.is_error = false then
									model.toggle_is_error
								end

								model.set_error_output_msg (model.error.special_in_game)
							else
								if model.is_error = true then
									model.toggle_is_error
								end
								model.special

							end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
