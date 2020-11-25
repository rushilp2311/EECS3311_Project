note
	description: "Summary description for {ENEMY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ENEMY

feature --Attributes
	location : TUPLE[row:INTEGER;column:INTEGER] assign set_location
	old_location : TUPLE[row:INTEGER;column:INTEGER] assign set_old_location
	total_health : INTEGER assign set_total_health
	current_health : INTEGER assign set_current_health
	regen : INTEGER assign set_regen
	armour : INTEGER assign set_armour
	vision : INTEGER assign set_vision
	symbol : STRING assign set_symbol
	seen_by_Starfighter : BOOLEAN assign set_seen_by_Starfighter
	can_see_Starfighter : BOOLEAN assign set_can_see_Starfighter
	is_turn_ended : BOOLEAN assign set_is_turn_ended
	model : ETF_MODEL_ACCESS
	is_destroyed : BOOLEAN assign set_is_destroyed

feature

	set_is_destroyed (sid : BOOLEAN)
		do
			is_destroyed := sid
		end

	set_is_turn_ended (te : BOOLEAN)
		do
			is_turn_ended := te
		end
	set_seen_by_Starfighter (ss : BOOLEAN)
		do
			seen_by_Starfighter := ss
		end

	set_can_see_Starfighter (cs : BOOLEAN)
		do
			can_see_Starfighter := cs
		end

	set_old_location (ot : TUPLE[row:INTEGER;column:INTEGER])
		do
			old_location := ot
		end


	set_location(t : TUPLE[row:INTEGER;column:INTEGER] )
		do
			location := t
		end
	set_current_health (ch: INTEGER)
		do
			current_health := ch
		end
	set_total_health (th: INTEGER)
		do
			total_health := th
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
	update_can_see_starfighter
		deferred
		end
	update_seen_by_starfighter
		deferred
		end

feature --Actions
	preemptive_action(sf_act : INTEGER)
		deferred
		end
	action_when_starfighter_is_not_seen
		deferred
		end
	action_when_starfighter_is_seen
		deferred
		end
	move_enemy(steps:INTEGER)
		deferred
		end
	check_for_obstacles(position:TUPLE[row:INTEGER;column:INTEGER])
		deferred
		end
end
