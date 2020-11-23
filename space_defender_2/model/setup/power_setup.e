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
			inspect choice

					when 2 then
						model.ship.choice_selected[model.cursor].pos := 2
						model.ship.choice_selected[model.cursor].name := "Repair (50 energy): Gain 50 health, can go over max health. Health regen will not be in effect if over cap."
					when 3 then
						model.ship.choice_selected[model.cursor].pos := 3
						model.ship.choice_selected[model.cursor].name := "Overcharge (up to 50 health): Gain 2*health spent energy, can go over max energy. Energy regen will not be in effect if over cap."
					when 4 then
						model.ship.choice_selected[model.cursor].pos := 4
						model.ship.choice_selected[model.cursor].name := "Deploy Drones (100 energy): Clear all projectiles."
					when 5 then
						model.ship.choice_selected[model.cursor].pos := 5
						model.ship.choice_selected[model.cursor].name := "Orbital Strike (100 energy): Deal 100 damage to all enemies, affected by armour."
					else
						model.ship.choice_selected[model.cursor].pos := 1
						model.ship.choice_selected[model.cursor].name := "Recall (50 energy): Teleport back to spawn."
					end

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
			Result.append ("  1:Recall (50 energy): Teleport back to spawn.%N")
			Result.append ("  2:Repair (50 energy): Gain 50 health, can go over max health. Health regen will not be in effect if over cap.%N")
			Result.append ("  3:Overcharge (up to 50 health): Gain 2*health spent energy, can go over max energy. Energy regen will not be in effect if over cap.%N")
			Result.append ("  4:Deploy Drones (100 energy): Clear all projectiles.%N")
			Result.append ("  5:Orbital Strike (100 energy): Deal 100 damage to all enemies, affected by armour.%N")
			Result.append ("  Power Selected:"+model.ship.choice_selected[model.cursor].name)
		end
end
