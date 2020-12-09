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
			symbol := "P"
			name := "Pylon"
		end

	add_score
		local
			platinum : FOCUS
		do
			create {PLATINUM} platinum.make
			model.m.score.add (platinum)
		end


	heal_enemies
	local
		i :INTEGER
		do
			from
				i := 1
			until
				i > model.m.enemy_id
			loop
				if attached model.m.enemy_table.item (i) as e then
					if ((location.row - e.location.row).abs + (location.column - e.location.column).abs) <= vision then
						e.current_health := e.current_health + 10
						if e.current_health > e.total_health then
							e.current_health := e.total_health
						end
						model.m.enemy_act_display_str.append("      The Pylon heals "+e.name+"(id:"+e.id.out+") at location ["+model.m.row_indexes.item (e.location.row).out+","+(e.location.column).out+"] for 10 damage.%N")
					end
				end

				i:= i+1
			end
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
			when 3 then
				--SPECIAL
			else
			end
		end
	action_when_starfighter_is_not_seen
		do
			move_enemy(2)
			if not is_destroyed then
				if location.column >= 1 then
					model.m.enemy_act_display_str.append ("    A Pylon(id:"+id.out+") moves: ["+model.m.row_indexes.item (location.row).out+","+(location.column + 2).out+"] -> ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"]%N")
					heal_enemies
					current_health := current_health + 10
					if current_health > total_health then
						current_health := total_health
					end
				else
					model.m.enemy_act_display_str.append ("    A Pylon(id:"+id.out+") moves: ["+model.m.row_indexes.item (location.row).out+","+(location.column + 2).out+"] -> out of board%N")
					model.m.enemy_table.remove (id)
				end
			end
		end
	action_when_starfighter_is_seen
		do
			move_enemy (1)
			if not is_destroyed then
				if location.column >= 1 then
					model.m.enemy_act_display_str.append ("    A Pylon(id:"+id.out+") moves: ["+model.m.row_indexes.item (location.row).out+","+(location.column + 1).out+"] -> ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"]%N")
					model.m.enemy_projectile_list.put (create {ENEMY_PROJECTILE}.make (model.m.projectile_id, 70, 2,[location.row, (location.column - 1)]), model.m.projectile_id)
					model.m.enemy_act_display_str.append ("      A enemy projectile(id:"+model.m.projectile_id.out+") spawns at location ["+model.m.row_indexes.item (location.row).out+","+(location.column - 1).out+"].%N")
					model.m.projectile_id := model.m.projectile_id - 1
				else
					model.m.enemy_act_display_str.append ("    A Pylon(id:"+id.out+") moves: ["+model.m.row_indexes.item (location.row).out+","+(location.column + 1).out+"] -> out of board%N")
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
