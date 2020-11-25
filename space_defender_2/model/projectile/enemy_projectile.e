note
	description: "Summary description for {ENEMY_PROJECTILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENEMY_PROJECTILE
create
	make
feature
	model : ETF_MODEL_ACCESS
	make(i_d:INTEGER;pd:INTEGER;m:INTEGER;l:TUPLE[row:INTEGER;column:INTEGER])
		do
			id := i_d
			damage := pd
			move_update := m
			create location.default_create
			location := l
		end
	feature --Attributes
	id: INTEGER assign set_id
	damage : INTEGER assign set_damage
	location : TUPLE[row:INTEGER;column:INTEGER] assign set_location
	move_update : INTEGER assign set_move_update
	set_id (i : INTEGER)
		do
			id := i
		end
	set_damage (d:INTEGER)
		do
			damage := d
		end
	set_location (t : TUPLE[row:INTEGER;column:INTEGER])
		do
			location := t
		end
	set_move_update(mu : INTEGER)
		do
			move_update := mu
		end

end
