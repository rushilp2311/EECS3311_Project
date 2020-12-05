note
	description: "Summary description for {INTERCEPTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INTERCEPTOR
inherit
	ENEMY
create
	make
feature
	make(i_d:INTEGER;h:INTEGER;r:INTEGER;a:INTEGER;v:INTEGER)
		do
			create location.default_create
			current_health := h
			total_health := h
			id:= i_d
			regen := r
			armour := a
			vision := v
			is_turn_ended := false
			can_see_Starfighter := false
			seen_by_Starfighter := false
			create old_location.default_create
			create symbol.make_empty
			symbol := "I"
			name := "Interceptor"
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
			move_enemy(3)
			if not is_destroyed then
				model.m.enemy_act_display_str.append ("    A Interceptor(id:"+id.out+") moves: ["+model.m.row_indexes.item (location.row).out+","+(location.column + 3).out+"] -> ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"]%N")
			end
		end
	action_when_starfighter_is_seen
		do
			move_enemy(3)
			if not is_destroyed then
				model.m.enemy_act_display_str.append ("    A Interceptor(id:"+id.out+") moves: ["+model.m.row_indexes.item (location.row).out+","+(location.column + 3).out+"] -> ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"]%N")
			end
		end
	move_enemy(steps:INTEGER)
		local
			i:INTEGER

		do
			model.m.board.put ("_", current.location.row, current.location.column)
			from
				i:=1
			until
				i > steps
			loop
				if not is_destroyed then
					current.location.column := current.location.column - 1
				end
				i := i+1
			end
			-- CHECK IF OUTSIDE BOARD and delete

		end
end
