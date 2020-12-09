note
	description: "Summary description for {CARRIER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CARRIER
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
			symbol := "C"
			name:="Carrier"
		end

	add_score
		local
			diamond : FOCUS
		do
			create {DIAMOND} diamond.make
			model.m.score.add (diamond)
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
		check_id,check_id1:INTEGER
		do
			inspect
					sf_act
				when 1 then
					-- PASS
					move_enemy(2)
--					if not is_destroyed then
--						if location.column >= 1 then
--							model.m.enemy_table.extend (create {INTERCEPTOR}.make(model.m.enemy_id,50,0,0,5), model.m.enemy_id)

--							check_id := model.m.collision.check_for_collision ([location.row-1,location.column], model.m.enemy_id, 3)
--							if attached model.m.enemy_table.item (model.m.enemy_id) as current_enemy then
--								if (check_id /=1) and not current_enemy.is_destroyed  then
--									if (location.row - 1 >= 1) and (location.row - 1<= model.m.board.height) and (location.column >=1) and (location.column <= model.m.board.width)then
--										current_enemy.location.row := location.row-1
--										current_enemy.location.column := location.column
--										current_enemy.is_turn_ended := true

--										model.m.enemy_act_display_str.append ("      A Interceptor(id:"+model.m.enemy_id.out+") spawns at location ["+model.m.row_indexes.item (current_enemy.location.row).out+","+(current_enemy.location.column).out+"].%N")
--									else
--										model.m.enemy_act_display_str.append ("      A Interceptor(id:"+model.m.enemy_id.out+") spawns at location out of board.%N")

--									end
--								end
--							end

--							if check_id /= 1 then
--								model.m.enemy_id := model.m.enemy_id + 1

--							end


--							model.m.enemy_table.extend (create {INTERCEPTOR}.make(model.m.enemy_id,50,0,0,5), model.m.enemy_id)

--							check_id := model.m.collision.check_for_collision ([location.row+1,location.column], model.m.enemy_id, 3)
--							if attached model.m.enemy_table.item (model.m.enemy_id) as current_enemy then
--										current_enemy.location.row := location.row+1
--										current_enemy.location.column := location.column
--								if (check_id /=1) and not current_enemy.is_destroyed  then
--									if (current_enemy.location.row >= 1) and (current_enemy.location.row<= model.m.board.height) and (current_enemy.location.column >=1) and (current_enemy.location.column <= model.m.board.width)then

--										current_enemy.is_turn_ended := true
--										model.m.enemy_act_display_str.append ("      A Interceptor(id:"+model.m.enemy_id.out+") spawns at location ["+model.m.row_indexes.item (current_enemy.location.row).out+","+(current_enemy.location.column).out+"].%N")
--									else
--										model.m.enemy_act_display_str.append ("      A Interceptor(id:"+model.m.enemy_id.out+") spawns at location out of board.%N")

--									end
--								end
--							end

--							if check_id /= 1 then
--								model.m.enemy_id := model.m.enemy_id + 1
--							end

--						end
--						else
--							model.m.enemy_table.remove (id)
--					end


					is_turn_ended := true
				when 2 then
					--FIRE
				when 3 then
					--SPECIAL
					regen := regen + 10
					model.m.enemy_act_display_str.append ("    A "+name+"(id:"+id.out+") gains 10 regen.%N")
				else
				end
		end
	action_when_starfighter_is_not_seen
		do
			move_enemy(2)
			if not is_destroyed then
				if location.column >= 1 then

				end
			end

		end
	action_when_starfighter_is_seen
	local
		check_id:INTEGER
		do
			move_enemy(1)
			if not is_destroyed then
				if location.column >= 1 then
					model.m.enemy_table.extend (create {INTERCEPTOR}.make(model.m.enemy_id,50,0,0,5), model.m.enemy_id)

					check_id := model.m.collision.check_for_collision ([location.row,location.column-1], model.m.enemy_id, 3)
					if attached model.m.enemy_table.item (model.m.enemy_id) as current_enemy then
								if (check_id /=1) and not current_enemy.is_destroyed  then
									if (location.row >= 1) and (location.row <= model.m.board.height) and (location.column-1 >=1) and (location.column-1 <= model.m.board.width)then
										current_enemy.location.row := location.row+1
										current_enemy.location.column := location.column
										current_enemy.is_turn_ended := true
										model.m.enemy_act_display_str.append ("      A Interceptor(id:"+model.m.enemy_id.out+") spawns at location ["+model.m.row_indexes.item (current_enemy.location.row).out+","+(current_enemy.location.column).out+"].%N")
									else
										model.m.enemy_act_display_str.append ("      A Interceptor(id:"+model.m.enemy_id.out+") spawns at location out of board.%N")
										model.m.enemy_table.remove (model.m.enemy_id)
									end
								else
										model.m.enemy_table.remove (id)

								end
					end
					if check_id /= 1 then
												model.m.enemy_id := model.m.enemy_id + 1
											end
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
				model.m.enemy_act_display_str.append ("    A "+name+"(id:"+id.out+") moves: ["+model.m.row_indexes.item (location.row).out+","+(old_location.column).out+"] -> ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"]%N")

			else
				model.m.enemy_act_display_str.append ("    A "+name+"(id:"+id.out+") moves: ["+model.m.row_indexes.item (location.row).out+","+(old_location.column).out+"] -> out of board%N")
			end
			model.m.enemy_act_display_str.append (model.m.e_act_collision_str)
			-- CHECK IF OUTSIDE BOARD and delete
		end
end
