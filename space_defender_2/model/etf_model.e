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
			create state_name.make_empty
			create state_type.make_empty
			create state_indicate.make_empty
			create error.make
			create output_msg.make_empty
			create setup_array.make_empty
			create state_items.make(7)
			create ship.make
			create ship_array.make_empty
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
	ship:STARFIGHTER


feature --utility operations


	--setters

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




	set_indicate
		do
			if is_error then
				state_indicate := "error"
			else
				state_indicate := "ok"
			end

		end

	set_state_type
		do
			state_type := "normal"
		end
	set_state
		do
			if attached state_items.item (cursor) as s  then
				state_name := s
			end

			output_msg := "  state:"+state_name +", "+state_type+", "+state_indicate
		end

	set_success_output_msg(s:STRING)
		do
			output_msg.make_empty
			set_state_type
				set_indicate
				set_state
			output_msg.append ("%N"+s)
		end
	set_error_output_msg(s:STRING)
		do
			set_state_type
			set_indicate
			set_state
			output_msg.append ("%N  "+s)
		end

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

	set_parameters(r:INTEGER; c:INTEGER; n1:INTEGER; n2:INTEGER; n3:INTEGER; n4:INTEGER; n5:INTEGER)
		do
			row := r
			column := c
			g_threshold := n1
			f_threshold := n2
			c_threshold := n3
			i_threshold := n4
			p_threshold := n5
		end
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





feature -- model operations

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

			end
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
			if cursor = 0 then
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




