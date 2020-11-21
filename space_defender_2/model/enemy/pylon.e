note
	description: "Summary description for {PYLON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PYLON

inherit
	ENEMY
create
	make
feature
	make
		do
			create location.default_create
			health := 0
			regen := 0
			armour := 0
			vision := 0
			create symbol.make_empty
			symbol := "P"
		end

	can_see_starfighter
		do

		end
	seen_by_starfighter
		do

		end
	preemptive_action
		do

		end
	action_when_starfighter_is_not_seen
		do

		end
	action_when_starfighter_is_seen
		do

		end

end
