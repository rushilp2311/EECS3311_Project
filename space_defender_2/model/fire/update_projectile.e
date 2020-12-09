note
	description: "Summary description for {UPDATE_PROJECTILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UPDATE_PROJECTILE
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
	update_friendly_projectile
	local
		choice : INTEGER
		do
			choice := model.m.ship.choice_selected[1].pos
			inspect
				choice
			when 1 then
				update_standard
			when 2 then
				update_spread
			when 3 then
				update_snipe
			when 4 then
				update_rocket
			when 5 then
				update_splitter
			else

			end
		end
	update_standard
	local
		j,check_id,move : INTEGER
		old_location:TUPLE[row:INTEGER;column:INTEGER]
		do

			from i := -1
				until
					i <= model.m.projectile_id
				loop
					create old_location.default_create
					if attached model.m.friendly_projectile_list.item (i.item) as fp then
						model.m.board.put ("_",fp.location.row , fp.location.column)

						old_location.row := fp.location.row
						old_location.column := fp.location.column
				    -- TODO move one step at a time
					from j := 1
					until
						j >=6
					loop
						check_id := model.m.collision.check_for_collision ([fp.location.row,fp.location.column+1], i, 0)
						if fp.is_destroyed = false then
							fp.location.column := fp.location.column + 1

						else
							fp.location.column := fp.location.column + 1
							j := 7
							model.m.board.put ("_",fp.location.row , fp.location.column)
							model.m.friendly_projectile_list.remove (fp.id)
						end
						move := move + 1
						--Check for collision


						j := j + 1
					end
				 if fp.location.column <= model.m.board.width  then
				 	model.m.projectile_move_str.append ("    A friendly projectile(id:"+i.out+") moves: ["+model.m.row_indexes.item (old_location.row).out+","+(old_location.column).out+"] -> ["+model.m.row_indexes.item (fp.location.row).out+","+fp.location.column.out+"]%N")

					if fp.is_destroyed = false then
						model.m.board.put ("*",fp.location.row , fp.location.column)
					else
						model.m.friendly_projectile_list.remove (fp.id)
					end

				 else
				 	model.m.projectile_move_str.append ("    A friendly projectile(id:"+i.out+") moves: ["+model.m.row_indexes.item (fp.location.row).out+","+(fp.location.column-5).out+"] -> out of board%N")
				 	model.m.friendly_projectile_list.remove (fp.id)
				 end
				 model.m.projectile_move_str.append (model.m.fp_act_collision_str)
					end

					i := i - 1

			end

		end
	update_spread
	local
		check_id:INTEGER
		do
			from i := -1
				until
					i <= model.m.projectile_id
				loop
				if attached model.m.friendly_projectile_list.item (i.item) as fp then
					model.m.board.put ("_",fp.location.row , fp.location.column)

					check_id := model.m.collision.check_for_collision ([fp.location.row,fp.location.column+1], i.item, 0)

					if fp.is_destroyed = false then
						if (fp.location.column+1 <= model.m.board.width and fp.location.row > 0) then
							fp.location.column := fp.location.column + 1
							fp.location.row := fp.location.row
							model.m.board.put ("*",fp.location.row , fp.location.column)
							model.m.projectile_move_str.append ("    A friendly projectile(id:"+i.out+") moves: ["+model.m.row_indexes.item (fp.location.row).out+","+(fp.location.column -1).out+"] -> ["+model.m.row_indexes.item (fp.location.row).out+","+fp.location.column.out+"]%N")
						else
							model.m.projectile_move_str.append ("    A friendly projectile(id:"+i.out+") moves: ["+model.m.row_indexes.item (fp.location.row).out+","+(fp.location.column-1).out+"] -> out of board%N")
				 			model.m.friendly_projectile_list.remove (fp.id)
						end
					else
						model.m.friendly_projectile_list.remove (fp.id)
					end

				end
				model.m.projectile_move_str.append (model.m.fp_act_collision_str)

				if attached model.m.friendly_projectile_list.item (i.item -1 ) as fp then
					model.m.board.put ("_",fp.location.row , fp.location.column)

					check_id := model.m.collision.check_for_collision ([fp.location.row-1,fp.location.column+1], (i.item -1 ), 0)

					if fp.is_destroyed = false then
						if fp.location.column+1 <= model.m.board.width  and fp.location.row-1 <= model.m.board.height and fp.location.row -1 > 0 and fp.location.column+1 >= 1 then
							fp.location.column := fp.location.column + 1
							fp.location.row := fp.location.row-1
							model.m.board.put ("*",fp.location.row , fp.location.column)
							model.m.projectile_move_str.append ("    A friendly projectile(id:"+(i-1).out+") moves: ["+model.m.row_indexes.item (fp.location.row+1).out+","+(fp.location.column -1).out+"] -> ["+model.m.row_indexes.item (fp.location.row).out+","+fp.location.column.out+"]%N")
						else
							model.m.projectile_move_str.append ("    A friendly projectile(id:"+(i-1).out+") moves: ["+model.m.row_indexes.item (fp.location.row+1).out+","+(fp.location.column-1).out+"] -> out of board%N")
				 			model.m.friendly_projectile_list.remove (fp.id)
						end
					else
						model.m.friendly_projectile_list.remove (fp.id)
					end

				end

			model.m.projectile_move_str.append (model.m.fp_act_collision_str)
				if attached model.m.friendly_projectile_list.item (i.item -2 ) as fp then
					model.m.board.put ("_",fp.location.row , fp.location.column)

					check_id := model.m.collision.check_for_collision ([fp.location.row+1,fp.location.column+1], (i.item -2 ), 0)

					if fp.is_destroyed = false then
						if fp.location.column+1 <= model.m.board.width  and fp.location.row+1 <= model.m.board.height and fp.location.row +1 > 0 and fp.location.column+1 >= 1 then
							fp.location.column := fp.location.column + 1
							fp.location.row := fp.location.row+1
							model.m.board.put ("*",fp.location.row , fp.location.column)
							model.m.projectile_move_str.append ("    A friendly projectile(id:"+(i-2).out+") moves: ["+model.m.row_indexes.item (fp.location.row-1).out+","+(fp.location.column -1).out+"] -> ["+model.m.row_indexes.item (fp.location.row).out+","+fp.location.column.out+"]%N")
						else
							model.m.projectile_move_str.append ("    A friendly projectile(id:"+(i-2).out+") moves: ["+model.m.row_indexes.item (fp.location.row-1).out+","+(fp.location.column-1).out+"] -> out of board%N")
				 			model.m.friendly_projectile_list.remove (fp.id)
						end
					else
						model.m.friendly_projectile_list.remove (fp.id)
					end

				end
				model.m.projectile_move_str.append (model.m.fp_act_collision_str)
				i := i - 3
			end
		end
	update_snipe
	local
		check_id:INTEGER
		do
			from i := -1
			until
				i <= model.m.projectile_id
			loop
				if attached model.m.friendly_projectile_list.item (i.item) as fp then
					model.m.board.put ("_",fp.location.row , fp.location.column)

					-- Check for collision
				    check_id := model.m.collision.check_for_collision ([fp.location.row,fp.location.column+8], (i.item -2 ), 0)

					if fp.is_destroyed = false then
						if fp.location.column+8 <= model.m.board.width then
							fp.location.column := fp.location.column + 8
							fp.location.row := fp.location.row
							model.m.board.put ("*",fp.location.row , fp.location.column)
							model.m.projectile_move_str.append ("    A friendly projectile(id:"+(fp.id).out+") moves: ["+model.m.row_indexes.item (fp.location.row).out+","+(fp.location.column -8).out+"] -> ["+model.m.row_indexes.item (fp.location.row).out+","+fp.location.column.out+"]%N")
						else
							model.m.projectile_move_str.append ("    A friendly projectile(id:"+(fp.id).out+") moves: ["+model.m.row_indexes.item (fp.location.row).out+","+(fp.location.column-8).out+"] -> out of board%N")
				 			model.m.friendly_projectile_list.remove (fp.id)
						end
					else
						model.m.friendly_projectile_list.remove (fp.id)
					end
				end
				i := i - 1
			end
		end
	update_rocket

		do
			from i := -1
				until
					i <= model.m.projectile_id
				loop
					if attached model.m.friendly_projectile_list.item (i.item) as fp then
						model.m.board.put ("_",fp.location.row , fp.location.column)
						fp.location.column := fp.location.column + fp.move_update
						-- Check for collision
					    if fp.location.column < model.m.board.width  then
					    	model.m.projectile_move_str.append ("    A friendly projectile(id:"+i.out+") moves: ["+model.m.row_indexes.item (fp.location.row).out+","+(fp.location.column-fp.move_update).out+"] -> ["+model.m.row_indexes.item (fp.location.row).out+","+fp.location.column.out+"]%N")

							model.m.board.put ("*",fp.location.row , fp.location.column)
				 		else
				 			model.m.projectile_move_str.append ("    A friendly projectile(id:"+i.out+") moves: ["+model.m.row_indexes.item (fp.location.row).out+","+(fp.location.column-fp.move_update).out+"] -> out of board%N")

				 			model.m.friendly_projectile_list.remove (fp.id)
				 		end
				 		fp.move_update := (2* fp.move_update)
					end
					i := i - 1
			end
		end
	update_splitter
	local
		check_id:INTEGER
		do
				from i := -1
					until
						i <= model.m.projectile_id
					loop
						if attached model.m.friendly_projectile_list.item (i.item) as fp then
						   check_id := model.m.collision.check_for_collision ([fp.location.row,fp.location.column], (i.item), 0)

							if fp.is_destroyed = false then
								model.m.projectile_move_str.append ("    A friendly projectile(id:"+(fp.id).out+") stays at: ["+model.m.row_indexes.item (fp.location.row).out+","+(fp.location.column).out+"] %N")
							else
								model.m.board.put ("_",fp.location.row , fp.location.column)
								model.m.friendly_projectile_list.remove (fp.id)
							end

						end
						i := i - 1
				end
			end

end
