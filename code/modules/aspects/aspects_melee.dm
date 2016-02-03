/decl/aspect/melee
	name = "Brawler"
	desc = "You are an expert at hitting them where it hurts with fists and boots."
	use_icon_state = "melee_2"
	category = "Close Combat"

/decl/aspect/melee/brawler
	name = "Wrestler"
	desc = "You know exactly how to grab, pin or throw another person like a sack of potatoes."
	parent_name = "Brawler"
	use_icon_state = "melee_3"

/decl/aspect/melee/brawler/adaptable
	name = "Adaptable"
	desc = "Seize the day! Smash their head into a convenient window! Maybe slam them into a table. You're good at on-the-fly combat."
	parent_name = "Brawler"
	use_icon_state = "melee_3"

/decl/aspect/melee/weapon
	name = "Armed"
	desc = "You are right at home with the use of weapons. Calm down, Zakalwe."
	use_icon_state = "melee_4"

/decl/aspect/melee/weapon/edged
	name = "Duelist"
	desc = "You are skilled with a sword, and very good at sticking them with the pointy end."
	parent_name = "Armed"
	use_icon_state = "melee_5"

/decl/aspect/melee/weapon/blunt
	name = "Bludgeoner"
	desc = "If it's heavy enough to crack a skull and narrow enough to hold, you're at home using it to beat someone."
	parent_name = "Armed"
	use_icon_state = "melee_6"

/decl/aspect/melee/weapon/improvised
	name = "Improvised"
	desc = "Anything can be a weapon if you use enough duct tape."
	parent_name = "Armed"
	use_icon_state = "melee_7"

/decl/aspect/melee/weapon/exotic
	name = "Exotic"
	desc = "Energy blades and other, stranger, weapons are your forte."
	parent_name = "Armed"
	use_icon_state = "melee_8"
