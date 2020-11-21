note
	description: "Summary description for {SETUP_SUMMARY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SETUP_SUMMARY
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
	in_range(range:INTEGER):BOOLEAN
		do
			if range < 1 or range > 5 then
				Result := false
			else
				Result := true
			end
		end
	output:STRING
		do
			create Result.make_empty
			Result.append ("  Weapon Selected:"+model.ship.choice_selected[1].name+"%N")
			Result.append ("  Armour Selected:"+model.ship.choice_selected[2].name+"%N")
			Result.append ("  Engine Selected:"+model.ship.choice_selected[3].name+"%N")
			Result.append ("  Power Selected:"+model.ship.choice_selected[4].name)
		end
end
