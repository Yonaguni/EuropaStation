/*
	All metapsychic faculties draw on a slowly-regenerating power pool. If the power pool is drained, use of
	metapsychic power translates directly into brain damage and will rapidly kill you.
	Ranks are cumulative. Paramount Grandmasterclass powers are not available to characters in chargen
	but can proc due to latency.
*/

var/list/all_psychic_faculties = list()

/hook/startup/proc/populate_faculties()
	for(var/ptype in typesof(/decl/psychic_faculty)-/decl/psychic_faculty)
		var/decl/psychic_faculty/power = new ptype()
		all_psychic_faculties[power.name] = power
	return 1

var/list/psychic_ranks_to_strings = list(
	"Latent",
	"Operant",
	"Masterclass",
	"Grandmasterclass",
	"Paramount Grandmasterclass"
	)