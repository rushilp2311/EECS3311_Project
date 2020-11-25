note
	description: "Summary description for {ENEMY_ACT_DISPLAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENEMY_ACT_DISPLAY
feature
	model : ETF_MODEL_ACCESS
	make
		do

		end
feature
	display_act(type: INTEGER):STRING
		do
			create Result.make_empty
			inspect
				type
			when 1 then
				Result.append ("The Starfighter(id:0) moves: ["+model.m.row_indexes.item (model.m.ship.old_location.row).out+","+model.m.ship.old_location.column.out+"] -> ["+model.m.row_indexes.item (model.m.ship.location.row).out+","+model.m.ship.location.column.out+"]")
			when 2 then
			--CHANGE FOR SPREAD AND ROCKET
			if attached model.m.enemy_projectile_list.item(model.m.projectile_id) as ep then
				Result.append ("      A enemy projectile(id:"+model.m.projectile_id.out+") spawns at location ["+model.m.row_indexes.item (ep.location.row ).out+","+(ep.location.column).out+"].")
			end

			when 3 then
				Result.append ("The Starfighter(id:0) passes at location ["+model.m.row_indexes.item (model.m.ship.location.row).out+","+model.m.ship.location.column.out+"], doubling regen rate.")
			else

			end
		end
end
