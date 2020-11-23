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


	fire_standard
		do

				model.m.friendly_projectile_list.extend (create{FRIENDLY_PROJECTILE}.make, model.m.projectile_id)
				if attached model.m.friendly_projectile_list.item (model.m.projectile_id) as fp then
					fp.id := model.m.projectile_id
					fp.location := [model.m.ship.location.row, model.m.ship.location.column+1]
					model.m.board.put ("*",fp.location.row, fp.location.column)
				end
				model.m.decrement_projectile_id


		end
	fire_spread
		do

				model.m.friendly_projectile_list.extend (create{FRIENDLY_PROJECTILE}.make, model.m.projectile_id)
				if attached model.m.friendly_projectile_list.item (model.m.projectile_id) as fp then
					fp.id := model.m.projectile_id
					fp.location := [model.m.ship.location.row, model.m.ship.location.column+1]
					model.m.board.put ("*",fp.location.row, fp.location.column)
				end
				model.m.decrement_projectile_id

				model.m.friendly_projectile_list.extend (create{FRIENDLY_PROJECTILE}.make, model.m.projectile_id)
				if attached model.m.friendly_projectile_list.item (model.m.projectile_id) as fp then
					fp.id := model.m.projectile_id
					fp.location := [model.m.ship.location.row-1, model.m.ship.location.column+1]
					model.m.board.put ("*",fp.location.row, fp.location.column)
				end
				model.m.decrement_projectile_id

				model.m.friendly_projectile_list.extend (create{FRIENDLY_PROJECTILE}.make, model.m.projectile_id)
				if attached model.m.friendly_projectile_list.item (model.m.projectile_id) as fp then
					fp.id := model.m.projectile_id
					fp.location := [model.m.ship.location.row+1, model.m.ship.location.column+1]
					model.m.board.put ("*",fp.location.row, fp.location.column)
				end
				model.m.decrement_projectile_id

		end
	fire_snipe
		do

			fire_standard

		end
	fire_rocket
		do

			model.m.friendly_projectile_list.extend (create{FRIENDLY_PROJECTILE}.make, model.m.projectile_id)
			if attached model.m.friendly_projectile_list.item (model.m.projectile_id) as fp then
				fp.id := model.m.projectile_id
				fp.location := [model.m.ship.location.row-1, model.m.ship.location.column-1]
				model.m.board.put ("*",fp.location.row, fp.location.column)
			end
			model.m.decrement_projectile_id

			model.m.friendly_projectile_list.extend (create{FRIENDLY_PROJECTILE}.make, model.m.projectile_id)
			if attached model.m.friendly_projectile_list.item (model.m.projectile_id) as fp then
				fp.id := model.m.projectile_id
				fp.location := [model.m.ship.location.row+1, model.m.ship.location.column-1]
				model.m.board.put ("*",fp.location.row, fp.location.column)
			end
			model.m.decrement_projectile_id

		end
	fire_splitter
		do
			fire_standard

--			model.m.friendly_projectile_list.extend ([model.m.ship.location.row,model.m.ship.location.column+1], model.m.projectile_id)
--			model.m.board.put ("*", model.m.ship.location.row, model.m.ship.location.column+1)
--			model.m.decrement_projectile_id

		end

end
