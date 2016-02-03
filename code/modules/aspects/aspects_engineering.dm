/decl/aspect/technical
	name = "Technically Skilled"
	desc = "You've got a knack for the fiddly stuff."
	use_icon_state = "engineering_1"
	category = "Technical Disciplines"

/decl/aspect/technical/engine
	name = "Engine Maintenance"
	desc = "You're familiar with the use and operation of combustion engines, thermal-electric generators, and supermatter reactors."
	parent_name = "Technically Skilled"
	use_icon_state = "engineering_2"

/decl/aspect/technical/engineer
	name = "Structural Engineer"
	desc = "You know how to build things and keep them standing."
	parent_name = "Technically Skilled"
	use_icon_state = "engineering_6"

/decl/aspect/technical/engineer/exotic
	name = "Exotic Materials"
	desc = "You know how to build with things like uranium, diamond or phoron. Weirdo."
	parent_name = "Structural Engineer"
	use_icon_state = "engineering_7"

/decl/aspect/technical/engineer/degree
	name = "Degree (Engineering)"
	desc = "You have an actual, honest-to-God degree in an engineering field."
	parent_name = "Structural Engineer"
	use_icon_state = "engineering_8"

/decl/aspect/technical/electrical
	name = "Electrical Engineering"
	desc = "You know more than most people about electricity. Can you smell something burning?"
	parent_name = "Technically Skilled"
	use_icon_state = "engineering_9"

/decl/aspect/technical/complex
	name = "Complex Devices"
	desc = "You can build and maintain all kinds of fiddly electronics."
	parent_name = "Electrical Engineering"
	use_icon_state = "engineering_10"

/decl/aspect/technical/electrical/exo
	name = "Exosuit Technician"
	desc = "This mech of yours shines with an awesome power!"
	parent_name = "Electrical Engineering"
	use_icon_state = "engineering_11"

/decl/aspect/technical/electrical/robo
	name = "Roboticist"
	desc = "You know how to build and repair prosthetics and robots, as well as interface them with squishy meat-bits."
	parent_name = "Electrical Engineering"
	use_icon_state = "engineering_12"


