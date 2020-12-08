note
	description: "Summary description for {PROJECTILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROJECTILE

	feature --Attributes
	id: INTEGER assign set_id
	damage : INTEGER assign set_damage
	location : TUPLE[row:INTEGER;column:INTEGER] assign set_location
	move_update : INTEGER assign set_move_update
	symbol : STRING assign set_symbol
	is_destroyed : BOOLEAN assign set_is_destroyed
	on_board : BOOLEAN assign set_on_board

	set_on_board(ob : BOOLEAN)
		do
			on_board := ob
		end

	set_is_destroyed(sid:BOOLEAN)
		do
			is_destroyed := sid
		end

	set_symbol(ss:STRING)
		do
			symbol := ss
		end
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
