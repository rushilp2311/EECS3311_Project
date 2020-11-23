note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVE
inherit
	ETF_MOVE_INTERFACE
create
	make
feature -- command
	move(row: INTEGER_32 ; column: INTEGER_32)
		require else
			move_precond(row, column)
		local
			move_row:INTEGER_32
			valid_move:INTEGER_32
			valid_row:INTEGER_32
			valid_col:INTEGER_32
    	do
			-- perform some update on the model state
			if model.in_setup then
				if model.is_error = false then
					model.toggle_is_error
				end
				model.set_error_output_msg (model.error.play_in_setup)
			elseif (not model.in_game) then
				if model.is_error = false then
					model.toggle_is_error
				end
				model.set_error_output_msg (model.error.play_in_game)
			else
				--ADD OTHER CONDITIONS FOR MOVE


				move_row := 0

				if
					row = A
				then
					move_row:=1
				end
				if
					row = B
				then
					move_row:=2
				end
				if
					row = C
				then
					move_row:=3
				end
				if
					row = D
				then
					move_row:=4
				end
				if
					row = E
				then
					move_row:=5
				end
				if
					row = F
				then
					move_row:=6
				end
				if
					row = G
				then
					move_row:=7
				end
				if
					row = H
				then
					move_row:=8
				end
				if
					row = I
				then
					move_row:=9
				end
				if
					row = J
				then
					move_row:=10
				end

				if move_row = 0 or column > model.board.width then
					model.increment_error_state_counter
					model.set_error_output_msg (model.error.move_outside_board)
				else
						valid_row := (move_row - model.ship.location.row)
						valid_col := (column - model.ship.location.column)
						valid_move := valid_row.abs + valid_col.abs
						if valid_move.abs > model.ship.move then
							model.increment_error_state_counter
							model.set_error_output_msg (model.error.move_outside_range)
						else
							if move_row = model.ship.location.row and column = model.ship.location.column then
										model.increment_error_state_counter
										model.set_error_output_msg (model.error.move_same_location)
							else
								if model.is_error = true then
									model.toggle_is_error
								end
								model.move(move_row,column)
							end
						end

				end






			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
