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
--			when 5 then
--				update_splitter
			else

			end
		end
	update_standard
	local
		j : INTEGER
		old_location:TUPLE[row:INTEGER;column:INTEGER]
		do

			from i := -1
				until
					i <= model.m.projectile_id
				loop
					if attached model.m.friendly_projectile_list.item (i.item) as fp then
						model.m.board.put ("_",fp.location.row , fp.location.column)
						old_location := fp.location
				    -- TODO move one step at a time
					from j := 1
					until
						j >=6
					loop
						fp.location.column := fp.location.column + 1
						--Check for collision
						j := j + 1
					end
				 if fp.location.column <= model.m.board.width  then
				 	model.m.projectile_move_str.append ("    A friendly projectile(id:"+i.out+") moves: ["+model.m.row_indexes.item (fp.location.row).out+","+(fp.location.column-5).out+"] -> ["+model.m.row_indexes.item (fp.location.row).out+","+fp.location.column.out+"]%N")
					model.m.board.put ("*",fp.location.row , fp.location.column)
				 else
				 	model.m.projectile_move_str.append ("    A friendly projectile(id:"+i.out+") moves: ["+model.m.row_indexes.item (fp.location.row).out+","+(fp.location.column-5).out+"] -> out of board%N")
				 	model.m.friendly_projectile_list.remove (fp.id)
				 end
					end

					i := i - 1

			end

		end
	update_spread
		do
		from i := -1
					until
						i <= model.m.projectile_id
					loop
							if attached model.m.friendly_projectile_list.item (i.item) as fp then
							model.m.board.put ("_",fp.location.row , fp.location.column)

							fp.location := [fp.location.row , fp.location.column + 1]

							-- Check for collision
							if fp.location.column <= model.m.board.width and fp.location.row-1 > 0 then
								model.m.board.put ("*",fp.location.row , fp.location.column)
					 		else

					 			model.m.friendly_projectile_list.remove (fp.id)
					 		end
						end
						if attached model.m.friendly_projectile_list.item (i.item - 1) as fp then
							model.m.board.put ("_",fp.location.row , fp.location.column)


							fp.location := [fp.location.row -1 , fp.location.column + 1]

							-- Check for collision
							if fp.location.column <= model.m.board.width and fp.location.row > 0  then
								model.m.board.put ("*",fp.location.row , fp.location.column)
					 		else

					 			model.m.friendly_projectile_list.remove (fp.id)
					 		end
						end
						if attached model.m.friendly_projectile_list.item (i.item - 2) as fp then
							model.m.board.put ("_",fp.location.row , fp.location.column)

							fp.location := [fp.location.row +1 , fp.location.column + 1]
							-- Check for collision
							if fp.location.column <= model.m.board.width  and fp.location.row-1 < model.m.board.height then
								model.m.board.put ("*",fp.location.row , fp.location.column)
					 		else

					 			model.m.friendly_projectile_list.remove (fp.id)
					 		end
						end

						i := i - 3

				end
		end
	update_snipe
		do
			from i := -1
				until
					i <= model.m.projectile_id
				loop
					if attached model.m.friendly_projectile_list.item (i.item) as fp then
						model.m.board.put ("_",fp.location.row , fp.location.column)

						fp.location.column := fp.location.column + 8
						-- Check for collision
					    if fp.location.column < model.m.board.width  then
							model.m.board.put ("*",fp.location.row , fp.location.column)
				 		else
				 			model.m.friendly_projectile_list.remove (fp.id)
				 		end
					end

					i := i - 1

			end
		end
	update_rocket
	local
		u : REAL_64
		do

			from i := -1
				until
					i <= model.m.projectile_id
				loop
					if attached model.m.friendly_projectile_list.item (i.item) as fp then
						u := (2 ^ fp.move_update)
						model.m.board.put ("_",fp.location.row , fp.location.column)

						fp.location.column := fp.location.column + u.ceiling
						fp.move_update := fp.move_update+1
						-- Check for collision
					    if fp.location.column < model.m.board.width  then
							model.m.board.put ("*",fp.location.row , fp.location.column)
				 		else
				 			model.m.friendly_projectile_list.remove (fp.id)
				 		end
					end

					i := i - 1

			end
		end
--	update_splitter
--		do
--			from i := model.m.enemy_id
--			until
--				i <= -1
--			loop

--				i := i + 1
--			end
--		end

end
