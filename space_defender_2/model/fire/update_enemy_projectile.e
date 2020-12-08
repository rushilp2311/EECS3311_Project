note
	description: "Summary description for {UPDATE_ENEMY_PROJECTILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UPDATE_ENEMY_PROJECTILE
create
	make
feature
	model:ETF_MODEL_ACCESS
	i : INTEGER
	make
		do
			i := 0
		end
feature
	update_enemy_projectile_location
	local
		j,check_id,move : INTEGER
		old_location:TUPLE[row:INTEGER;column:INTEGER]
		do
			from i := -1
			until
				i <= model.m.projectile_id
			loop
				create old_location.default_create
				model.m.e_act_collision_str.make_empty
				if attached model.m.enemy_projectile_list.item (i.item) as fp then
					if  model.m.enemy_projectile_list.has (i.item) and fp.location.column >= 1  then
						model.m.board.put ("_",fp.location.row , fp.location.column)
					end
					old_location.row := fp.location.row
					old_location.column := fp.location.column
				  -- TODO move one step at a time
					from j := 1
					until
				    	 j >fp.move_update
					loop
						check_id := model.m.collision.check_for_collision ([fp.location.row,fp.location.column-1], i, 1)

						if fp.is_destroyed = false then
							fp.location.column := fp.location.column - 1

						else
							fp.location.column := fp.location.column - 1
							j := fp.move_update + 1
							model.m.board.put ("_",fp.location.row , fp.location.column)
							model.m.enemy_projectile_list.remove (fp.id)
						end
						move := move + 1
						--Check for collision
						j := j + 1
					end
			 		if fp.location.column >= 1  then
			 			model.m.enemy_projectile_move_str.append ("    A enemy projectile(id:"+i.out+") moves: ["+model.m.row_indexes.item (old_location.row).out+","+(old_location.column).out+"] -> ["+model.m.row_indexes.item (fp.location.row).out+","+fp.location.column.out+"]%N")
						if  fp.is_destroyed = false   then
							model.m.board.put ("<",fp.location.row , fp.location.column)
						else
							model.m.enemy_projectile_list.remove (fp.id)
						end
			 		else
						model.m.enemy_projectile_move_str.append ("    A enemy projectile(id:"+i.out+") moves: ["+model.m.row_indexes.item (old_location.row).out+","+(old_location.column).out+"] -> out of board%N")
						model.m.enemy_projectile_list.remove (fp.id)
					end

				end
			i := i - 1
				model.m.enemy_projectile_move_str.append (model.m.e_act_collision_str)
			end

		end
	end
