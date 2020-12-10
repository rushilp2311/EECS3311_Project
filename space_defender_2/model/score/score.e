note
	description: "Summary description for {SCORE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCORE


create
	make

feature
	make
		do
			create orbments_array.make_empty
		end

feature -- attributes

	score: INTEGER
	orbments_array: ARRAY[ORBMENT]

feature -- commands

	add(orbment : ORBMENT)
	do
			if orbments_array.is_empty then
				orbments_array.force (orbment, orbments_array.count + 1)

			elseif attached {FOCUS} orbments_array[orbments_array.count] as f_obj and then not(f_obj.is_full)  then 

 				f_obj.add (orbment)
 			else

				orbments_array.force (orbment, orbments_array.count + 1)
			end
	end

	get_score : INTEGER
	do
		across
			orbments_array is o
		loop
			if attached o as orbment then
				result := result + orbment.get_score
			end
		end
	end



end
