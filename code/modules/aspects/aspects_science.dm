/decl/aspect/science
	name = "Lab Technician"
	desc = "Don't huff from the beakers, don't stare into the laser, and don't backtalk the xenomorph. Got it."
	use_icon_state = "science_1"
	category = "Science and Research"

/decl/aspect/science/graduate
	name = "Graduate"
	desc = "You have a degree in a scientific field. Was it worth the student loans?"
	use_icon_state = "science_2"
	parent_name = "Lab Technician"

/decl/aspect/science/bio
	name = "Biologist"
	desc = "You are familiar with handling and studying all manner of life."
	use_icon_state = "science_3"
	parent_name = "Lab Technician"

/decl/aspect/science/bio/botany
	name = "Botanist"
	desc = "You know all about modifying and researching plantlife."
	use_icon_state = "science_4"
	parent_name = "Biologist"

/decl/aspect/science/arch
	name = "Archaeologist"
	desc = "You dig up ruins and speculate wildly about the results. Live the dream."
	use_icon_state = "science_5"
	parent_name = "Lab Technician"

/decl/aspect/science/doctorate
	name = "Doctorate"
	desc = "Dammit, Jim, you're a doctor AND a scientist. You have a PhD in a scientific field."
	use_icon_state = "science_6"
	parent_name = "Graduate"