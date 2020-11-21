note
	description: "Summary description for {ENEMY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ENEMY

feature --Attributes
	location : TUPLE[row:INTEGER;column:INTEGER] assign set_location
	health : INTEGER assign set_health
	regen : INTEGER assign set_regen
	armour : INTEGER assign set_armour
	vision : INTEGER assign set_vision
	symbol : STRING assign set_symbol
	
feature

	set_location(t : TUPLE[row:INTEGER;column:INTEGER] )
		do
			location := t
		end
	set_health (h: INTEGER)
		do
			health := h
		end
	set_regen (r: INTEGER)
		do
			regen := r
		end
	set_armour (a: INTEGER)
		do
			armour := a
		end
	set_vision (v: INTEGER)
		do
			vision := v
		end
	set_symbol (s: STRING)
		do
			symbol := s
		end



feature
	can_see_starfighter
		deferred
		end
	seen_by_starfighter
		deferred
		end

feature --Actions
	preemptive_action
		deferred
		end
	action_when_starfighter_is_not_seen
		deferred
		end
	action_when_starfighter_is_seen
		deferred
		end
end
