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
		do
			inspect choice
			when 1 then
				
					model.ship.choice_selected[1].pos := 1
					model.ship.choice_selected[1].name := "Starfighter"
			when 2 then
				model.ship.health := model.ship.health + 0
				model.ship.choice_selected[1].pos := 2
				model.ship.choice_selected[1].name := "Spread"
			else

			end
		end
	check_range(range:INTEGER)
		do

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
