note
	description: "Summary description for {POWER_SETUP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POWER_SETUP
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
			Result.append ("  1:Recall (50 energy): Teleport back to spawn.%N")
			Result.append ("  2:Repair (50 energy): Gain 50 health, can go over max health. Health regen will not be in effect if over cap.%N")
			Result.append ("  3:Overcharge (up to 50 health): Gain 2*health spent energy, can go over max energy. Energy regen will not be in effect if over cap.%N")
			Result.append ("  4:Deploy Drones (100 energy): Clear all projectiles.1%N")
			Result.append ("  5:Orbital Strike (100 energy): Deal 100 damage to all enemies, affected by armour.%N")
			Result.append ("  Power Selected:"+model.ship.choice_selected[model.cursor].name)
		end
end
