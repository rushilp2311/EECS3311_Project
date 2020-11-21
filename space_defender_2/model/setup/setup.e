note
	description: "Summary description for {SETUP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SETUP
feature
	model_access:ETF_MODEL_ACCESS

	select_choice(choice:INTEGER)
		deferred
		end
	in_range(range:INTEGER):BOOLEAN
		deferred
		end
	output:STRING
		deferred
		end

end
