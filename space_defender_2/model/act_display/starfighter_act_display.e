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
		do
			create Result.make_empty
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
			else

			end
		end
end
