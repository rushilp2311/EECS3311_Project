note
	description: "Summary description for {FIRE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FIRE

create
	make
feature
	model : ETF_MODEL_ACCESS
	make
		do

		end
feature
	fire
	local
		choice:INTEGER
		do
			choice := model.m.ship.choice_selected[1].pos
			inspect
				choice
			when 1 then
				fire_standard
			when 2 then
				fire_spread
			when 3 then
				fire_snipe
			when 4 then
				fire_rocket
			when 5 then
				fire_splitter
			else

			end

		end


--TODO CHECK FOR COLLISION
--TODO CHECK FOR PROJECTILE SPWAN OUT OF BOARD INSIDE MODEL FIRE


	fire_standard
	local
		check_id:INTEGER
		do

				model.m.friendly_projectile_list.extend (create{FRIENDLY_PROJECTILE}.make(model.m.projectile_id,model.m.ship.projectile_damage,5,[model.m.ship.location.row, model.m.ship.location.column+1]), model.m.projectile_id)
				if attached model.m.friendly_projectile_list.item (model.m.projectile_id) as fp then
					fp.id := model.m.projectile_id


					check_id := model.m.collision.check_for_collision ([model.m.ship.location.row, model.m.ship.location.column+1], fp.id, 0)

					if fp.is_destroyed = false then
						fp.location := [model.m.ship.location.row, model.m.ship.location.column+1]
						model.m.board.put ("*",fp.location.row, fp.location.column)
						model.m.sf_act_display_str.prepend (model.m.sf_act_display.display_act (2))
						model.m.decrement_projectile_id
						model.m.calculate_fire_cost
					else
						model.m.friendly_projectile_list.remove (fp.id)
					end

				end
		end
	fire_spread
	local
		check_id:INTEGER
		do

				model.m.friendly_projectile_list.extend (create{FRIENDLY_PROJECTILE}.make(model.m.projectile_id,model.m.ship.projectile_damage,1,[model.m.ship.location.row, model.m.ship.location.column+1]), model.m.projectile_id)
				model.m.sf_act_display_str.append ("The Starfighter(id:0) fires at location ["+model.m.row_indexes.item (model.m.ship.location.row).out+","+model.m.ship.location.column.out+"].%N")
				if attached model.m.friendly_projectile_list.item (model.m.projectile_id) as fp then
					fp.id := model.m.projectile_id
					check_id := model.m.collision.check_for_collision ([model.m.ship.location.row, model.m.ship.location.column+1], fp.id, 0)
					if fp.is_destroyed = false then
						fp.location := [model.m.ship.location.row, model.m.ship.location.column+1]
						model.m.board.put ("*",fp.location.row, fp.location.column)

						if fp.location.row >= 1 and fp.location.row <= model.m.board.height and fp.location.column >= 1 and fp.location.column <= model.m.board.width then
							model.m.sf_act_display_str.append ("      A friendly projectile(id:"+model.m.projectile_id.out+") spawns at location ["+model.m.row_indexes.item (model.m.ship.location.row).out+","+(model.m.ship.location.column+1).out+"].%N")
						else
							model.m.sf_act_display_str.append ("      A friendly projectile(id:"+model.m.projectile_id.out+") spawns at location out of board.%N")
							model.m.friendly_projectile_list.remove (fp.id)
						end


					else
						model.m.sf_act_display_str.append ("      A friendly projectile(id:"+model.m.projectile_id.out+") spawns at location out of board.%N")
						model.m.friendly_projectile_list.remove (fp.id)
					end
				end
				model.m.decrement_projectile_id
				model.m.friendly_projectile_list.extend (create{FRIENDLY_PROJECTILE}.make(model.m.projectile_id,model.m.ship.projectile_damage,1,[model.m.ship.location.row-1, model.m.ship.location.column+1]), model.m.projectile_id)
				if attached model.m.friendly_projectile_list.item (model.m.projectile_id) as fp then
					fp.id := model.m.projectile_id
					check_id := model.m.collision.check_for_collision ([model.m.ship.location.row-1, model.m.ship.location.column+1], fp.id, 0)
					if fp.is_destroyed = false then
						fp.location := [model.m.ship.location.row-1, model.m.ship.location.column+1]
						model.m.board.put ("*",fp.location.row, fp.location.column)
						if fp.location.row >= 1 and fp.location.row <= model.m.board.height and fp.location.column >= 1 and fp.location.column <= model.m.board.width then
							model.m.sf_act_display_str.append ("      A friendly projectile(id:"+model.m.projectile_id.out+") spawns at location ["+model.m.row_indexes.item (model.m.ship.location.row-1).out+","+(model.m.ship.location.column+1).out+"].%N")
						else
							model.m.sf_act_display_str.append ("      A friendly projectile(id:"+model.m.projectile_id.out+") spawns at location out of board.%N")
							model.m.friendly_projectile_list.remove (fp.id)
						end



					else

						model.m.friendly_projectile_list.remove (fp.id)
					end
				end
				model.m.decrement_projectile_id
				model.m.friendly_projectile_list.extend (create{FRIENDLY_PROJECTILE}.make(model.m.projectile_id,model.m.ship.projectile_damage,1,[model.m.ship.location.row+1, model.m.ship.location.column+1]), model.m.projectile_id)
				if attached model.m.friendly_projectile_list.item (model.m.projectile_id) as fp then
					fp.id := model.m.projectile_id
					check_id := model.m.collision.check_for_collision ([model.m.ship.location.row+1, model.m.ship.location.column+1], fp.id, 0)
					if fp.is_destroyed = false then
						fp.location := [model.m.ship.location.row+1, model.m.ship.location.column+1]
						model.m.board.put ("*",fp.location.row, fp.location.column)
						if fp.location.row >= 1 and fp.location.row <= model.m.board.height and fp.location.column >= 1 and fp.location.column <= model.m.board.width then
							model.m.sf_act_display_str.append ("      A friendly projectile(id:"+model.m.projectile_id.out+") spawns at location ["+model.m.row_indexes.item (model.m.ship.location.row+1).out+","+(model.m.ship.location.column+1).out+"].%N")
						else
							model.m.sf_act_display_str.append ("      A friendly projectile(id:"+model.m.projectile_id.out+") spawns at location out of board.%N")
							model.m.friendly_projectile_list.remove (fp.id)
						end

					else

						model.m.friendly_projectile_list.remove (fp.id)
					end
				end
				model.m.decrement_projectile_id
				model.m.calculate_fire_cost
		end
	fire_snipe
	local
		check_id:INTEGER
		do
			model.m.friendly_projectile_list.extend (create{FRIENDLY_PROJECTILE}.make(model.m.projectile_id,model.m.ship.projectile_damage,8,[model.m.ship.location.row, model.m.ship.location.column+1]), model.m.projectile_id)
				if attached model.m.friendly_projectile_list.item (model.m.projectile_id) as fp then
					fp.id := model.m.projectile_id
					check_id := model.m.collision.check_for_collision ([model.m.ship.location.row, model.m.ship.location.column+1], fp.id, 0)
					if fp.is_destroyed = false then
						fp.location := [model.m.ship.location.row, model.m.ship.location.column+1]
						model.m.board.put ("*",fp.location.row, fp.location.column)
						model.m.sf_act_display_str.prepend (model.m.sf_act_display.display_act (2))
						model.m.decrement_projectile_id
						model.m.calculate_fire_cost
					else
						model.m.friendly_projectile_list.remove (fp.id)
					end
				end
		end
	fire_rocket
	local
		check_id:INTEGER
		do
			model.m.sf_act_display_str.append ("The Starfighter(id:0) fires at location ["+model.m.row_indexes.item (model.m.ship.location.row).out+","+model.m.ship.location.column.out+"].%N")
			if (((model.m.ship.location.row - 1) <= model.m.board.height) and ((model.m.ship.location.row - 1) >= 1)) and (((model.m.ship.location.column - 1) <= model.m.board.width) and ((model.m.ship.location.column - 1) >= 1)) then
				model.m.friendly_projectile_list.extend (create{FRIENDLY_PROJECTILE}.make(model.m.projectile_id,model.m.ship.projectile_damage,1,[model.m.ship.location.row-1, model.m.ship.location.column-1]), model.m.projectile_id)
				if attached model.m.friendly_projectile_list.item (model.m.projectile_id) as fp then
					fp.id := model.m.projectile_id
					check_id := model.m.collision.check_for_collision ([model.m.ship.location.row-1, model.m.ship.location.column-1], fp.id, 0)
					if fp.is_destroyed = false then
						fp.location := [model.m.ship.location.row-1, model.m.ship.location.column-1]
						model.m.board.put ("*",fp.location.row, fp.location.column)
						if fp.location.row >= 1 and fp.location.row <= model.m.board.height and fp.location.column >= 1 and fp.location.column <= model.m.board.width then
							model.m.sf_act_display_str.append ("      A friendly projectile(id:"+model.m.projectile_id.out+") spawns at location ["+model.m.row_indexes.item (model.m.ship.location.row-1).out+","+(model.m.ship.location.column-1).out+"].%N")

						else
							model.m.sf_act_display_str.append ("      A friendly projectile(id:"+model.m.projectile_id.out+") spawns at location out of board.%N")
							model.m.friendly_projectile_list.remove (fp.id)
						end


					else
						model.m.sf_act_display_str.append ("      A friendly projectile(id:"+model.m.projectile_id.out+") spawns at location out of board.%N")
						model.m.friendly_projectile_list.remove (fp.id)
					end
				end

			else
				model.m.sf_act_display_str.append ("      A friendly projectile(id:"+model.m.projectile_id.out+") spawns at location out of board.%N")
			end
			model.m.decrement_projectile_id
			

			if (((model.m.ship.location.row + 1) <= model.m.board.height) and ((model.m.ship.location.row + 1) >= 1)) and (((model.m.ship.location.column - 1) <= model.m.board.width) and ((model.m.ship.location.column - 1) >= 1)) then
				model.m.friendly_projectile_list.extend (create{FRIENDLY_PROJECTILE}.make(model.m.projectile_id,model.m.ship.projectile_damage,1,[model.m.ship.location.row-1, model.m.ship.location.column-1]), model.m.projectile_id)
				if attached model.m.friendly_projectile_list.item (model.m.projectile_id) as fp then
					fp.id := model.m.projectile_id
					check_id := model.m.collision.check_for_collision ([model.m.ship.location.row+1, model.m.ship.location.column-1], fp.id, 0)
					if fp.is_destroyed = false then
						fp.location := [model.m.ship.location.row+1, model.m.ship.location.column-1]
						model.m.board.put ("*",fp.location.row, fp.location.column)
						if fp.location.row >= 1 and fp.location.row <= model.m.board.height and fp.location.column >= 1 and fp.location.column <= model.m.board.width then
							model.m.sf_act_display_str.append ("      A friendly projectile(id:"+model.m.projectile_id.out+") spawns at location ["+model.m.row_indexes.item (model.m.ship.location.row+1).out+","+(model.m.ship.location.column-1).out+"].%N")

						else
							model.m.sf_act_display_str.append ("      A friendly projectile(id:"+model.m.projectile_id.out+") spawns at location out of board.%N")
							model.m.friendly_projectile_list.remove (fp.id)
						end
					else
						model.m.sf_act_display_str.append ("      A friendly projectile(id:"+model.m.projectile_id.out+") spawns at location out of board.%N")
						model.m.friendly_projectile_list.remove (fp.id)
					end
				end

			else
				model.m.sf_act_display_str.append ("      A friendly projectile(id:"+model.m.projectile_id.out+") spawns at location out of board.%N")
			end
			model.m.decrement_projectile_id

			model.m.calculate_fire_cost
		end
	fire_splitter
		do
			fire_standard
		end

end
