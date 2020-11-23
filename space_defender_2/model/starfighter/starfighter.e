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
			current_health := 0
			total_health := 0
			current_energy := 0
			total_energy := 0
			h_regen := 0
			e_regen := 0
			armour := 0
			vision := 0
			move := 0
			move_cost := 0
			projectile_damage := 0
			projectile_cost := 0

			create location.default_create
			create old_location.default_create
			create choice_selected.make_empty
			choice_selected.force ([1,"Standard"], choice_selected.count+1)
			choice_selected.force ([1,"None"], choice_selected.count+1)
			choice_selected.force ([1,"Standard"], choice_selected.count+1)
			choice_selected.force ([1,"1:Recall (50 energy): Teleport back to spawn."], choice_selected.count+1)
		end

feature --attributes

	current_health:INTEGER assign set_current_health
	total_health:INTEGER assign set_total_health
	current_energy:INTEGER assign set_current_energy
	total_energy:INTEGER assign set_total_energy
	h_regen:INTEGER assign set_h_regen
	e_regen:INTEGER assign set_e_regen
	armour:INTEGER assign set_armour
	vision:INTEGER assign set_vision
	move:INTEGER assign set_move
	move_cost:INTEGER assign set_move_cost
	projectile_damage:INTEGER assign set_projectile_damage
	projectile_cost:INTEGER assign set_projectile_cost
	choice_selected : ARRAY[TUPLE[pos:INTEGER;name:STRING]]
	location : TUPLE[row:INTEGER_32;column:INTEGER_32] assign set_location
	old_location : TUPLE[row:INTEGER_32;column:INTEGER_32] assign set_old_location

feature


	set_location(t:	TUPLE[row:INTEGER_32;column:INTEGER_32])
		do
			location := t
		end
	set_old_location(t:TUPLE[row:INTEGER_32;column:INTEGER_32])
		do
			old_location := t
		end

	set_current_health(ch : INTEGER)
		do
			current_health := ch
		end
	set_total_health(th : INTEGER)
		do
			total_health := th
		end
	set_current_energy(ce : INTEGER)
		do
			current_energy := ce
		end
	set_total_energy(te : INTEGER)
		do
			total_energy := te
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
		 e_regen:= er
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
