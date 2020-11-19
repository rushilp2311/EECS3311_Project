note
	description: "Summary description for {ARMOUR_SETUP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARMOUR_SETUP
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
			ship := model.ship_array[2]
			inspect choice

			when 2 then
				ship.health := 75
				ship.energy := 0
				ship.h_regen := 2
				ship.e_regen := 0
				ship.armour := 3
				ship.vision := 0
				ship.move := 0
				ship.move_cost := 1
				model.ship.choice_selected[2].pos := 2
				model.ship.choice_selected[2].name := "Light"
			when 3 then
				ship.health := 100
				ship.energy := 0
				ship.h_regen := 13
				ship.e_regen := 0
				ship.armour := 5
				ship.vision := 0
				ship.move := 0
				ship.move_cost := 3
				model.ship.choice_selected[2].pos := 3
				model.ship.choice_selected[2].name := "Medium"
			when 4 then
				ship.health := 200
				ship.energy := 0
				ship.h_regen := 4
				ship.e_regen := 0
				ship.armour := 10
				ship.vision := 0
				ship.move := -1
				ship.move_cost := 5
				model.ship.choice_selected[2].pos := 4
				model.ship.choice_selected[2].name := "Heavy"
			else
				ship.health := 50
				ship.energy := 0
				ship.h_regen := 1
				ship.e_regen := 0
				ship.armour := 0
				ship.vision := 0
				ship.move := 1
				ship.move_cost := 0
				model.ship.choice_selected[2].pos := 1
				model.ship.choice_selected[2].name := "None"
			end

		end
	in_range(range:INTEGER):BOOLEAN
		do
			if range < 1 or range > 4 then
				Result := false
			else
				Result := true
			end
		end
	output:STRING
		do
			create Result.make_empty

			Result.append ("  1:None%N")
			Result.append ("    Health:50, Energy:0, Regen:1/0, Armour:0, Vision:0, Move:1, Move Cost:0%N")
			Result.append ("  2:Light%N")
			Result.append ("    Health:75, Energy:0, Regen:2/0, Armour:3, Vision:0, Move:0, Move Cost:1%N")
			Result.append ("  3:Medium%N")
			Result.append ("    Health:100, Energy:0, Regen:3/0, Armour:5, Vision:0, Move:0, Move Cost:3%N")
			Result.append ("  4:Heavy%N")
			Result.append ("    Health:200, Energy:0, Regen:4/0, Armour:10, Vision:0, Move:-1, Move Cost:5%N")
			Result.append ("  Armour Selected:"+model.ship.choice_selected[model.cursor].name)
		end

end
