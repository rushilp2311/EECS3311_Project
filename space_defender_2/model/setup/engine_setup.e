note
	description: "Summary description for {ENGINE_SETUP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENGINE_SETUP
inherit
	SETUP
create
	make
feature
	model :ETF_MODEL

feature
	make
		do
			model := model_access.m
		end
feature
	select_choice(choice:INTEGER)
		local
		ship : STARFIGHTER
		do
			ship := model.ship_array[3]
			inspect choice

					when 2 then
						ship.total_health := 0
				ship.total_energy := 30
				ship.h_regen := 0
				ship.e_regen := 1
				ship.armour := 0
				ship.vision := 15
				ship.move := 10
				ship.move_cost := 1
						model.ship.choice_selected[3].pos := 2
						model.ship.choice_selected[3].name := "Light"
					when 3 then
						ship.total_health := 50
				ship.total_energy := 100
				ship.h_regen := 0
				ship.e_regen := 3
				ship.armour := 3
				ship.vision := 6
				ship.move := 4
				ship.move_cost := 5
						model.ship.choice_selected[3].pos := 3
						model.ship.choice_selected[3].name := "Armoured"

					else
						ship.total_health := 10
				ship.total_energy := 60
				ship.h_regen := 0
				ship.e_regen := 2
				ship.armour := 1
				ship.vision := 12
				ship.move := 8
				ship.move_cost := 2
						model.ship.choice_selected[3].pos := 1
						model.ship.choice_selected[3].name := "Standard"
					end

		end
	in_range(range:INTEGER):BOOLEAN
		do
			if range < 1 or range > 3 then
				Result := false
			else
				Result := true
			end
		end
	output:STRING
		do
			create Result.make_empty

			Result.append ("  1:Standard%N")
			Result.append ("    Health:10, Energy:60, Regen:0/2, Armour:1, Vision:12, Move:8, Move Cost:2%N")
			Result.append ("  2:Light%N")
			Result.append ("    Health:0, Energy:30, Regen:0/1, Armour:0, Vision:15, Move:10, Move Cost:1%N")
			Result.append ("  3:Armoured%N")
			Result.append ("    Health:50, Energy:100, Regen:0/3, Armour:3, Vision:6, Move:4, Move Cost:5%N")
			Result.append ("  Engine Selected:"+model.ship.choice_selected[model.cursor].name)
		end



end
