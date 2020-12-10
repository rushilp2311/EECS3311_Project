note
	description: "Summary description for {PLATINUM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLATINUM

inherit
	FOCUS

create
	make

feature

	make

		do
			create array.make_empty
			max_size := 3
			array.force (create {BRONZE}.make, 1)

		end

feature
	max_size: INTEGER

feature


	is_full: BOOLEAN
	do
		if array.count < 3 then
			result := false
		elseif array.count = 3 and not (attached {FOCUS} array[3]) then
			result := true
		else
			if attached{FOCUS} array[3] as focus_object then
				result := focus_object.is_full
			end
		end
	end

	add(orbment : ORBMENT)
	do
		if not attached {FOCUS} array[array.count] then
			array.force (orbment, array.count + 1)
		elseif attached {FOCUS} array[array.count] as focus_object and then not(focus_object.is_full) then
			focus_object.add (orbment)
		else
			array.force (orbment, array.count + 1)

		end
	end

	get_score : INTEGER
	do
		across
			array is o
		loop
			if attached o as orbment then
				result := result + orbment.get_score
			end
		end
		if array.count = 3 then
			result := result*2
		end

	end


end
