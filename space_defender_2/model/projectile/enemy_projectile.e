note
	description: "Summary description for {ENEMY_PROJECTILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENEMY_PROJECTILE
inherit
	PROJECTILE
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
			symbol := "<"
			location.compare_objects
			is_destroyed := false
		end

end
