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

			create grid_layout.make_empty
			row_indexes := <<'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'>>
			create board.make_filled (create {STRING}.make_empty,0,0)
			rand1 := 0
			rand2 := 0
			enemy_id := 1
			create enemy_table.make (10)


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
	cursor:INTEGER
	debug_mode:BOOLEAN
	row_indexes : ARRAY[CHARACTER]
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
	success_state_counter :INTEGER
	error_state_counter :INTEGER
	ship:STARFIGHTER
	board : ARRAY2[STRING]
	grid_layout:STRING
	in_toggle_mode:BOOLEAN

	--Enemy attributes
	enemy_id : INTEGER
	enemy_table : HASH_TABLE[ENEMY,INTEGER]


	-- Random generator access feature object
	rand_access : RANDOM_GENERATOR_ACCESS

	-- Random numbers
	rand1 : INTEGER
	rand2 : INTEGER




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
				state_name := s
			end


				if cursor > 5 then
					output_msg := "  state:"+state_name +"("+success_state_counter.out+"."+error_state_counter.out+"), "+state_type+", "+state_indicate
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
			create board.make_filled ("",row,column)
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
			if cursor > 0  then
				cursor := cursor - c
			end

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
	-----------------------------------------------------------------------------------
	--ENEMY METHODS
	--Adding enemy to enemy table
	add_enemy
		do
			generate_random_number
			if rand2 >= 1 and rand2 < g_threshold then
				enemy_table.extend (create {GRUNT}.make, enemy_id)
				if attached enemy_table.item (enemy_id) as el then
					el.location := [rand1,column]
				end
				enemy_id := enemy_id + 1
			elseif rand2 >= g_threshold and rand2 < f_threshold then
				enemy_table.extend (create {FIGHTER}.make, enemy_id)
				if attached enemy_table.item (enemy_id) as el then
					el.location := [rand1,column]
				end
				enemy_id := enemy_id + 1
			elseif rand2 >= f_threshold and rand2 < c_threshold then
				enemy_table.extend (create {CARRIER}.make, enemy_id)
				if attached enemy_table.item (enemy_id) as el then
					el.location := [rand1,column]
				end
				enemy_id := enemy_id + 1
			elseif rand2 >= c_threshold and rand2 < i_threshold then
				enemy_table.extend (create {INTERCEPTOR}.make, enemy_id)
				if attached enemy_table.item (enemy_id) as el then
					el.location := [rand1,column]
				end
				enemy_id := enemy_id + 1
			elseif rand2 >= i_threshold and rand2 < p_threshold then
				enemy_table.extend (create {PYLON}.make, enemy_id)
				if attached enemy_table.item (enemy_id) as el then
					el.location := [rand1,column]
				end
				enemy_id := enemy_id + 1

			else

			end
		end




feature -- model operations

	--Displaying info and board
	display
		local
			s :STRING
		do
			create s.make_empty
			s.append ("  Starfighter:%N")
			s.append ("    [0,S]->health:"+ship.health.out+"/"+ship.health.out+", energy:"+ship.energy.out+"/"+ship.energy.out+", Regen:"+ship.h_regen.out+"/"+ship.e_regen.out+", Armour:"+ship.armour.out+", Vision:"+ship.vision.out+", Move:"+ship.move.out+", Move Cost:"+ship.move_cost.out+", location:["+row_indexes.item (ship.location.row).out+",1]%N")
			s.append ("    Projectile Pattern:"+ship.choice_selected[1].name+", Projectile Damage:"+ship.projectile_damage.out+", Projectile Cost:"+ship.projectile_cost.out+" (energy)%N")
			s.append ("    Power:Recall (50 energy): "+ship.choice_selected[4].name+"%N")
			s.append ("    score: 0")

			if in_toggle_mode then
				s.append ("  Enemy:%N")
				s.append ("  Projectile:%N")
				s.append ("  Friendly Projectile Action:%N")
				s.append ("  Enemy Projectile Action:%N")
				s.append ("  Starfighter Action:%N")
				s.append ("    The Starfighter(id:0) passes at location [E,1], doubling regen rate.%N")
				s.append ("  Enemy Action:%N")
				s.append ("  Natural Enemy Spawn:")
			end


			make_board
			s.append (grid_layout)
			set_success_output_msg (s)

		end

	make_board
		local
			fi: FORMAT_INTEGER
			vision:INTEGER
		do
			create fi.make (2)
			grid_layout := ""

			--Adding to board array
			across 1 |..| board.height as r
			loop
				across 1 |..| board.width as c
				loop
					if(ship.location.row ~ r.item and ship.location.column ~ c.item) then
							board.put ("S",r.item,c.item)
					else
						vision := ((ship.location.row-r.item).abs+(ship.location.column-c.item).abs)
						vision := vision.abs
						if (vision > ship.vision) and (not in_toggle_mode) then
							board.put ("?", r.item,c.item)
						else
							board.put ("_",r.item,c.item)
						end

					end
				end
			end

			--Adding enemy to the board
			across 1 |..| (enemy_table.count) as et
			loop
				if attached enemy_table.item (et.item) as el then
					if  in_toggle_mode or (vision < ship.vision)  then
						board.put (el.symbol,el.location.row,el.location.column)
					end
				end
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
					grid_layout.append (board.item (r.item, c.item))
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
				ship.health := ship.health + ship_array[sa.item].health
				ship.energy := ship.energy + ship_array[sa.item].energy
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
		do
			error_state_counter := 0 --Reseting error state cursor
			increment_success_state_counter
			add_enemy
			display
		end

	move(move_row:INTEGER;move_column:INTEGER)
		local
			j,k:INTEGER
		do
			error_state_counter := 0 --Reseting error state cursor
			increment_success_state_counter
			if ship.location.row < row  then
				from
					j:= ship.location.row
				until
					j > move_row
				loop

					ship.location := [j,ship.location.column]
					j:=j+1
				end

			end

				-- move up in same column
				if ship.location.row > move_row  then
					from
						j := ship.location.row
					until
						j < move_row
					loop
						ship.location := [j  , ship.location.column]
						j := j - 1
					end
				end

				-- move right in same row
				if ship.location.column < move_column then
					across
						(ship.location.column + 1) |..| (move_column)   is index
					loop
						ship.location := [ship.location.row, index]
					end
				end


				-- move left in same row
				if ship.location.column >  column then
					from
						k := ship.location.column - 1
					until
						k < move_column
					loop
							ship.location := [ship.location.row, k]
						k := k - 1
					end
				end
			add_enemy
			display

		end
	fire
		do
			error_state_counter := 0 --Reseting error state cursor
			add_enemy
			display
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
			if cursor = 0 and not (is_error or in_toggle_mode) then
				set_state_type
				set_indicate
				set_state
				Result.append(output_msg)
				Result.append("%N  Welcome to Space Defender Version 2.")

			else

				Result.append (output_msg)
				output_msg:=""
			end

		end

end




