
var/list/weighted_randomevent_locations = list()
var/list/weighted_mundaneevent_locations = list()

/datum/trade_destination

	var/name = ""
	var/description = ""
	var/distance = 0
	var/can_shuttle_here = 0
	var/is_a_planet

	var/list/beacon_responders = list()
	var/list/flavour_locations = list()
	var/list/blacklisted_cargo
	var/list/temp_price_change[BIOMEDICAL]
	var/list/viable_random_events = list()
	var/list/viable_mundane_events = list()

/datum/trade_destination/proc/get_custom_eventstring(var/event_type)
	return

/datum/trade_destination/proc/build_level(var/tz)
	return

// These are all either real stellar objects or fictional facilities built on real stellar objects,
// please refer to both Wikipedia and the Europa lore document before adding/removing them.
// Energy and gas mining stations around the Sun.
/datum/trade_destination/sol
	name = "Sol"
	description = "There is almost no human presence on this dense belt of Sun-blasted asteroids orbiting between \
	Sol and Mercury. The handful of constructed settlements there are deep underground, dug out by automated systems \
	and dedicated to the most top-secret and sensitive research, storage and disposal operations conducted by \
	Sol Central. A perimeter is patrolled regularly by heavily shielded naval vessels and trespassing on the Vulcanoids \
	tends to be dealt with terminally. Rumours suggest that at least a handful of the facilities orbiting Sol are also dedicated \
	computer processing stacks used by the solar government for decryption, file cracking and cryptocurrency mining."
	distance = 0
	viable_random_events = list(INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, CORPORATE_ATTACK, AI_LIBERATION, SECURITY_BREACH)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, RESIGNATION)
	is_a_planet = 1
	flavour_locations = list(
		"the Daystar Energy Chain",
		"the Vulcanoids"
		)

/datum/trade_destination/sol/build_level(var/tz)
	new /datum/random_map/automata/asteroids/superheated(null, 1, 1, tz, 255, 255)

/datum/trade_destination/mercury
	name = "Mercury"
	description = "Due to its stable and unique rotational period, tremendously hostile conditions, and huge exploitable solar power \
	potential, Mercury is the single largest and oldest automated factory hub in human space. Much of the output of the colossal factory \
	complexes is shunted into orbit for use in the construction of new capital ships and orbital habitats in the rest of the system."
	distance = 0.3
	is_a_planet = 1
	viable_random_events = list(RIOTS, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, AI_LIBERATION, MOURNING, CULT_CELL_REVEALED, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, SONG_DEBUT, MOVIE_RELEASE, BIG_GAME_HUNTERS, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)
	flavour_locations = list(
		"the public docks",
		"the Caduceus listening post"
		)

/datum/trade_destination/mercury/build_level(var/tz)
	new /datum/random_map/automata/asteroids/superheated(null, 1, 1, tz, 255, 255)

/datum/trade_destination/venus
	name = "Venus"
	is_a_planet = 1
	description = "After the success of the Martian terraforming project, the conglomerate responsible set their sights on Venus. \
	With arable land at a premium and huge volumes of money and raw materials flooding the industrial markets thanks to the asteroid \
	mining operations near Mercury, it was feasible to begin work on the significantly more complex problem of reducing the Venusian \
	surface temperature and making the atmosphere compatible with human life. Many are considering the ongoing project, which has been \
	running for approaching six decades, a test run for using the currently experimental technologies to restore the devastated \
	ecosphere of Earth to a better state."
	distance = 0.7
	viable_random_events = list(RIOTS, WILD_ANIMAL_ATTACK, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, ALIEN_RAIDERS, MOURNING, CULT_CELL_REVEALED, ANIMAL_RIGHTS_RAID, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, BIG_GAME_HUNTERS, ELECTION, GOSSIP, TOURISM, RESIGNATION)
	flavour_locations = list(
		"the public docks",
		"the Venusian Terraforming Project",
		"the Sol Institute of Planetary Science",
		"Neith"
		)

/datum/trade_destination/venus/build_level(var/tz)
	new /datum/random_map/automata/asteroids(null, 1, 1, tz, 255, 255)

// Cradle of Humanity, warpgate coordination facility, corp central.
/datum/trade_destination/earth
	name = "Earth"
	is_a_planet = 1
	description = "The period between achieving spaceflight and the unification of Sol was not kind to the birthplace \
	of Humanity. Earth is now a desolate, war-torn shell, populated by teeming billions of poor and downtrodden people \
	unable to afford the excessive cost of getting into orbit and into the rest of the system. Earth is fiercely independant \
	of the Sol union and rejects the authority of Mars, serving the Lunar corporations as a kind of tax haven and city-state combined."
	distance = 1
	viable_random_events = list(RIOTS, WILD_ANIMAL_ATTACK, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, AI_LIBERATION, MOURNING, ANIMAL_RIGHTS_RAID, FESTIVAL)
	viable_mundane_events = list(BIG_GAME_HUNTERS, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)

	flavour_locations = list(
		"Luna",
		"the public docks",
		"the corporate docks"
		)

/datum/trade_destination/earth/build_level(var/tz)
	new /datum/random_map/automata/asteroids/debris(null, 1, 1, tz, 255, 255)

// Capitol of Sol.
/datum/trade_destination/mars
	name = "Mars"
	description = "During the initial phases of the expansion from Earth, Mars was earmarked as an agricultural food basket for the \
	fledgeling Sol Central territory. The terraforming project was hugely expensive, financed both by Sol Central and the new-formed \
	Free Trade Union corporate conglomerate, and took over a century to change the desolate planet to a point that humans could survive \
	outside of radiation-shielded domes. These days, Mars is the official capitol of Sol, boasting a population of six billion people \
	living in the dome cities, and huge shipbuilding and administration facilities sailing above in orbit. The chief export is biomass; \
	Mars is still one of the only planets in the solar system capable of supporting mass industrial farming."
	is_a_planet = 1
	distance = 1.5
	viable_random_events = list(RIOTS, WILD_ANIMAL_ATTACK, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, CORPORATE_ATTACK, AI_LIBERATION, MOURNING, CULT_CELL_REVEALED, ANIMAL_RIGHTS_RAID, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, SONG_DEBUT, MOVIE_RELEASE, BIG_GAME_HUNTERS, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)

	flavour_locations = list(
		"Phobos",
		"Deimos",
		"the public docks",
		"the corporate docks"
		)

/datum/trade_destination/mars/build_level(var/tz)
	new /datum/random_map/automata/asteroids/debris(null, 1, 1, tz, 255, 255)

// Asteroid belt.
/datum/trade_destination/asteroids
	name = "the Halo asteroid belt"
	description = "The metal-rich asteroids of the system's inner ring were the Holy Grail of the initial expansion from Earth. The factories \
	and habitats in the Halo predate the system government in many places, and their output of metals, minerals and water fuel the industries of \
	most of the other planets and stations short of the Kuiper Belt. The Halo facilities were instrumental in providing the ice asteroids used \
	to terraform Mars, and many of the dynasties ruling swathes of the belt owe their fortunes to the mad scramble for farmland that came with \
	human expansion from Earth."
	distance = 3.2
	viable_random_events = list(RIOTS, WILD_ANIMAL_ATTACK, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, ALIEN_RAIDERS, AI_LIBERATION, MOURNING, CULT_CELL_REVEALED, SECURITY_BREACH, ANIMAL_RIGHTS_RAID, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, SONG_DEBUT, MOVIE_RELEASE, BIG_GAME_HUNTERS, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)
	flavour_locations = list(
		"Ceres",
		"Vesta",
		"Pallas",
		"Hygiea",
		"the Gefion family",
		"434 Hungaria",
		"the Phocaea family",
		"the Karin cluster"
		)

/datum/trade_destination/asteroids/build_level(var/tz)
	new /datum/random_map/automata/asteroids(null, 1, 1, tz, 255, 255)

/datum/trade_destination/jupiter
	name = "Jupiter"
	description = "The high demand for hydrogen and helium-derived fuel during the initial phases of human expansion to other planets \
	caused Jupiter's mining corporations to skyrocket in power and influence. These days Jupiter has been eclipsed by the booming HE3 \
	trade, but it is still a hub for mining and fabrication conglomerates without the cash to establish themselves in the Kuiper Belt."
	is_a_planet = 1
	distance = 5.2
	viable_random_events = list(RIOTS, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, ALIEN_RAIDERS, AI_LIBERATION, MOURNING, CULT_CELL_REVEALED, SECURITY_BREACH, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, SONG_DEBUT, MOVIE_RELEASE, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)
	flavour_locations = list(
		"the public docks",
		"the corporate docks",
		"the Jovian Naval docks",
		"Callisto",
		"Io",
		"Ganymede"
		)

/datum/trade_destination/jupiter/build_level(var/tz)
	new /datum/random_map/automata/asteroids/debris(null, 1, 1, tz, 255, 255)

/datum/trade_destination/europa
	name = "Europa"
	is_a_planet = 1
	description = "One of the more uninteresting moons in Jupiter's vast swathe of satellites, Europa underwent several abortive \
	and abandoned colonization attempts, most famously the Yonaguni disaster that resulted in the collapse of several colony domes \
	and the lonely deaths of thousands of people. So-far unexplained signal disturbances render the moon far more remote than mere \
	distance would account for, but a handful of colonists and corporate research bodies still inhabit the desolate place."
	// Europa is spookily out of touch and the base for the game, so no events should proc using it.
	viable_random_events = list()
	viable_mundane_events = list()

/datum/trade_destination/europa/build_level(var/tz)
	new /datum/random_map/automata/asteroids/debris/strange(null, 1, 1, tz, 255, 255)

/datum/trade_destination/saturn
	name = "Saturn"
	is_a_planet = 1
	description = "ecological store (seeds, flora, fauna, dna) in case of Martian collapse, colony and farm world, moons heavily populated, \
	largest population hub and second largest cultural hub in Sol after Mars."
	distance = 9.5
	viable_random_events = list(RIOTS, WILD_ANIMAL_ATTACK, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, ALIEN_RAIDERS, AI_LIBERATION, MOURNING, CULT_CELL_REVEALED, SECURITY_BREACH, ANIMAL_RIGHTS_RAID, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, SONG_DEBUT, MOVIE_RELEASE, BIG_GAME_HUNTERS, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)
	flavour_locations = list(
		"the public docks",
		"the private docks",
		"Titan",
		"Pan",
		"Daphnis",
		"Atlas",
		"Prometheus",
		"Pandora"
		)

/datum/trade_destination/saturn/build_level(var/tz)
	new /datum/random_map/automata/asteroids/debris(null, 1, 1, tz, 255, 255)

/datum/trade_destination/uranus
	name = "Uranus"
	description = "Largely unimportant in terms of resource exploitiation and uninteresting for civilian uses, Uranus was claimed by \
	the Sol government shortly after it became economically feasible to construct orbital facilities there. The orbit of this ice giant \
	rapidly became host to immense amounts of habitat modules, maintenance shipyards and naval bases. Today, Uranus is called 'The \
	barracks of Sol', as most of the system fleet is housed there; the orbital habitats are predominantly populated by naval officers, \
	shipmen, marines and their families."
	is_a_planet = 1
	distance = 19
	viable_random_events = list(RIOTS, WILD_ANIMAL_ATTACK, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, ALIEN_RAIDERS, AI_LIBERATION, MOURNING, CULT_CELL_REVEALED, SECURITY_BREACH, ANIMAL_RIGHTS_RAID, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, SONG_DEBUT, MOVIE_RELEASE, BIG_GAME_HUNTERS, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)
	flavour_locations = list(
		"the public docks",
		"the private docks",
		"Miranda",
		"Ariel",
		"Umbriel",
		"Titania",
		"Oberon"
		)

/datum/trade_destination/uranus/build_level(var/tz)
	new /datum/random_map/automata/asteroids/debris(null, 1, 1, tz, 255, 255)

/datum/trade_destination/neptune
	name = "Neptune"
	is_a_planet = 1
	description = "???"
	distance = 30
	viable_random_events = list()
	viable_mundane_events = list()
	flavour_locations = list(
		"the public docks",
		"the private docks",
		"Triton",
		"Phoebe"
		)

/datum/trade_destination/neptune/build_level(var/tz)
	new /datum/random_map/automata/asteroids/debris(null, 1, 1, tz, 255, 255)

// Kuiper belt
/datum/trade_destination/kuiperbelt
	name = "the Kuiper Belt"
	description = "The Kuiper Belt was considered far too remote for habitation for many decades during the push outwards \
	from Earth. With modern ship technology and habitat constructiont techniques, the Belt has become the de facto location for \
	independant industrialists, corporate facilities and those who wish to strike it rich on a frontier that is both less remote \
	than the Oort cloud and less regimented and controlled than the inner-system Halo. Piracy and criminal enterprise are \
	significant problems in the Belt, and most corporations maintain their own armed envoys rather than trusting to the scattered \
	Sol Central naval presence."
	distance = 43
	viable_random_events = list(RIOTS, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, ALIEN_RAIDERS, AI_LIBERATION, MOURNING, CULT_CELL_REVEALED, SECURITY_BREACH, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, SONG_DEBUT, MOVIE_RELEASE, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)
	flavour_locations = list(
		"the ruins of Pluto",
		"Charon",
		"2003 UB",
		"1992 QB1",
		"Orcus",
		"Quaoar",
		"Ixion",
		"Varuna"
		)

/datum/trade_destination/kuiperbelt/build_level(var/tz)
	new /datum/random_map/automata/asteroids(null, 1, 1, tz, 255, 255)

// Furthest extreme of the Solar System.
/datum/trade_destination/oort
	name = "the Oort cloud"
	description = "A former battleground of the Sol Militia and pirates and a haven for water and ice production, the Oort \
	Cloud has lost some of its importance as material synthesis technology and growing economies in the inner system make raw materials \
	unnecessary. Today, the masses of tiny stations, industrial, military or illegal, are occupied by spacer nomads and the SolGov military. \
	The Cloud is heavily fortified with fortress stations as first line of defense against any hostile incursions from the interstellar gulf. \
	Many of the fortresses were established hundreds of years ago, and in modern times a naval posting to the Oort Cloud is considered either \
	something done to put a retiring soldier out to pasture, or a punishment for an uppity officer."
	distance = 2000 // See New().
	viable_random_events = list(WARSHIPS_ARRIVE, PIRATES, ALIEN_RAIDERS, CULT_CELL_REVEALED)
	viable_mundane_events = list(CELEBRITY_DEATH, RESIGNATION)
	flavour_locations = list(
		"Eris",
		"Dysnomia",
		"Hyakutake-2",
		"Hale-Bopp-54",
		"Sedna",
		"2006 SQ372",
		"2008 KV42",
		"2000 CR105"
		)

/datum/trade_destination/oort/build_level(var/tz)
	new /datum/random_map/automata/asteroids/distant(null, 1, 1, tz, 255, 255)

/datum/trade_destination/oort/New()
	..()
	distance = rand(1000,100000)