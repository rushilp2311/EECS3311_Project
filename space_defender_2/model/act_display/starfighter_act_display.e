note
	description: "Summary description for {STARFIGHTER_ACT_DISPLAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STARFIGHTER_ACT_DISPLAY
create
	make
feature
	model : ETF_MODEL_ACCESS
	make
		do

		end
feature
	display_act(type: INTEGER):STRING
	local
		i :INTEGER
		temp_table : HASH_TABLE[PROJECTILE,INTEGER]
		do
			create Result.make_empty
			create temp_table.make (200)
					if model.m.friendly_projectile_list.count > 0 then
						temp_table.copy (model.m.friendly_projectile_list)
					end
					if model.m.enemy_projectile_list.count > 0 then
						temp_table.merge (model.m.enemy_projectile_list)
					end
			inspect
				type
			when 1 then
				Result.append ("The Starfighter(id:0) moves: ["+model.m.row_indexes.item (model.m.ship.old_location.row).out+","+model.m.ship.old_location.column.out+"] -> ["+model.m.row_indexes.item (model.m.ship.location.row).out+","+model.m.ship.location.column.out+"]%N")
			when 2 then
			--CHANGE FOR SPREAD AND ROCKET

					Result.append ("The Starfighter(id:0) fires at location ["+model.m.row_indexes.item (model.m.ship.location.row).out+","+model.m.ship.location.column.out+"].%N")

					Result.append ("      A friendly projectile(id:"+model.m.projectile_id.out+") spawns at location ["+model.m.row_indexes.item (model.m.ship.location.row).out+","+(model.m.ship.location.column+1).out+"].%N")
			when 3 then
				Result.append ("The Starfighter(id:0) passes at location ["+model.m.row_indexes.item (model.m.ship.location.row).out+","+model.m.ship.location.column.out+"], doubling regen rate.%N")
			when 4 then
				inspect
					model.m.ship.choice_selected[4].pos
				when 4 then
					Result.append("The Starfighter(id:0) uses special, clearing projectiles with drones.%N")
					from i := -1
					until
						i < model.m.projectile_id
					loop
						if temp_table.has (i) then
							if attached temp_table.item (i) as fp then
									Result.append ("      A projectile(id:"+i.out+") at location ["+model.m.row_indexes.item(fp.location.row).out+","+fp.location.column.out+"] has been neutralized.%N")
							end
						end

						i := i - 1
					end
				else

				end

			else

			end
		end
end
