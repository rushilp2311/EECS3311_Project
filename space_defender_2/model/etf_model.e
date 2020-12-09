note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			row := 0
			column := 0
			g_threshold := 0
			f_threshold := 0
			c_threshold := 0
			i_threshold := 0
			p_threshold := 0
			in_setup := false
			in_game := false
			cursor := 0
			debug_mode:=false
			is_error:=false
			in_toggle_mode:=false
			success_state_counter := 0
			error_state_counter := 0
			create state_name.make_empty
			create state_type.make_empty
			create state_indicate.make_empty
			create error.make
			create output_msg.make_empty
			create setup_array.make_empty
			create state_items.make(7)
			create ship.make
			create ship_array.make_empty
			create friendly_projectile_list.make (100)
			create enemy_projectile_list.make (100)
			create grid_layout.make_empty
			row_indexes := <<"A", "B", "C", "D", "E", "F", "G", "H", "I", "J">>
			create board.make_filled (create {STRING}.make_empty,0,0)
			rand1 := 0
			rand2 := 0
			enemy_id := 1
			create enemy_table.make (10)
			projectile_id:=-1
			create fire_cmd.make
			create update.make
			create sf_act_display.make
			create sf_act_display_str.make_empty
			create projectile_list_display_str.make_empty
			create projectile_move_str.make_empty
			create update_ep.make
			create enemy_display_str.make_empty
			create enemy_act_display_str.make_empty
			create enemy_spawn_str.make_empty
			create enemy_projectile_move_str.make_empty
			create collision.make
			create fp_act_collision_str.make_empty
			create ep_act_collision_str.make_empty
			create sf_act_collision_str.make_empty
			create e_act_collision_str.make_empty
			create score.make
			----------------
			set_state_items

		end

feature -- model attributes

	row:INTEGER
	column:INTEGER
	g_threshold:INTEGER
	f_threshold:INTEGER
	c_threshold:INTEGER
	i_threshold:INTEGER
	p_threshold:INTEGER
	in_setup:BOOLEAN
	in_game:BOOLEAN
	cursor:INTEGER assign set_cursor
	debug_mode:BOOLEAN
	row_indexes : ARRAY[STRING]
	state_name:STRING
	error:ERROR
	is_error : BOOLEAN
	output_msg:STRING
	state_type:STRING
	state_indicate:STRING
	success_state:INTEGER
	error_state:INTEGER
	setup_array:ARRAY[SETUP]
	state_items : HASH_TABLE[STRING,INTEGER]
	ship_array:ARRAY[STARFIGHTER]
	success_state_counter :INTEGER assign set_success_state_counter
	error_state_counter :INTEGER assign set_error_state_counter
	ship:STARFIGHTER
	board : ARRAY2[STRING]
	grid_layout:STRING
	in_toggle_mode:BOOLEAN
	fire_cmd : FIRE
	update : UPDATE_PROJECTILE
	sf_act_display_str : STRING assign set_sf_act_display_str
	enemy_display_str:STRING assign set_enemy_display_str
	sf_act_display : STARFIGHTER_ACT_DISPLAY
	projectile_list_display_str : STRING
	projectile_move_str:STRING
	update_ep : UPDATE_ENEMY_PROJECTILE
	enemy_act_display_str :STRING assign set_enemy_act_display_str
	enemy_spawn_str : STRING assign set_enemy_spawn
	enemy_projectile_move_str :STRING
	collision:COLLISION
	score:SCORE

	-------------------------------------
	--COLLISION STRINGS
	fp_act_collision_str : STRING
	ep_act_collision_str : STRING
	sf_act_collision_str : STRING
	e_act_collision_str : STRING



	--Enemy attributes
	enemy_id : INTEGER assign set_enemy_id
	enemy_table : HASH_TABLE[ENEMY,INTEGER]


	-- Random generator access feature object
	rand_access : RANDOM_GENERATOR_ACCESS

	-- Random numbers
	rand1 : INTEGER
	rand2 : INTEGER


	--Friendly Projectile Table
	friendly_projectile_list : HASH_TABLE[PROJECTILE,INTEGER]

	projectile_id:INTEGER assign set_projectile_id
	enemy_projectile_list : HASH_TABLE[PROJECTILE,INTEGER]


feature --utility operations

	-- Generating random number
	generate_random_number
		do
			rand1 := rand_access.rchoose (1, row)
			rand2 := rand_access.rchoose (1, 100)
		end

	-- Toggle features to toggle boolean values accordingly

	toggle_in_setup
		do
			in_setup := not in_setup
		end
	toggle_in_game
		do
			in_game := not in_game
		end
	toggle_is_error
		do
			is_error := not is_error
		end
	toggle_toggle_mode
		do
			in_toggle_mode := not in_toggle_mode
		end
	set_cursor(sc:INTEGER)
		do
			cursor := sc
		end
	set_enemy_spawn(ses:STRING)
		do
			enemy_spawn_str := ses
		end

	set_enemy_act_display_str(eacds: STRING)
		do
			enemy_act_display_str := eacds
		end


	set_enemy_display_str(eds :STRING)
		do
			enemy_display_str :=eds
		end

	set_projectile_id(spi:INTEGER)
		do
			projectile_id := spi
		end


	set_enemy_id(eid:INTEGER)
		do
			enemy_id := eid
		end

	set_sf_act_display_str (s:STRING)
		do
			sf_act_display_str := s
		end

	set_error_state_counter(esc : INTEGER)
		do
			error_state_counter := esc
		end
	set_success_state_counter(ssc : INTEGER)
		do
			success_state_counter := ssc
		end



	-- Setting Indicator for error / ok
	set_indicate
		do
			if is_error then
				state_indicate := "error"
			else
				state_indicate := "ok"
			end
		end

	-- State type (DEBUG / NORMAL)
	set_state_type
		do
			if in_toggle_mode then
			 	state_type := "debug"
			else
				state_type := "normal"
			end
		end

	-- Setting state
	set_state
		do
			if attached state_items.item (cursor) as s  then
				if cursor > 5 then
					if attached state_items.item (6) as sn  then
					state_name := sn
					end
				else
					state_name := s
				end
			end
			if cursor > 5 then
				output_msg := "  state:in game("+success_state_counter.out+"."+error_state_counter.out+"), "+state_type+", "+state_indicate
			else
				output_msg := "  state:"+state_name +", "+state_type+", "+state_indicate
			end
		end
	-- Setting the output string when successfully executed
	set_success_output_msg(s:STRING)
		do
			output_msg.make_empty
				set_state_type
				set_indicate
				set_state
			output_msg.append ("%N"+s)
		end

	-- Setting the output string when error is occured
	set_error_output_msg(s:STRING)
		do
			set_state_type
			set_indicate
			set_state
			output_msg.append ("%N  "+s)
		end

	--To keep track of state
	set_state_items
		do
			state_items.extend ("not started",0)
			state_items.extend ("weapon setup",1)
			state_items.extend ("armour setup",2)
			state_items.extend ("engine setup",3)
			state_items.extend ("power setup",4)
			state_items.extend ("setup summary",5)
			state_items.extend ("in game",6)
		end

	-- Storing parameters when first paly command is used
	set_parameters(r:INTEGER; c:INTEGER; n1:INTEGER; n2:INTEGER; n3:INTEGER; n4:INTEGER; n5:INTEGER)
	local
			s_row:REAL_64
		do
			row := r
			column := c
			g_threshold := n1
			f_threshold := n2
			c_threshold := n3
			i_threshold := n4
			p_threshold := n5
			s_row := row/2
			ship.location.row := s_row.ceiling
			ship.location.column := 1
			ship.initial_location.row := ship.location.row
			ship.initial_location.column := ship.location.column
			create board.make_filled ("",row,column)
			initialize_board
		end

	--Array for the different setup stages in order
	set_setup_array
	local
		i : INTEGER
		do
			setup_array.force (create {WEAPON_SETUP}.make,setup_array.count + 1)
			setup_array.force (create {ARMOUR_SETUP}.make,setup_array.count + 1)
			setup_array.force (create {ENGINE_SETUP}.make,setup_array.count + 1)
			setup_array.force (create {POWER_SETUP}.make,setup_array.count + 1)
			setup_array.force (create {SETUP_SUMMARY}.make,setup_array.count + 1)

			from i := 1
			until
				i >5
			loop
				ship_array.force (create {STARFIGHTER}.make, i)
				i:=i+1
			end
		end

	-- Features to update cursor
	set_cursor_next(c :INTEGER)
		do
			cursor := cursor + c
		end
	set_cursor_back(c:INTEGER)
		do
			cursor := cursor - c
		end

	----------------------------------------------------------------------------------

	increment_cursor
		do
			cursor := cursor + 1
		end
	decrement_cursor
		do
			cursor := cursor - 1
		end
	increment_success_state_counter
		do
			success_state_counter := success_state_counter + 1
		end
	increment_error_state_counter
		do
			error_state_counter := error_state_counter + 1
		end
	decrement_projectile_id
		do
			projectile_id := projectile_id - 1
		end
	-----------------------------------------------------------------------------------
	--ENEMY METHODS
	--Adding enemy to enemy table
	--TODO : CHECK FOR OCCUPIED POSITIONS
	add_enemy
	local
		check_id:INTEGER
		do
			generate_random_number
			if rand2 >= 1 and rand2 < g_threshold then
				enemy_table.extend (create {GRUNT}.make(enemy_id,100,1,1,5), enemy_id)
				if attached enemy_table.item (enemy_id) as el then
					enemy_spawn_str.append ("    A Grunt(id:"+enemy_id.out+") spawns at location ["+row_indexes.item (rand1).out+","+column.out+"].")

					check_id := collision.check_for_collision ([rand1,column], enemy_id, 3)
					if check_id/=1 and not el.is_destroyed then
						el.location := [rand1,column]
						board.put ("G",rand1, column)
					else
						enemy_table.remove (enemy_id)
					end
					enemy_vision_update
				end
				enemy_id := enemy_id + 1
			elseif rand2 >= g_threshold and rand2 < f_threshold then
				enemy_table.extend (create {FIGHTER}.make(enemy_id,150,5,10,10), enemy_id)
				if attached enemy_table.item (enemy_id) as el then
					enemy_spawn_str.append ("    A Fighter(id:"+enemy_id.out+") spawns at location ["+row_indexes.item (rand1).out+","+column.out+"].")
					check_id := collision.check_for_collision ([rand1,column], enemy_id, 3)
					if check_id/=1 and not el.is_destroyed then
						el.location := [rand1,column]
						board.put ("F",rand1, column)
					else
						enemy_table.remove (enemy_id)
					end
					enemy_vision_update
				end
				enemy_id := enemy_id + 1
			elseif rand2 >= f_threshold and rand2 < c_threshold then
				enemy_table.extend (create {CARRIER}.make(enemy_id,200,10,15,15), enemy_id)
				if attached enemy_table.item (enemy_id) as el then
					enemy_spawn_str.append ("    A Carrier(id:"+enemy_id.out+") spawns at location ["+row_indexes.item (rand1).out+","+column.out+"].")
					check_id := collision.check_for_collision ([rand1,column], enemy_id, 3)
					if check_id/=1 and not el.is_destroyed then
						el.location := [rand1,column]
						board.put ("C",rand1, column)
					else
						enemy_table.remove (enemy_id)
					end
					enemy_vision_update
				end
				enemy_id := enemy_id + 1
			elseif rand2 >= c_threshold and rand2 < i_threshold then
				enemy_table.extend (create {INTERCEPTOR}.make(enemy_id,50,0,0,5), enemy_id)
				if attached enemy_table.item (enemy_id) as el then
					enemy_spawn_str.append ("    A Interceptor(id:"+el.id.out+") spawns at location ["+row_indexes.item (rand1).out+","+column.out+"].")
					check_id := collision.check_for_collision ([rand1,column], enemy_id, 3)
					if check_id/=1 and not el.is_destroyed then
						el.location := [rand1,column]
						board.put ("I",rand1, column)
					else
						enemy_table.remove (enemy_id)
					end
					enemy_vision_update
				end
				enemy_id := enemy_id + 1
			elseif rand2 >= i_threshold and rand2 < p_threshold then
				enemy_table.extend (create {PYLON}.make(enemy_id,300,0,0,5), enemy_id)
				if attached enemy_table.item (enemy_id) as el then
					enemy_spawn_str.append ("    A Pylon(id:"+enemy_id.out+") spawns at location ["+row_indexes.item (rand1).out+","+column.out+"].")
					check_id := collision.check_for_collision ([rand1,column], enemy_id, 3)
					if check_id/=1 and not el.is_destroyed then
						el.location := [rand1,column]
						board.put ("P",rand1, column)
					else
						enemy_table.remove (enemy_id)
					end
					enemy_vision_update
				end
				enemy_id := enemy_id + 1

			else

			end
		end


calculate_move_cost(steps : INTEGER)
	do
		if (ship.move_cost * steps) <= ship.current_energy  then
			ship.current_energy := ship.current_energy - (ship.move_cost * steps)
		else
			if is_error = false then
				toggle_is_error
				increment_error_state_counter
				set_error_output_msg (error.move_resource)
			end
		end

	end
apply_regenration
	do
		if ship.current_health /= ship.total_health then
			ship.current_health := ship.current_health + ship.h_regen
		end
		if ship.current_energy /= ship.total_energy then
			ship.current_energy := ship.current_energy + ship.e_regen
		end
		if ship.current_energy > ship.total_energy then
			ship.current_energy := ship.total_energy
		end
		if ship.current_health > ship.total_health then
			ship.current_health := ship.total_health
		end
	end

calculate_fire_cost
	do
		if ship.choice_selected[1].pos = 4 then
			if ship.projectile_cost < ship.current_health then
				ship.current_health := ship.current_health - ship.projectile_cost
			else
				if is_error = false then
					toggle_is_error
					increment_error_state_counter
					set_error_output_msg (error.fire_resource)
				end
			end
		else
			if ship.projectile_cost < ship.current_energy then
				ship.current_energy := ship.current_energy - ship.projectile_cost
			else
				if is_error = false then
					toggle_is_error
					increment_error_state_counter
					set_error_output_msg (error.fire_resource)
				end
			end
		end

	end

enemy_vision_update
local
	i : INTEGER
	do
		from i:= 1
		until
			i > enemy_id
		loop
			if attached enemy_table.item (i) as eti  then
				eti.update_can_see_starfighter
				eti.update_seen_by_starfighter
			end

			i := i+1
		end
	end
enemy_act
local
	i : INTEGER
	do
		from i:= 1
		until
			i > enemy_id
		loop
			if attached enemy_table.item (i) as eti  then
				if eti.is_turn_ended = false then
					if eti.can_see_starfighter then
						eti.action_when_starfighter_is_seen
					else
						eti.action_when_starfighter_is_not_seen
					end
				end
			end

			i := i+1
		end
	end


feature -- model operations

	enemy_display
	local
		i : INTEGER
		ss:STRING
		css:STRING
	do
		from i:= 1
		until
			i > enemy_id
		loop

			if attached enemy_table.item (i) as eti  then
				if eti.seen_by_starfighter = true then
					ss := "T"
				else
					ss := "F"
				end
				if eti.can_see_starfighter = true then
					css := "T"
				else
					css := "F"
				end
				if not eti.is_destroyed and enemy_table.has (i) then
					enemy_display_str.append ("    ["+i.out+","+eti.symbol+"]->health:"+eti.current_health.out+"/"+eti.total_health.out+", Regen:"+eti.regen.out+", Armour:"+eti.armour.out+", Vision:"+eti.vision.out+", seen_by_Starfighter:"+ss+", can_see_Starfighter:"+css+", location:["+row_indexes.item(eti.location.row).out+","+eti.location.column.out+"]%N")
				end
			end

			i := i+1
		end
	end

	projectile_display
	local
		i :INTEGER
		temp_table : HASH_TABLE[PROJECTILE,INTEGER]
		do
			create projectile_list_display_str.make_empty
			create temp_table.make (200)
			if friendly_projectile_list.count > 0 then
				temp_table.copy (friendly_projectile_list)
			end
			if enemy_projectile_list.count > 0 then
				temp_table.merge (enemy_projectile_list)
			end
			from i := -1
			until
				i < projectile_id
			loop
				if temp_table.has (i) then
					if attached temp_table.item (i) as fp then
						projectile_list_display_str.append ("    ["+i.out+","+fp.symbol+"]->damage:"+fp.damage.out+", move:"+fp.move_update.out+", location:["+row_indexes.item(fp.location.row).out+","+fp.location.column.out+"]%N")
					end
				end
				i := i - 1
			end
		end


	--Displaying info and board
	display
		local
			s :STRING
--			i:INTEGER
		do
			create s.make_empty
			projectile_display
			if enemy_table.count > 0 then
				enemy_display
			end
			s.append ("  Starfighter:%N")
			s.append ("    [0,S]->health:"+ship.current_health.out+"/"+ship.total_health.out+", energy:"+ship.current_energy.out+"/"+ship.total_energy.out+", Regen:"+ship.h_regen.out+"/"+ship.e_regen.out+", Armour:"+ship.armour.out+", Vision:"+ship.vision.out+", Move:"+ship.move.out+", Move Cost:"+ship.move_cost.out+", location:["+row_indexes.item (ship.location.row).out+","+ship.location.column.out+"]%N")
			s.append ("      Projectile Pattern:"+ship.choice_selected[1].name+", Projectile Damage:"+ship.projectile_damage.out)
			if ship.choice_selected[1].pos ~ 4 then
				s.append (", Projectile Cost:"+ship.projectile_cost.out+" (health)%N")
			else
				s.append (", Projectile Cost:"+ship.projectile_cost.out+" (energy)%N")
			end
			s.append ("      Power:"+ship.choice_selected[4].name+"%N")
			s.append ("      score:"+score.get_score.out)
			if in_toggle_mode then
				s.append ("%N  Enemy:%N")
					s.append (enemy_display_str)
				s.append ("  Projectile:%N")
				s.append (projectile_list_display_str)
				s.append ("  Friendly Projectile Action:%N")
				s.append (projectile_move_str)
				s.append ("  Enemy Projectile Action:%N")
				s.append (enemy_projectile_move_str)
				s.append ("  Starfighter Action:%N")
				if success_state_counter > 0 then
					s.append ("    "+sf_act_display_str)
				end
				s.append ("  Enemy Action:%N")
				if not enemy_act_display_str.is_empty then
					s.append (enemy_act_display_str)

				end
				s.append ("  Natural Enemy Spawn:")
				if not enemy_spawn_str.is_empty then
					s.append ("%N"+enemy_spawn_str)
				end
				create enemy_spawn_str.make_empty
			end
			make_board
			s.append (grid_layout)
			set_success_output_msg (s)
		end

	initialize_board
		do
			across 1 |..| board.height as r
			loop
				across 1 |..| board.width as c
				loop
					if(ship.location.row ~ r.item and ship.location.column ~ c.item) then
							board.put ("S",r.item,c.item)
					else
							board.put ("_",r.item,c.item)
					end
				end
			end

		end

	make_board
		local
			fi: FORMAT_INTEGER
			vision:INTEGER
			index:INTEGER
		do
			create fi.make (2)
			grid_layout := ""
			--Adding enemy to the board
			across 1 |..| (enemy_table.count) as et
			loop
				if attached enemy_table.item (et.item) as el then
					if  el.location.column >= 1  then
						board.put (el.symbol,el.location.row,el.location.column)
						el.is_turn_ended := false
					end
				end
			end

			from index := -1
			until
				index <= projectile_id
			loop
				if attached enemy_projectile_list.item (index) as el then
					if  enemy_projectile_list.has (index) and el.location.column >= 1  then
						board.put ("<", el.location.row,el.location.column)
					end
				end
				index := index-1
			end
			-- Appending board array to a string
			grid_layout.append("%N")
			grid_layout.append ("    ")
			across 1 |..| board.width as i
			loop
				if (i.item) < 10  then
					grid_layout.append("  " +  (i.item).out)
				else
					grid_layout.append(" " +  (i.item).out)
				end

			end
			across 1 |..| board.height as r
			loop
				grid_layout.append ("%N    "+ row_indexes[r.item].out)
				grid_layout.append (" ")
				across 1 |..| board.width as c
				loop
					vision := ((ship.location.row-r.item).abs+(ship.location.column-c.item).abs)
						vision := vision.abs
						if (vision > ship.vision) and (not in_toggle_mode) then
							grid_layout.append ("?")
						else
							grid_layout.append (board.item (r.item, c.item))
						end

					if c.item < board.width then
						grid_layout.append ("  ")

					end
				end
			end
		end

	play
	local
		s :STRING
		do
			create s.make_empty
			across 1 |..| ship_array.count as sa
			loop
				ship.total_health := ship.total_health + ship_array[sa.item].total_health
				ship.current_health := ship.total_health
				ship.total_energy := ship.total_energy + ship_array[sa.item].total_energy
				ship.current_energy := ship.total_energy
				ship.h_regen := ship.h_regen + ship_array[sa.item].h_regen
				ship.e_regen := ship.e_regen + ship_array[sa.item].e_regen
				ship.armour := ship.armour + ship_array[sa.item].armour
				ship.vision := ship.vision + ship_array[sa.item].vision
				ship.move := ship.move + ship_array[sa.item].move
				ship.move_cost := ship.move_cost + ship_array[sa.item].move_cost
				ship.projectile_cost := ship_array[1].projectile_cost
				ship.projectile_damage := ship_array[1].projectile_damage
			end
			display
		end
	pass
	local
		i:INTEGER
		do
			error_state_counter := 0 --Reseting error state cursor
			increment_success_state_counter
			create e_act_collision_str.make_empty
			create enemy_act_display_str.make_empty
			--FRIEDNLY PROJECTILE ACT
			if friendly_projectile_list.count > 0 then
				update.update_friendly_projectile
			end
			--ENEMY PROJECTILE ACT
			if enemy_projectile_list.count > 0 then
				update_ep.update_enemy_projectile_location
			end
			--STARFIGHTER ACT
			apply_regenration
			apply_regenration
			--ENEMY VISION UPDATE
			if enemy_table.count >0 then
				enemy_vision_update
			--ENEMY ACT
			from i:= 1
				until
					i > enemy_id
				loop
					if attached enemy_table.item (i) as eti  then
						eti.preemptive_action (1)
					end
					i := i+1
				end
				enemy_act
			--ENEMY VISION UPDATE
				enemy_vision_update
			end
			--ENEMY SPWAN
			add_enemy
			if ship.is_destroyed then
				-- Put X on the location of starfigther

				board.put ("X", ship.location.row, ship.location.column)
				cursor := 0
			end
			sf_act_display_str := sf_act_display.display_act (3)
			display
		end

	move(move_row:INTEGER;move_column:INTEGER)
		local
			j,k,check_id:INTEGER
			collision_string : STRING
		do
			ship.old_location := ship.location
			error_state_counter := 0 --Reseting error state cursor
			create collision_string.make_empty
			create enemy_act_display_str.make_empty
			create e_act_collision_str.make_empty
			--FRIENDLY PROJECTILE ACT
			if friendly_projectile_list.count > 0 then
				update.update_friendly_projectile
			end
			--ENEMY PROJECTILE ACT
			if enemy_projectile_list.count > 0 then
				update_ep.update_enemy_projectile_location
			end

			-- STARFIGHTER ACT
			apply_regenration
			--move down in same column
			if (ship.location.row < move_row) and (ship.is_destroyed = false) then
				from
					j:= ship.location.row
				until
					j > move_row
				loop
					ship.location := [j,ship.location.column]
					check_id := collision.check_for_collision (ship.location, 0, 2)
					if ship.is_destroyed then
						-- Put X on the location of starfigther
						board.put ("_", ship.old_location.row, ship.old_location.column)
						board.put ("X", ship.location.row, ship.location.column)
						j := move_row + 1
					else


					end

					j:=j+1
				end

			end

			-- move up in same column
			if (ship.location.row > move_row) and (ship.is_destroyed = false) then
				from
					j := ship.location.row
				until
					j < move_row
				loop
					ship.location := [j,ship.location.column]
					check_id := collision.check_for_collision (ship.location, 0, 2)
					if ship.is_destroyed then
						-- Put X on the location of starfigther
						board.put ("_", ship.old_location.row, ship.old_location.column)
						board.put ("X", ship.location.row, ship.location.column)
						j := move_row -1
					else


					end
					j := j - 1
				end
			end

			-- move right in same row
			if (ship.location.column < move_column) and (ship.is_destroyed = false) then

				from
					k := ship.location.column + 1
				until
					k > move_column
				loop
					ship.location := [ship.location.row, k]
					check_id := collision.check_for_collision ([ship.location.row, k], 0, 2)
					if ship.is_destroyed then
						-- Put X on the location of starfigther
						board.put ("_", ship.old_location.row, ship.old_location.column)
						board.put ("X", ship.location.row, ship.location.column)
						k := k + move_column +1
					else

					end
					k := k + 1
				end
			end

			-- move left in same row
			if (ship.location.column >  move_column) and (ship.is_destroyed = false)then
				from
					k := ship.location.column
				until
					k < move_column
				loop
					ship.location := [ship.location.row, k]
					check_id := collision.check_for_collision ([ship.location.row, k], 0, 2)
					if ship.is_destroyed then
						-- Put X on the location of starfigther
						board.put ("_", ship.old_location.row, ship.old_location.column)
						board.put ("X", ship.location.row, ship.location.column)
					else


					end
					k := k - 1
				end
			end
			if  (ship.is_destroyed = false) then
				board.put ("_", ship.old_location.row, ship.old_location.column)
				board.put ("S", ship.location.row, ship.location.column)
			end

			calculate_move_cost ((ship.location.row - ship.old_location.row).abs + (ship.location.column - ship.old_location.column).abs)
			--ENEMY VISION UPDATE
				enemy_vision_update
			--ENEMY ACT
				enemy_act
			--ENEMY VISION UPDATE
				enemy_vision_update
			if (is_error = false) then
				increment_success_state_counter

				if (ship.is_destroyed = false)  then
					--ENEMY SPWAN
					add_enemy
				else
					cursor := 0
				end
				sf_act_display_str.prepend (sf_act_display.display_act (1))
				display
			end

		end
	fire
	local
		i :INTEGER
		do
			--CHECK COLLIDING VALIDATIONS
			error_state_counter := 0 --Reseting error state cursor
			create e_act_collision_str.make_empty
			--FRIENDLY PROJECTILE ACT
			if friendly_projectile_list.count > 0 then
				update.update_friendly_projectile
			end
			--ENEMY PROJECTILE ACT
			if enemy_projectile_list.count > 0 then
				update_ep.update_enemy_projectile_location
			end

			-- STARFIGHTER ACT
			apply_regenration
			fire_cmd.fire
			--ENEMY VISION UPDATE
			enemy_vision_update
			--ENEMY ACT
			from i:= 1
				until
					i > enemy_id
				loop
					if attached enemy_table.item (i) as eti  then
						eti.preemptive_action (2)
					end

					i := i+1
				end
				enemy_act
			--ENEMY VISION UPDATE
			enemy_vision_update
			--ENEMY SPWAN
			add_enemy
			if ship.is_destroyed then
						-- Put X on the location of starfigther
						board.put ("_", ship.old_location.row, ship.old_location.column)
						board.put ("X", ship.location.row, ship.location.column)

			end
			if is_error = false then
				increment_success_state_counter
				display
			end
		end

	special
		local
			i :INTEGER
			index : INTEGER
		do
			--APPLY REGENRATION CHECK COLLIDING VALIDATIONS
			error_state_counter := 0 --Reseting error state cursor
			create e_act_collision_str.make_empty
			if friendly_projectile_list.count > 0 then
				update.update_friendly_projectile
			end
			--ENEMY PROJECTILE ACT
			if enemy_projectile_list.count > 0 then
				update_ep.update_enemy_projectile_location
			end
			-- STARFIGHTER ACT
			apply_regenration
			-- TODO: ANOTHER CLASS AFTER EVERYTHING IS DONE
			inspect ship.choice_selected[4].pos
			when 1 then
				board.put ("_", ship.location.row, ship.location.column)
				ship.location.row := ship.initial_location.row
				ship.location.column := ship.initial_location.column
				ship.location := [ship.initial_location.row,ship.initial_location.column]

				board.put ("S", ship.location.row, ship.location.column)
				if ship.current_energy > 50 then
					ship.current_energy := ship.current_energy - 50
				else
					toggle_is_error
					set_error_output_msg (error.special_resource)
				end
				create sf_act_display_str.make_empty
				sf_act_display_str.append ("The Starfighter(id:0) uses special, teleporting to: ["+row_indexes.item (ship.initial_location.row).out+","+ship.location.column.out+"]%N")
			when 2 then

				if ship.current_energy > 50 then
					ship.current_energy := ship.current_energy - 50
					ship.current_health := ship.current_health + 50
				else
					toggle_is_error
					set_error_output_msg (error.special_resource)
				end
				create sf_act_display_str.make_empty
				sf_act_display_str.append ("The Starfighter(id:0) uses special, gaining 50 health.%N")
			when 3 then
				if ship.current_health > 50 then
					ship.current_energy := (ship.current_health - 50) * 2
					ship.current_health := ship.current_health - 50
					sf_act_display_str.append ("The Starfighter(id:0) uses special, gaining "+((ship.current_health - 50) * 2).out+" energy at the expense of "+(ship.current_health - 50).out+" health.%N")
				else
					ship.current_energy := (ship.current_health - 1) * 2
					ship.current_health := 1
					sf_act_display_str.append ("The Starfighter(id:0) uses special, gaining "+((ship.current_health - 1) * 2).out+" energy at the expense of "+(ship.current_health - 1).out+" health.%N")
				end
			when 4 then
				from index := -1
				until
					index <= projectile_id
				loop
					if attached enemy_projectile_list.item (index) as el then
						if  enemy_projectile_list.has (index)  then
							board.put ("_", el.location.row,el.location.column)
						end
					end
					if attached friendly_projectile_list.item (index) as el then
						if  friendly_projectile_list.has (index)  then
							board.put ("_", el.location.row,el.location.column)
						end
					end
					index := index-1
				end

				if ship.current_energy > 100 then
					ship.current_energy := ship.current_energy - 100
				else
					toggle_is_error
					set_error_output_msg (error.special_resource)
				end
				sf_act_display_str := sf_act_display.display_act (4)
				create friendly_projectile_list.make (100)
				create enemy_projectile_list.make (100)
			when 5 then
				sf_act_display_str.append ("The Starfighter(id:0) uses special, clearing projectiles with drones.")
				from i:= 1
				until
					i > enemy_id
				loop
					if attached enemy_table.item (i) as ep then
						ep.current_health := ep.current_health - (100 - ep.armour)
						if ep.current_health <= 0 then
							sf_act_display_str.append ("The "+ep.name+" at location ["+row_indexes.item (ep.location.row).out+","+ep.location.column.out+"] has been destroyed.%N")
							enemy_table.remove (i)
						else
							sf_act_display_str.append ("The "+ep.name+"(id:"+ep.id.out+") at location ["+row_indexes.item (ep.location.row).out+","+ep.location.column.out+"] takes 100 damage.%N")
						end
					end
				end
			else

			end
			--ENEMY VISION UPDATE
			if enemy_table.count >0 then
				enemy_vision_update
			--ENEMY ACT
			from i:= 1
				until
					i > enemy_id
				loop
					if attached enemy_table.item (i) as eti  then
						eti.preemptive_action (3)
					end

					i := i+1
				end
				enemy_act
			--ENEMY VISION UPDATE
				enemy_vision_update
			end
			--ENEMY SPWAN
			add_enemy
			if ship.is_destroyed then
						-- Put X on the location of starfigther
						board.put ("_", ship.old_location.row, ship.old_location.column)
						board.put ("X", ship.location.row, ship.location.column)
					end
			if is_error = false then
				increment_success_state_counter
				display
			end
		end

	abort
		do
			create friendly_projectile_list.make (100)
			create enemy_projectile_list.make (100)
			create enemy_table.make (100)
			create enemy_act_display_str.make_empty
			create enemy_display_str.make_empty
			create e_act_collision_str.make_empty
			create fp_act_collision_str.make_empty
			create sf_act_collision_str.make_empty
			create e_act_collision_str.make_empty
			success_state_counter := 0
			error_state_counter := 0
			ship.empty_attributes
			projectile_id := -1
			enemy_id := 1
			if in_toggle_mode then
				output_msg:= "  state:not started, debug, ok%N"
			else
				output_msg:= "  state:not started, normal, ok%N"
			end

			output_msg.append("  Exited from game.")
			toggle_in_game

		end
	reset
		-- Reset model state.
		do
			make
		end

feature -- queries
	out : STRING
		do
			create Result.make_empty
			--TODO check for toggle mode in the very begining
			if cursor = 0 and not (is_error or in_toggle_mode) and not ship.is_destroyed then
				set_state_type
				set_indicate
				set_state
				Result.append(output_msg)
				Result.append("%N  Welcome to Space Defender Version 2.")

			else
				Result.append (output_msg)
				if ship.is_destroyed then
					Result.append ("%N  The game is over. Better luck next time!")
				end

				output_msg:=""
			end
			create projectile_move_str.make_empty
			create enemy_projectile_move_str.make_empty
			create enemy_display_str.make_empty
			create enemy_act_display_str.make_empty
			create fp_act_collision_str.make_empty
			create sf_act_display_str.make_empty
			create enemy_spawn_str.make_empty
			create e_act_collision_str.make_empty
		end

end




