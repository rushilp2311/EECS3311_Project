note
	description: "Summary description for {COLLISION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COLLISION
create
	make
feature
model : ETF_MODEL_ACCESS
	make
		do

	    end
feature

	--TYPES
	-- FP : 0
	-- EP : 1
	-- SF : 2
	-- E : 3

	check_for_collision(location:TUPLE[row:INTEGER;column:INTEGER];id:INTEGER;type:INTEGER)
	local
		check_id: INTEGER
		do
			check_id := -99999
			check_id := collide_with_friendly_projectile(location,id,type)
			if check_id > (-99999) then
				check_id := check_for_enemy_projectile(location)
			end

		end

feature

	collide_with_friendly_projectile(location:TUPLE[row:INTEGER;column:INTEGER];id:INTEGER;type:INTEGER):INTEGER
	local
		index:INTEGER
		value : INTEGER
		do
			Result := -99999
			from index := -1
			until
				index <= model.m.projectile_id
			loop
				if attached model.m.friendly_projectile_list.item (index) as el then
					if el.location ~ location then
						inspect
							type
						when 0 then
							-- If its friendly projectile then add the damage and and remove el (the checking entity is friendly projectile itself)
							if attached model.m.friendly_projectile_list.item (id) as current_projectile then
								current_projectile.damage := current_projectile.damage + el.damage
								Result := 0
								index := model.m.projectile_id - 1
							end
						when 1 then
							--If the checking entity is enemy projectile and collides with friendly projectile
							if attached model.m.enemy_projectile_list.item (id) as current_enemy_projectile then
								if el.damage > current_enemy_projectile.damage then
									el.damage := el.damage - current_enemy_projectile.damage
									--display
									model.m.enemy_projectile_list.remove (id)
								elseif el.damage < current_enemy_projectile.damage then
									current_enemy_projectile.damage := current_enemy_projectile.damage - el.damage
									model.m.friendly_projectile_list.remove (index)
								else
									model.m.friendly_projectile_list.remove (index)
									model.m.enemy_projectile_list.remove (id)
								end
							end
						when 2 then
							--If the checking entity is starfighter and collides with friendly projectile
						else

						end
					end
				end
				index := index - 1
			end
		end
	check_for_enemy_projectile(location:TUPLE[row:INTEGER;column:INTEGER]):INTEGER
	local
		index:INTEGER
		do
			from index := -1
			until
				index <= model.m.projectile_id
			loop
				if attached model.m.enemy_projectile_list.item (index) as el then
					if el.location ~ location then
						Result := index
					end
				end
				index := index - 1
			end
		end


end
