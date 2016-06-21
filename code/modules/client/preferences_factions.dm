var/global/list/seen_citizenships = list()
var/global/list/seen_systems = list()
var/global/list/seen_factions = list()
var/global/list/seen_religions = list()

//Commenting this out for now until I work the lists it into the event generator/journalist/chaplain.
/proc/UpdateFactionList(mob/living/human/M)
	/*if(M && M.client && M.client.prefs)
		seen_citizenships |= M.client.prefs.citizenship
		seen_systems      |= M.client.prefs.home_system
		seen_factions     |= M.client.prefs.faction
		seen_religions    |= M.client.prefs.religion*/
	return

var/global/list/citizenship_choices = list(
	"Europan",
	"Terran",
	"Lunar",
	"Martian",
	"Qerrbalak"
	)

var/global/list/home_system_choices = list(
	"Mercury",
	"Venus",
	"Earth",
	"Luna",
	"Mars",
	"Jupiter",
	"Saturn",
	"Uranus",
	"Neptune"
	)

var/global/list/faction_choices = list(
	"Sol Central",
	"Jovian Navy",
	"Free Trade Union"
	)

var/global/list/religion_choices = list(
	"Hinduism",
	"Buddhist",
	"Islamic",
	"Christian",
	"Pagan",
	"Agnostic",
	"Deist"
	)