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
			can_see_starfighter := ((location.row - model.m.ship.location.row).abs + (location.column - model.m.ship.location.column).abs) <= vision
		end
	update_seen_by_starfighter
		do
			seen_by_starfighter := ((location.row - model.m.ship.location.row).abs + (location.column - model.m.ship.location.column).abs) <= model.m.ship.vision
		end
	preemptive_action(sf_act : INTEGER)
		do
			inspect
						sf_act
					when 1 then
						-- PASS

					when 2 then
						--FIRE
						move_enemy_vertical(model.m.ship.location.row - location.row)
						is_turn_ended := true
					when 3 then
						--SPECIAL
						
					else

					end
		end
	action_when_starfighter_is_not_seen
		do
			move_enemy(3)
			if not is_destroyed then
				if location.row >= 1 and location.row <= model.m.board.height and (location.column >=1) and (location.column <= model.m.board.width) then
				else
					model.m.enemy_table.remove (id)
				end
			end
		end
	action_when_starfighter_is_seen
		do
			move_enemy(3)
			if not is_destroyed then
				if location.row >= 1 and location.row <= model.m.board.height and (location.column >=1) and (location.column <= model.m.board.width) then
				else
					model.m.enemy_table.remove (id)
				end
			end
		end
	move_enemy(steps:INTEGER)
		local
			i,check_id,index,k:INTEGER
			is_enemy:BOOLEAN

		do
		model.m.e_act_collision_str.make_empty
		old_location.row := location.row
		old_location.column := location.column
		if location.row >= 1 and location.row <= model.m.board.height and (location.column >=1) and (location.column <= model.m.board.width)  then
			model.m.board.put ("_", location.row, location.column)
		end

			from
				i:=1
			until
				i > steps
			loop
				check_id := model.m.collision.check_for_collision ([current.location.row,current.location.column - 1], id, 3)
				if not is_destroyed and (check_id /= 1) then
					current.location.column := current.location.column - 1
				else
					i := steps + 1
					current.location.column := current.location.column
				end

				i := i+1
			end
			if location.column >=1  then
				model.m.enemy_act_display_str.append ("    A "+name+"(id:"+id.out+") moves: ["+model.m.row_indexes.item (location.row).out+","+(old_location.column).out+"] -> ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"]%N")
			end
			model.m.enemy_act_display_str.append (model.m.e_act_collision_str)
		end

	move_enemy_vertical(steps:INTEGER)
		local
			i,check_id:INTEGER
		do
		model.m.e_act_collision_str.make_empty
			old_location.row := location.row
			old_location.column := location.column
			if steps > 0 then
				if location.row >= 1 and location.row <= model.m.board.height and not is_destroyed then
					model.m.board.put ("_", location.row, location.column)
				end
				-- MOVE DOWN
				from
					i:=1
				until
					i > steps.abs
				loop
					check_id := model.m.collision.check_for_collision ([current.location.row + 1, current.location.column], id, 3)
					if not is_destroyed and (check_id /= 1) then
						current.location.row := current.location.row + 1
					else
						i := steps + 1
						current.location.row := current.location.row
					end
					i := i + 1
				end
				if location.row >= 1 and location.row <= model.m.board.height then
					model.m.enemy_act_display_str.append ("    A Interceptor(id:"+id.out+") moves: ["+model.m.row_indexes.item (old_location.row).out+","+(old_location.column).out+"] -> ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"]%N")
				end
				model.m.enemy_act_display_str.append (model.m.e_act_collision_str)



			elseif steps < 0 then
				if location.row >= 1 and location.row <= model.m.board.height and not is_destroyed then
					model.m.board.put ("_", location.row, location.column)
				end
				--MOVE UP
				from
					i:=1
				until
					i > steps.abs
				loop
					check_id := model.m.collision.check_for_collision ([current.location.row - 1, current.location.column], id, 3)
					if not is_destroyed and (check_id /= 1) then
						current.location.row := current.location.row - 1
					else
						i := steps + 1
						current.location.row := current.location.row
					end
					i := i + 1
				end
				if location.row >= 1 and location.row <= model.m.board.height then
					model.m.enemy_act_display_str.append ("    A Interceptor(id:"+id.out+") moves: ["+model.m.row_indexes.item (old_location.row).out+","+(old_location.column).out+"] -> ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"]%N")
				end
				model.m.enemy_act_display_str.append (model.m.e_act_collision_str)
			else
				--STAYS
			end
		end






end
