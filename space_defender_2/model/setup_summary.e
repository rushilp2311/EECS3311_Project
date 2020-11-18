note
	description: "Summary description for {SETUP_SUMMARY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SETUP_SUMMARY
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
			Result := "Inside summary"
		end
end
