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
		j : INTEGER
		old_location:TUPLE[row:INTEGER;column:INTEGER]
		do
			from i := -1
						until
							i <= model.m.projectile_id
						loop
							if attached model.m.enemy_projectile_list.item (i.item) as fp then
								if  model.m.enemy_projectile_list.has (i.item) and fp.location.column >= 1  then


								model.m.board.put ("_",fp.location.row , fp.location.column)
								end
								old_location := fp.location
						    -- TODO move one step at a time
								from j := 1
								until
									j >fp.move_update
								loop
									fp.location.column := fp.location.column - 1
									--Check for collision
									j := j + 1
								end
						 		if fp.location.column >= 1  then
						 			model.m.enemy_projectile_move_str.append ("    A enemy projectile(id:"+i.out+") moves: ["+model.m.row_indexes.item (fp.location.row).out+","+(fp.location.column+fp.move_update).out+"] -> ["+model.m.row_indexes.item (fp.location.row).out+","+fp.location.column.out+"]%N")
									if  model.m.enemy_projectile_list.has (i.item)   then
									model.m.board.put ("<",fp.location.row , fp.location.column)
									end
						 		else
						 			model.m.enemy_projectile_move_str.append ("    A enemy projectile(id:"+i.out+") moves: ["+model.m.row_indexes.item (fp.location.row).out+","+(fp.location.column+fp.move_update).out+"] -> out of board%N")
						 			model.m.enemy_projectile_list.remove (fp.id)
						 		end

							end
							i := i - 1

					end
		end
end
