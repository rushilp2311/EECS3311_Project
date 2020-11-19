note
	description: "Summary description for {WEAPON_SETUP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEAPON_SETUP
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
			ship := model.ship_array[1]
			inspect choice

					when 2 then
						ship.health := 10
						ship.energy := 60
						ship.h_regen := 0
						ship.e_regen := 2
						ship.armour := 1
						ship.vision := 0
						ship.move := 0
						ship.move_cost := 2
						ship.projectile_damage := 50
						ship.projectile_cost := 10
						model.ship.choice_selected[1].pos := 2
						model.ship.choice_selected[1].name := "Spread"
					when 3 then
						ship.health := 0
						ship.energy := 100
						ship.h_regen := 0
						ship.e_regen := 5
						ship.armour := 0
						ship.vision := 10
						ship.move := 3
						ship.move_cost := 0
						ship.projectile_damage := 1000
						ship.projectile_cost := 20
						model.ship.choice_selected[1].pos := 3
						model.ship.choice_selected[1].name := "Snipe"
					when 4 then
						ship.health := 10
						ship.energy := 0
						ship.h_regen := 10
						ship.e_regen := 0
						ship.armour := 2
						ship.vision := 2
						ship.move := 0
						ship.move_cost := 3
						ship.projectile_damage := 100
						ship.projectile_cost := 10
						model.ship.choice_selected[1].pos := 4
						model.ship.choice_selected[1].name := "Rocket"
					when 5 then
						ship.health := 0
						ship.energy := 100
						ship.h_regen := 0
						ship.e_regen := 10
						ship.armour := 0
						ship.vision := 0
						ship.move := 0
						ship.move_cost := 5
						ship.projectile_damage := 150
						ship.projectile_cost := 70
						model.ship.choice_selected[1].pos := 5
						model.ship.choice_selected[1].name := "Splitter"
					else
						ship.health := 0
						ship.energy := 10
						ship.h_regen := 0
						ship.e_regen := 1
						ship.armour := 0
						ship.vision := 1
						ship.move := 1
						ship.move_cost := 1
						ship.projectile_damage := 70
						ship.projectile_cost := 5
						model.ship.choice_selected[1].pos := 1
						model.ship.choice_selected[1].name := "Standard"
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

			Result.append ("  1:Standard (A single projectile is fired in front)%N")
			Result.append ("    Health:10, Energy:10, Regen:0/1, Armour:0, Vision:1, Move:1, Move Cost:1,%N")
			Result.append ("    Projectile Damage:70, Projectile Cost:5 (energy)%N")
			Result.append ("  2:Spread (Three projectiles are fired in front, two going diagonal)%N")
			Result.append ("    Health:0, Energy:60, Regen:0/2, Armour:1, Vision:0, Move:0, Move Cost:2,%N")
			Result.append ("    Projectile Damage:50, Projectile Cost:10 (energy)%N")
			Result.append ("  3:Snipe (Fast and high damage projectile, but only travels via teleporting)%N")
			Result.append ("    Health:0, Energy:100, Regen:0/5, Armour:0, Vision:10, Move:3, Move Cost:0,%N")
			Result.append ("    Projectile Damage:1000, Projectile Cost:20 (energy)%N")
			Result.append ("  4:Rocket (Two projectiles appear behind to the sides of the Starfighter and accelerates)%N")
			Result.append ("    Health:10, Energy:0, Regen:10/0, Armour:2, Vision:2, Move:0, Move Cost:3,%N")
			Result.append ("    Projectile Damage:100, Projectile Cost:10 (health)%N")
			Result.append ("  5:Splitter (A single mine projectile is placed in front of the Starfighter)%N")
			Result.append ("    Health:0, Energy:100, Regen:0/10, Armour:0, Vision:0, Move:0, Move Cost:5,%N")
			Result.append ("    Projectile Damage:150, Projectile Cost:70 (energy)%N")
			Result.append ("  Weapon Selected:"+model.ship.choice_selected[1].name)








		end

end
