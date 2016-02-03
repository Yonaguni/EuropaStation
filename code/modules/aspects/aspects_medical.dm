/decl/aspect/medical
	name = "First Aid Training"
	desc = "You have formal training in administering CPR, proper use of basic chemicals, and a piece of paper saying you're unlikely to kill anyone."
	use_icon_state = "medical_1"
	category = "Medicine"

/decl/aspect/medical/trained
	name = "Medical School"
	desc = "You went to an actual medical school for actual doctors. You know how to diagnose complex illnesses and injuries, and hopefully how to treat them."
	use_icon_state = "medical_2"

/decl/aspect/medical/trained/surgeon
	name = "Surgeon"
	desc = "You know how to cut people up, fix their insides and get them back on their feet."
	parent_name = "Medical School"
	use_icon_state = "medical_3"

/decl/aspect/medical/emt
	name = "First Responder"
	desc = "You've been doing this for years. You can be at someone's house with a hot cocoa in hand before they realize they've gone into cardiac arrest."
	parent_name = "First Aid Training"
	use_icon_state = "medical_4"

/decl/aspect/medical/chemist
	name = "Pharmacologist"
	desc = "You know how to produce and use all manner of strange chemicals, nominally for the purposes of keeping people alive and functional."
	use_icon_state = "medical_5"

/decl/aspect/medical/surgeon_field
	name = "Field Surgeon"
	desc = "You may not have gone to medical school, but you can still splint a broken leg with a length of rebar and some duct tape."
	use_icon_state = "medical_6"