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
	make(i_d:INTEGER;h:INTEGER;r:INTEGER;a:INTEGER;v:INTEGER)
		do
			create location.default_create
				id:= i_d
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
			name := "Fighter"
		end

	add_score
		local
			gold : ORB
		do
			create {GOLD} gold.make
			model.m.score.add (gold)
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
	local
		check_id:INTEGER
		do
			inspect
				sf_act
			when 1 then
				-- PASS
				move_enemy(6)
				if not is_destroyed then
					if location.column >=1 then
						model.m.enemy_projectile_list.put (create {ENEMY_PROJECTILE}.make (model.m.projectile_id, 100, 10,[location.row, (location.column - 1)]), model.m.projectile_id)
						if location.column - 1 >=1 then
							model.m.enemy_act_display_str.append ("      A enemy projectile(id:"+model.m.projectile_id.out+") spawns at location ["+model.m.row_indexes.item (location.row).out+","+(location.column - 1).out+"].%N")
						else
							model.m.enemy_projectile_list.remove (model.m.projectile_id)
							model.m.enemy_act_display_str.append ("      A enemy projectile(id:"+model.m.projectile_id.out+") spawns at location out of board%N")
						end

						if attached model.m.enemy_projectile_list.item (model.m.projectile_id) as ep then
							check_id := model.m.collision.check_for_collision ([location.row, (location.column - 1)], ep.id, 1)
							if ep.is_destroyed = false then

							else
								model.m.enemy_projectile_list.remove (ep.id)
							end
						end
						model.m.projectile_id := model.m.projectile_id - 1
						is_turn_ended := true
					else
						model.m.enemy_table.remove (id)
					end

						model.m.enemy_act_display_str.append (model.m.e_act_collision_str)

				else
					model.m.enemy_table.remove (id)
				end
			when 2 then
				--FIRE
				armour := armour + 1
				is_turn_ended := false
			when 3 then
				--SPECIAL
			else
			end
		end
	action_when_starfighter_is_not_seen
	local
		check_id:INTEGER
		do
			move_enemy (3)
			if not is_destroyed then
				if location.column >= 1 then
--					model.m.enemy_act_display_str.append ("    A Fighter(id:"+id.out+") moves: ["+model.m.row_indexes.item (location.row).out+","+(location.column + 3).out+"] -> ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"]%N")
					model.m.enemy_projectile_list.put (create {ENEMY_PROJECTILE}.make (model.m.projectile_id, 20, 3,[location.row, (location.column - 1)]), model.m.projectile_id)

					if location.column - 1 >=1 then
						model.m.enemy_act_display_str.append ("      A enemy projectile(id:"+model.m.projectile_id.out+") spawns at location ["+model.m.row_indexes.item (location.row).out+","+(location.column - 1).out+"].%N")
					else
						model.m.enemy_projectile_list.remove (model.m.projectile_id)
						model.m.enemy_act_display_str.append ("      A enemy projectile(id:"+model.m.projectile_id.out+") spawns at location out of board.%N")
					end

					model.m.projectile_id := model.m.projectile_id - 1
					if attached model.m.enemy_projectile_list.item (model.m.projectile_id) as ep then
							check_id := model.m.collision.check_for_collision ([location.row, (location.column - 1)], ep.id, 1)
							if ep.is_destroyed = false then

							else
								model.m.enemy_projectile_list.remove (ep.id)
							end
						end
				else

					model.m.enemy_table.remove (id)
				end
			end
		end
	action_when_starfighter_is_seen
	local
		check_id:INTEGER
		do
			move_enemy (1)
			if (not is_destroyed) then
				if location.column >= 1 then
--					model.m.enemy_act_display_str.append ("    A Fighter(id:"+id.out+") moves: ["+model.m.row_indexes.item (location.row).out+","+(location.column + 1).out+"] -> ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"]%N")
					model.m.enemy_projectile_list.put (create {ENEMY_PROJECTILE}.make (model.m.projectile_id, 50, 6,[location.row, (location.column - 1)]), model.m.projectile_id)

					if location.column - 1 >=1 then
						model.m.enemy_act_display_str.append ("      A enemy projectile(id:"+model.m.projectile_id.out+") spawns at location ["+model.m.row_indexes.item (location.row).out+","+(location.column - 1).out+"].%N")
					else
						model.m.enemy_projectile_list.remove (model.m.projectile_id)
						model.m.enemy_act_display_str.append ("      A enemy projectile(id:"+model.m.projectile_id.out+") spawns at location out of board.%N")
					end


					model.m.projectile_id := model.m.projectile_id - 1
					if attached model.m.enemy_projectile_list.item (model.m.projectile_id) as ep then
							check_id := model.m.collision.check_for_collision ([location.row, (location.column - 1)], ep.id, 1)
							if ep.is_destroyed = false then

							else
								model.m.enemy_projectile_list.remove (ep.id)
							end
						end
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
		if location.column >=1  then
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
				if old_location.row = location.row and old_location.column = location.column then
							model.m.enemy_act_display_str.append ("    A "+name+"(id:"+id.out+") stays at: ["+model.m.row_indexes.item (old_location.row).out+","+(old_location.column).out+"]%N")
					else
						model.m.enemy_act_display_str.append ("    A "+name+"(id:"+id.out+") moves: ["+model.m.row_indexes.item (old_location.row).out+","+(old_location.column).out+"] -> ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"]%N")
					end
			else
				model.m.enemy_act_display_str.append ("    A "+name+"(id:"+id.out+") moves: ["+model.m.row_indexes.item (location.row).out+","+(old_location.column).out+"] -> out of board%N")
			end
			model.m.enemy_act_display_str.append (model.m.e_act_collision_str)
			-- CHECK IF OUTSIDE BOARD and delete
		end

end

