/decl/aspect/computers
	name = "Computer Literate"
	desc = "You know how to Google keywords relating to your computer problems."
	category = "Computer Use"
	use_icon_state = "computers_1"

/decl/aspect/computers/power
	name = "Power User"
	desc = "You are more skilled than the average user, especially when it comes to damaging your own machine."
	parent_name = "Computer Literate"
	use_icon_state = "computers_2"

/decl/aspect/computers/programmer
	name = "Programmer"
	desc = "You know your way around a preprocessor. Debugging computer systems and writing software is your forte."
	parent_name = "Computer Literate"
	use_icon_state = "computers_3"

/decl/aspect/computers/compsci
	name = "Computer Scientist"
	desc = "You're well-read and widely versed in the theory and practice of computation, including advanced concepts like positronic networks and quantum computers."
	parent_name = "Programmer"
	use_icon_state = "computers_4"

/decl/aspect/computers/robopsych
	name = "Robopsychologist"
	desc = "You're practiced in understanding, communicating with and amending aberrant or damaged computer brains, including positronics."
	use_icon_state = "computers_5"
	parent_name = "Computer Scientist"

/decl/aspect/computers/signaltech
	name = "Signal Technician"
	desc = "You're trained and accredited to use and maintain bluespace and subspace-based communications technology."
	parent_name = "Programmer"
	use_icon_state = "computers_6"

/decl/aspect/computers/greyhat
	name = "Grey Hat"
	desc = "You are very skilled at bypassing computer security, and may or may not use this power for evil."
	parent_name = "Grey Hat"
	use_icon_state = "computers_7"
