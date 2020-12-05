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
			name := "Fighter"
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
				move_enemy(6)
				if not is_destroyed then
					if location.column >=1 then


					model.m.enemy_act_display_str.append ("    A Fighter(id:"+id.out+") moves: ["+model.m.row_indexes.item (location.row).out+","+(location.column +6).out+"] -> ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"]%N")
					model.m.enemy_projectile_list.put (create {ENEMY_PROJECTILE}.make (model.m.projectile_id, 15, 10,[location.row, (location.column - 1)]), model.m.projectile_id)
					model.m.enemy_act_display_str.append ("      A enemy projectile(id:"+model.m.projectile_id.out+") spawns at location ["+model.m.row_indexes.item (location.row).out+","+(location.column - 1).out+"].%N")
					model.m.projectile_id := model.m.projectile_id - 1
					is_turn_ended := true
					else
						model.m.enemy_act_display_str.append ("    A Fighter(id:"+id.out+") moves: ["+model.m.row_indexes.item (location.row).out+","+(location.column +6).out+"] -> out of board.%N")
					end
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
		do
			move_enemy (3)
			if not is_destroyed then
				if location.column >= 1 then
					model.m.enemy_act_display_str.append ("    A Fighter(id:"+id.out+") moves: ["+model.m.row_indexes.item (location.row).out+","+(location.column + 3).out+"] -> ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"]%N")
					model.m.enemy_projectile_list.put (create {ENEMY_PROJECTILE}.make (model.m.projectile_id, 20, 3,[location.row, (location.column - 1)]), model.m.projectile_id)
					model.m.enemy_act_display_str.append ("      A enemy projectile(id:"+model.m.projectile_id.out+") spawns at location ["+model.m.row_indexes.item (location.row).out+","+(location.column - 1).out+"].%N")
					model.m.projectile_id := model.m.projectile_id - 1
				else
					model.m.enemy_act_display_str.append ("    A Fighter(id:"+id.out+") moves: ["+model.m.row_indexes.item (location.row).out+","+(location.column + 4).out+"] -> out of board%N")
					model.m.enemy_table.remove (id)
				end
			end
		end
	action_when_starfighter_is_seen
		do
			move_enemy (1)
			if (not is_destroyed) then
				if location.column >= 1 then
					model.m.enemy_act_display_str.append ("    A Fighter(id:"+id.out+") moves: ["+model.m.row_indexes.item (location.row).out+","+(location.column + 1).out+"] -> ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"]%N")
					model.m.enemy_projectile_list.put (create {ENEMY_PROJECTILE}.make (model.m.projectile_id, 50, 6,[location.row, (location.column - 1)]), model.m.projectile_id)
					model.m.enemy_act_display_str.append ("      A enemy projectile(id:"+model.m.projectile_id.out+") spawns at location ["+model.m.row_indexes.item (location.row).out+","+(location.column - 1).out+"].%N")
					model.m.projectile_id := model.m.projectile_id - 1
				else
					model.m.enemy_act_display_str.append ("    A Fighter(id:"+id.out+") moves: ["+model.m.row_indexes.item (location.row).out+","+(location.column + 4).out+"] -> out of board%N")
					model.m.enemy_table.remove (id)
				end
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

