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
		do

		end
	check_range(range:INTEGER)
		do

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
