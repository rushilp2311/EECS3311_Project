note
	description: "Summary description for {STARFIGHTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STARFIGHTER
create
	make
feature
	make
		do
			health := 0
			energy := 0
			h_regen := 0
			e_regen := 0
			armour := 0
			vision := 0
			move := 0
			move_cost := 0
			projectile_damage := 0
			projectile_cost := 0
			create choice_selected.make_empty
			choice_selected.force ([1,"Starfighter"], choice_selected.count+1)
			choice_selected.force ([1,"None"], choice_selected.count+1)
			choice_selected.force ([1,"Starfighter"], choice_selected.count+1)
			choice_selected.force ([1,"1:Recall (50 energy): Teleport back to spawn."], choice_selected.count+1)
		end

feature --attributes

	health:INTEGER assign set_health
	energy:INTEGER assign set_energy
	h_regen:INTEGER assign set_h_regen
	e_regen:INTEGER assign set_e_regen
	armour:INTEGER assign set_armour
	vision:INTEGER assign set_vision
	move:INTEGER assign set_move
	move_cost:INTEGER assign set_move_cost
	projectile_damage:INTEGER assign set_projectile_damage
	projectile_cost:INTEGER assign set_projectile_cost
	choice_selected : ARRAY[TUPLE[pos:INTEGER;name:STRING]]

feature
	add_choice_selected(t:TUPLE[pos:INTEGER;name:STRING])
		do
			choice_selected.force (t,choice_selected.count + 1)
		end
	set_health(h : INTEGER)
		do
			health := h
		end
	set_energy(e : INTEGER)
		do
			energy := e
		end
	set_armour(a : INTEGER)
		do
			armour := a
		end

	set_h_regen(hr : INTEGER)
		do
			h_regen := hr
		end
	set_e_regen(er : INTEGER)
		do
			health := er
		end
	set_vision(v : INTEGER)
		do
			vision := v
		end
	set_move(m : INTEGER)
		do
			move := m
		end

	set_move_cost(mc : INTEGER)
		do
			move_cost := mc
		end
	set_projectile_damage(pg : INTEGER)
		do
			projectile_damage := pg
		end
	set_projectile_cost(pc : INTEGER)
		do
			projectile_cost := pc
		end


end
