note
	description: "Summary description for {POWER_SETUP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POWER_SETUP
inherit
	SETUP
create
	make
feature
	make
		do

		end
feature
	select_choice(choice:INTEGER)
		do

		end
	check_range(range:INTEGER)
		do

		end
	output:STRING
		do
			create Result.make_empty
			Result := "Inside power"
		end
end
