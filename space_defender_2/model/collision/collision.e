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

	check_for_collision(location:TUPLE[row:INTEGER;column:INTEGER];id:INTEGER;type:INTEGER):INTEGER
	local
		check_id: INTEGER
		do
			check_id := -99999
			check_id := collide_with_friendly_projectile(location,id,type)
			if check_id = -99999 then
				check_id := collide_with_enemy_projectile(location,id,type)
			end
			if (check_id = -99999) and (type /= 2) then
				check_id := collide_with_starfighter (location, id, type)
			end
			if(check_id = -99999)  then
				check_id := collide_with_enemy (location, id, type)
			end


		Result := check_id
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
					if (el.location.row = location.row) and (el.location.column = location.column) then

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
									current_enemy_projectile.is_destroyed := true
								elseif el.damage < current_enemy_projectile.damage then
									current_enemy_projectile.damage := current_enemy_projectile.damage - el.damage
									model.m.friendly_projectile_list.remove (el.id)
								else
									current_enemy_projectile.is_destroyed := true
									model.m.friendly_projectile_list.remove (el.id)
								end
								Result := 0
							end
						when 2 then
							--If the checking entity is starfighter and collides with friendly projectile
							if (el.damage - model.m.ship.armour) > 0 then
								model.m.ship.current_health := model.m.ship.current_health - (el.damage - model.m.ship.armour)
								if model.m.ship.current_health <= 0 then
								--STARFIGTHER DESTROYED
									model.m.ship.is_destroyed := true
									Result := 0
								end
							end
						when 3 then
							--Checking entity is enemy and collides with friendly projectile
							if attached model.m.enemy_table.item (id) as current_enemy then
								if (el.damage - current_enemy.armour) > 0 then
									current_enemy.current_health := current_enemy.current_health - (el.damage - current_enemy.armour)
									model.m.board.put ("_",el.location.row , el.location.column)
									model.m.friendly_projectile_list.remove (index)
									model.m.e_act_collision_str.append ("      The "+current_enemy.name+" collides with friendly projectile(id:"+el.id.out+") at location ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"], taking "+(el.damage - current_enemy.armour).out+" damage.%N")
									if current_enemy.current_health <= 0 then
										--ENEMY DESTORYED
										current_enemy.is_destroyed := true
										current_enemy.add_score
										Result := 0
									end
								end
							end

						else

						end
					end
				end
				index := index - 1
			end
		end
	collide_with_enemy_projectile(location:TUPLE[row:INTEGER;column:INTEGER];id:INTEGER;type:INTEGER):INTEGER
	local
		index:INTEGER
		value : INTEGER
		do
			Result := -99999
			from index := -1
			until
				index <= model.m.projectile_id
			loop
				if attached model.m.enemy_projectile_list.item (index) as el then
					if (el.location.row = location.row) and (el.location.column = location.column) then

						inspect type
						when 0 then
							--If its friendly projectile
							if attached model.m.friendly_projectile_list.item (id) as current_friendly_projectile then
								if el.damage < current_friendly_projectile.damage then
									current_friendly_projectile.damage := current_friendly_projectile.damage - el.damage
									model.m.board.put ("_", el.location.row, el.location.column)
									model.m.enemy_projectile_list.remove (el.id)
								elseif el.damage > current_friendly_projectile.damage then
									el.damage := el.damage - current_friendly_projectile.damage
									current_friendly_projectile.is_destroyed := true
								else
									model.m.board.put ("_", el.location.row, el.location.column)
									model.m.enemy_projectile_list.remove(el.id)
									current_friendly_projectile.is_destroyed := true
								end
								model.m.fp_act_collision_str.append ("      The projectile collides with enemy projectile(id:"+index.out+") at location ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"], negating damage.%N")
								index :=  model.m.projectile_id - 1
								Result := 0
							end
						when 1 then
							if attached  model.m.enemy_projectile_list.item (id) as current_enemy_projectile then
								current_enemy_projectile.damage := current_enemy_projectile.damage + el.damage
								el.is_destroyed := true
							end
						when 2 then
							if (el.damage - model.m.ship.armour) > 0 then
								model.m.ship.current_health := model.m.ship.current_health - (el.damage - model.m.ship.armour)
								model.m.sf_act_display_str.append ("      The Starfighter collides with enemy projectile(id:"+index.out+") at location ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"], taking "+(el.damage - model.m.ship.armour).out+" damage.%N")
								if model.m.ship.current_health <= 0 then
									model.m.ship.is_destroyed := true
									Result := 0

								end
								model.m.enemy_projectile_list.remove (index)
								model.m.board.put ("_", location.row, location.column)
							end
						else

						end
					end
				end
				index := index - 1
			end
		end

		collide_with_starfighter(location:TUPLE[row:INTEGER;column:INTEGER];id:INTEGER;type:INTEGER):INTEGER
			local
				index:INTEGER
				value : INTEGER
			do
				Result := -99999

				if (model.m.ship.location.row = location.row) and (model.m.ship.location.column = location.column) then
					inspect
					type
				when 0 then
					--WHEN CHECKING ENTITY IS FP AND COLLIDES WITH STARFIGHTER
					if attached model.m.friendly_projectile_list.item (id) as current_friendly_projectile then
						if (current_friendly_projectile.damage - model.m.ship.armour) > 0 then
							model.m.ship.current_health := model.m.ship.current_health - (current_friendly_projectile.damage - model.m.ship.armour)
								if model.m.ship.current_health <= 0 then
								--STARFIGTHER DESTROYED
									model.m.ship.is_destroyed := true
									Result := 0
								end
						end
					end
				when 1 then
					--WHEN CHECKING ENTITY IS EP AND COLLIDES WITH STARFIGHTER
					if attached model.m.enemy_projectile_list.item (id) as current_enemy_projectile then
						if (current_enemy_projectile.damage - model.m.ship.armour) > 0 then
							model.m.ship.current_health := model.m.ship.current_health - (current_enemy_projectile.damage - model.m.ship.armour)
							current_enemy_projectile.is_destroyed := true
								if model.m.ship.current_health <= 0 then
								--STARFIGTHER DESTROYED
									model.m.ship.is_destroyed := true

									Result := 0
								end
						end
					end
				when 3 then
					--WHEN CHECKING ENTITY IS ENEMY AND COLLIDES WITH STARFIGHTER
					if attached model.m.enemy_table.item (id) as current_enemy then
						model.m.ship.current_health := model.m.ship.current_health - current_enemy.current_health
						if model.m.ship.current_health <= 0 then
							model.m.ship.current_health := 0
							model.m.ship.is_destroyed := true
							Result := 0
							current_enemy.add_score

						end
						model.m.sf_act_display_str.append ("      The "+current_enemy.name+" at location ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"] has been destroyed.%N")
						model.m.enemy_table.remove (id)
					end
				else

				end
				end
			end
		collide_with_enemy(location:TUPLE[row:INTEGER;column:INTEGER];id:INTEGER;type:INTEGER):INTEGER
			local
				index:INTEGER
				value : INTEGER
			do
				Result := -99999
				from index := 1
				until
					index > model.m.enemy_id
				loop
					if attached model.m.enemy_table.item (index) as el then
						if (el.location.row = location.row) and (el.location.column = location.column) then
							inspect
								type
							when 0 then
								--FRIENDLY PROJECTILE
								if attached model.m.friendly_projectile_list.item (id) as fp then
									if (fp.damage - el.armour) > 0 then
									el.current_health := el.current_health - (fp.damage - el.armour)
									fp.is_destroyed := true
									model.m.fp_act_collision_str.append ("      The projectile collides with "+el.name+"(id:"+el.id.out+") at location ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"], dealing "+(fp.damage - el.armour).out+" damage.%N")
									if el.current_health <= 0 then
										--ENEMY DESTORYED
										el.is_destroyed := true
										model.m.fp_act_collision_str.append ("      The "+el.name+" at location ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"] has been destroyed.%N")
										model.m.board.put ("_", el.location.row, el.location.column)
										el.add_score
										model.m.enemy_table.remove (el.id)

										Result := 0
									end
								end
								end
							when 1 then
								--ENEMY PROJECTILE
								if attached model.m.enemy_projectile_list.item (id) as ep then
									el.current_health := el.current_health + ep.damage
									if el.current_health > el.total_health then
										el.current_health := el.total_health
									end
									ep.is_destroyed := true
									model.m.enemy_projectile_list.remove (ep.id)
									model.m.e_act_collision_str.append ("      The projectile collides with "+el.name+"(id:"+el.id.out+") at location ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"], healing "+(ep.damage).out+" damage.%N")
									Result := 0
								end





							when 2 then
								--STARFIGHTER
								model.m.ship.current_health := model.m.ship.current_health - el.current_health
								if model.m.ship.current_health <= 0 then
									model.m.ship.current_health := 0
									model.m.ship.is_destroyed := true
									model.m.sf_act_display_str.append ("      The Starfighter collides with "+el.name+"(id:"+index.out+") at location ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"], trading "+el.current_health.out+" damage.%N")
									model.m.sf_act_display_str.append ("      The "+el.name+" at location ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"] has been destroyed.%N")
									model.m.sf_act_display_str.append ("      The Starfighter at location ["+model.m.row_indexes.item (location.row).out+","+location.column.out+"] has been destroyed.%N")
								end
								Result := 0
								el.add_score
								model.m.enemy_table.remove (index)
							when 3 then
								Result := 1
							else

							end
						end
					end
					index := index + 1
				end
			end
end
