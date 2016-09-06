/decl/psychic_faculty
	var/name
	var/list/powers = list()
	var/colour = "#FFFFFF"

/decl/psychic_faculty/New()
	. = ..()
	var/list/instantiated_powers = list()
	var/i=0
	for(var/ptype in powers)
		instantiated_powers += new ptype(src, i++)
	powers = instantiated_powers
