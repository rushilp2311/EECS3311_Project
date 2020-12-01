note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ABORT
inherit
	ETF_ABORT_INTERFACE
create
	make
feature -- command
	abort
    	do
			-- perform some update on the model state
			if model.in_game or model.in_setup then
				model.abort
			else
				model.set_error_output_msg (model.error.abort_in_game)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
