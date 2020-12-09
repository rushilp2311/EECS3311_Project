note
	description: "Summary description for {GRUNT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRUNT
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
			symbol := "G"
			name := "Grunt"
		end

	add_score
		local
			silver : ORB
		do
			create {SILVER} silver.make
			model.m.score.add (silver)
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
				total_health := total_health + 10
				current_health := current_health + 10
				model.m.enemy_act_display_str.append ("    A Grunt(id:"+id.out+") gains 10 total health.%N")
			when 2 then
				--FIRE
			when 3 then
				--SPECIAL
				total_health := total_health + 20
				current_health := current_health + 20
				model.m.enemy_act_display_str.append ("    A Grunt(id:"+id.out+") gains 20 total health.%N")

			else

			end
			is_turn_ended := false

		end
	action_when_starfighter_is_not_seen
	local
		check_id:INTEGER
		do
			model.m.e_act_collision_str.make_empty
			--REGENRATION
			if current_health /= total_health then
				current_health := current_health + regen
			end
			if current_health > total_health then
				current_health := total_health
			end
			move_enemy(2)
			if not is_destroyed then
				if location.column >=1 then

				model.m.enemy_projectile_list.put (create {ENEMY_PROJECTILE}.make (model.m.projectile_id, 15, 4,[location.row, (location.column - 1)]), model.m.projectile_id)
					if location.column - 1 >=1 then
						model.m.enemy_act_display_str.append ("      A enemy projectile(id:"+model.m.projectile_id.out+") spawns at location ["+model.m.row_indexes.item (location.row).out+","+(location.column - 1).out+"].%N")
					else
						model.m.enemy_projectile_list.remove (model.m.projectile_id)
						model.m.enemy_act_display_str.append ("      A enemy projectile(id:"+model.m.projectile_id.out+") spawns at location out of board.%N")
					end

					if attached model.m.enemy_projectile_list.item (model.m.projectile_id) as ep then
							check_id := model.m.collision.check_for_collision ([location.row, (location.column - 1)], ep.id, 1)
							if ep.is_destroyed = false then

							else
								model.m.enemy_projectile_list.remove (ep.id)
							end
						end
						model.m.projectile_id := model.m.projectile_id - 1
			else
					if old_location.row = location.row and old_location.column = location.column then
						model.m.enemy_act_display_str.append ("    A "+name+"(id:"+id.out+") stays at: ["+model.m.row_indexes.item (old_location.row).out+","+(old_location.column).out+"]%N")
					else
						model.m.enemy_act_display_str.append ("    A "+name+"(id:"+id.out+") moves: ["+model.m.row_indexes.item (old_location.row).out+","+(old_location.column).out+"] -> out of board%N")
					end
					model.m.enemy_table.remove (id)
				end
				model.m.enemy_act_display_str.append (model.m.e_act_collision_str)
				model.m.e_act_collision_str.make_empty
			end

		end
	action_when_starfighter_is_seen
	local
		check_id:INTEGER
		do
			model.m.e_act_collision_str.make_empty
			--REGENRATION
			if current_health /= total_health then
				current_health := current_health + regen
			end
			if current_health > total_health then
				current_health := total_health
			end
			move_enemy(4)
			if not is_destroyed then
				if location.column >=1 then

					model.m.enemy_act_display_str.append (model.m.e_act_collision_str)
					model.m.enemy_projectile_list.put (create {ENEMY_PROJECTILE}.make (model.m.projectile_id, 15, 4,[location.row, (location.column - 1)]), model.m.projectile_id)
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
				else
					if old_location.row = location.row and old_location.column = location.column then
						model.m.enemy_act_display_str.append ("    A "+name+"(id:"+id.out+") stays at: ["+model.m.row_indexes.item (old_location.row).out+","+(old_location.column).out+"]%N")
					else
						model.m.enemy_act_display_str.append ("    A "+name+"(id:"+id.out+") moves: ["+model.m.row_indexes.item (old_location.row).out+","+(old_location.column).out+"] -> out of board%N")
					end
					model.m.enemy_table.remove (id)
				end
				model.m.enemy_act_display_str.append (model.m.e_act_collision_str)
				model.m.e_act_collision_str.make_empty
			end

		end
	move_enemy(steps:INTEGER)
		local
			i,check_id:INTEGER

		do
			model.m.e_act_collision_str.make_empty
			old_location.row := location.row
			old_location.column := location.column
			if location.column >=1  then
				model.m.board.put ("_", current.location.row, current.location.column)
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
			end

			model.m.enemy_act_display_str.append (model.m.e_act_collision_str)
			model.m.e_act_collision_str.make_empty
			-- CHECK IF OUTSIDE BOARD and delete
		end

end
