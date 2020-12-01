note
	description: "Summary description for {FIGHTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FIGHTER
inherit
	ENEMY
create
	make
feature
	make(h:INTEGER;r:INTEGER;a:INTEGER;v:INTEGER)
		do
			create location.default_create
			current_health := h
			total_health := h
			regen := r
			armour := a
			vision := v
			is_turn_ended := false
			can_see_Starfighter := false
			seen_by_Starfighter := false
			create old_location.default_create
			create symbol.make_empty
			symbol := "F"
		end

	update_can_see_starfighter
		do

		end
	update_seen_by_starfighter
		do

		end
	preemptive_action(sf_act : INTEGER)
		do
			inspect
				sf_act
			when 1 then
				-- PASS
			when 2 then
				--FIRE
			when 3 then
				--SPECIAL
			else
			end
		end
	action_when_starfighter_is_not_seen
		do

		end
	action_when_starfighter_is_seen
		do

		end
	move_enemy(steps:INTEGER)
		do

		end

end

