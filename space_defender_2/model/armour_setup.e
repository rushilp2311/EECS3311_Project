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
		do

		end
	check_range(range:INTEGER)
		do

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
