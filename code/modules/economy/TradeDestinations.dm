
var/list/weighted_randomevent_locations = list()
var/list/weighted_mundaneevent_locations = list()

/datum/trade_destination
	var/name = ""
	var/description = ""
	var/distance = 0
	var/list/willing_to_buy = list()
	var/list/willing_to_sell = list()
	var/can_shuttle_here = 0		//one day crew from the exodus will be able to travel to this destination
	var/list/viable_random_events = list()
	var/list/temp_price_change[BIOMEDICAL]
	var/list/viable_mundane_events = list()

/datum/trade_destination/proc/get_custom_eventstring(var/event_type)
	return null

/*
Some notes on regions and factions.

The inner system
  Capitol:    Mars.
  Territory:  Mercury, Venus, Mars, the Halo, Jupiter.
  Government: Sol Central
  Population: 16 billion people.
  Imports:    Metals, data.
  Exports:    Energy, ships, habitats, food.
  Industries: Agriculture, ship and habitat fabrication, terraforming.

The Terran State
  Capitol:    Luna.
  Territory:  Earth, Luna.
  Government: Lunar Council
  Population: 9 billion people.
  Imports:    Food, energy, metals.
  Exports:    Data. mercenaries.
  Industries: Data brokering, piracy, tax havens, banking, business interests, tourism, warpgate tariffs.

The outer rim
  Capitol:    Saturn
  Territory:  Saturn, Uranus, Neptune.
  Government: Sol Central
  Population: 60 million people.
  Imports:    Food, energy, ships and habitats.
  Exports:    Metal, materials, specialist personnel and training.
  Industries: Mass fabrication, mining and refinment, fuel production.

The frontier
  Capitol:    None.
  Territory:  The Kuiper Belt.
  Government: No central authority.
  Population: Unclear, no more than several million permanent residents.
  Imports:    People, food and materials.
  Exports:    Exciting stories, corpses, excuses for Sol naval exercises.
  Industries: Mining, research, criminal enterprise

Wilderness
  Capitol:    Effectively Eris.
  Territory:  The Oort cloud.
  Government: No central authority.
  Population: Unclear.
  Imports:    People, food and materials.
  Exports:    Very little.
  Industries: Getting lost, starving, hiding from the space cops.
*/

// Energy and gas mining stations around the Sun.
/datum/trade_destination/sol
	name = "The Vulcanoids"
	description = "There is almost no human presence on this dense belt of Sun-blasted asteroids orbiting between \
	Sol and Mercury. The handful of constructed settlements there are deep underground, dug out by automated systems \
	and dedicated to the most top-secret and sensitive research, storage and disposal operations conducted by \
	Sol Central. A perimeter is patrolled regularly by heavily shielded naval vessels and trespassing on the Vulcanoids \
	tends to be dealt with terminally. Rumours suggest that at least a handful of the Vulcanoids are also dedicated \
	computer processing stacks used by Sol for decryption, file cracking and cryptocurrency mining."
	distance = 0
	viable_random_events = list(INDUSTRIAL_ACCIDENT, CORPORATE_ATTACK, AI_LIBERATION, SECURITY_BREACH)

/datum/trade_destination/sol/daystar
	name = "Daystar Energy chain"
	description = "A dense chain of heavily shielded automated stations are clustered around the Sun, serving as an 'energy mining' \
	operation that converts solar energy into a usable form, then shunts it to other portions of the system either by coordinated \
	masers or huge shipments of batteries. Human presence on these stations is minimal and generally restricted to shifts of workers \
	who are only woken from cryogenic storage for emergency maintenance tasks; positions on the ring are extremely taxing and correspondingly \
	extremely well-paid."
	viable_random_events = list(INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, CORPORATE_ATTACK, AI_LIBERATION, SECURITY_BREACH)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, RESIGNATION)

/datum/trade_destination/mercury
	name = "Mercury"
	description = "Due to its stable and unique rotational period, tremendously hostile conditions, and huge exploitable solar power \
	potential, Mercury is the single largest and oldest automated factory hub in human space. Much of the output of the colossal factory \
	complexes is shunted into orbit for use in the construction of new capital ships and orbital habitats in the rest of the system."
	distance = 0.3
	viable_random_events = list(RIOTS, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, AI_LIBERATION, MOURNING, CULT_CELL_REVEALED, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, SONG_DEBUT, MOVIE_RELEASE, BIG_GAME_HUNTERS, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)

/datum/trade_destination/mercury/caduceus
	name = "Caduceus Listening Post"
	description = "Named for an ancient practical joke, the Caduceus listening post is a government-run facility positioned in Mercury's \
	solar shadow. The purpose of the facility is to monitor signals supposedly received from deep within the corona in the late 2200's, \
	but in practice it is considered a joke posting used to punish those that Sol's internal administration has some kind of displeasure \
	with."
	viable_random_events = list(INDUSTRIAL_ACCIDENT, WARSHIPS_ARRIVE, AI_LIBERATION, SECURITY_BREACH)
	viable_mundane_events = list(RESIGNATION)

/datum/trade_destination/venus
	name = "Venus"
	description = "After the success of the Martian terraforming project, the conglomerate responsible set their sights on Venus. \
	With arable land at a premium and huge volumes of money and raw materials flooding the industrial markets thanks to the asteroid \
	mining operations near Mercury, it was feasible to begin work on the significantly more complex problem of reducing the Venusian \
	surface temperature and making the atmosphere compatible with human life. Many are considering the ongoing project, which has been \
	running for approaching six decades, a test run for using the currently experimental technologies to restore the devastated \
	ecosphere of Earth to a better state."
	distance = 0.7
	viable_random_events = list(RIOTS, WILD_ANIMAL_ATTACK, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, ALIEN_RAIDERS, MOURNING, CULT_CELL_REVEALED, ANIMAL_RIGHTS_RAID, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, BIG_GAME_HUNTERS, ELECTION, GOSSIP, TOURISM, RESIGNATION)

/datum/trade_destination/venus/neith
	name = "Neith"
	description = "Named for the mythical moon of Venus, Neith is a large and complex facility constructed in and on the repositioned \
	and repurposed quasi-satellite 2002 VE68. It is a corporate-run spaceport and home to the Venusian Terraforming Project and Sol \
	Institute of Planetary Science, which both research and apply techniques for terraforming and planetary engineering. Neith is \
	probably the most highly-regarded hub of scientific research and cosmological understanding in Sol."

// Cradle of Humanity, warpgate coordination facility, corp central.
/datum/trade_destination/earth
	name = "Earth"
	description = "The period between achieving spaceflight and the unification of Sol was not kind to the birthplace \
	of Humanity. Earth is now a desolate, war-torn shell, populated by teeming billions of poor and downtrodden people \
	unable to afford the excessive cost of getting into orbit and into the rest of the system. Earth is fiercely independant \
	of the Sol union and rejects the authority of Mars, serving the Lunar corporations as a kind of tax haven and city-state combined."
	distance = 1
	viable_random_events = list(RIOTS, WILD_ANIMAL_ATTACK, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, AI_LIBERATION, MOURNING, ANIMAL_RIGHTS_RAID, FESTIVAL)
	viable_mundane_events = list(BIG_GAME_HUNTERS, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)

/datum/trade_destination/earth/luna
	name = "Luna"
	description = "By contrast to her sovereign planet, Luna is a gleaming jewel in the crown of Sol. Vast quantities of power and \
	money reside in the cities constructed all across the Lunar surface, and it also hosts the corporate warpgate control complex \
	linking Sol to the rest of the Galaxy. While it is nominally part of the Sol stellar territory, corporate power on the moon \
	easily outclasses the government, making it a playground for the hyper-rich and not an easy place to live for anyone else. Luna \
	also administrates travel to and from the desolate surface of Earth."
	viable_random_events = list(RIOTS, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, ALIEN_RAIDERS, AI_LIBERATION, MOURNING, CULT_CELL_REVEALED, SECURITY_BREACH, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, SONG_DEBUT, MOVIE_RELEASE, BIG_GAME_HUNTERS, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)

// Capitol of Sol.
/datum/trade_destination/mars
	name = "Mars"
	description = "During the initial phases of the expansion from Earth, Mars was earmarked as an agricultural food basket for the \
	fledgeling Sol Central territory. The terraforming project was hugely expensive, financed both by Sol Central and the new-formed \
	Free Trade Union corporate conglomerate, and took over a century to change the desolate planet to a point that humans could survive \
	outside of radiation-shielded domes. These days, Mars is the official capitol of Sol, boasting a population of six billion people \
	living in the dome cities, and huge shipbuilding and administration facilities sailing above in orbit. The chief export is biomass; \
	Mars is still one of the only planets in the solar system capable of supporting mass industrial farming."
	distance = 1.5
	viable_random_events = list(RIOTS, WILD_ANIMAL_ATTACK, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, CORPORATE_ATTACK, AI_LIBERATION, MOURNING, CULT_CELL_REVEALED, ANIMAL_RIGHTS_RAID, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, SONG_DEBUT, MOVIE_RELEASE, BIG_GAME_HUNTERS, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)

/datum/trade_destination/mars/phobos
	name = "Phobos"
	description = "Phobos is a shipbuilding and advanced naval system research and fabrication hub with mixed corporate \
	and government presences. Significant portions of the moon's surface are dedicated to naval facilities, both for ship \
	production and personnel training. During the settlement of Mars, Phobos was also the coordinating hub for colony activities, \
	directing the terraforming project established on its sister moon, Deimos. The moon has a markedly poor reputation with Sol \
	military personnel, who have often publically stated that getting a posting there is like 'Hell on Earth' due to hostile conditions \
	and demanding surprise military exercises."
	viable_random_events = list(RIOTS, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, ALIEN_RAIDERS, AI_LIBERATION, MOURNING, CULT_CELL_REVEALED, SECURITY_BREACH, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)

/datum/trade_destination/mars/deimos
	name = "Deimos"
	description = "Deimos was the muscle of the Martian terraforming project; the machinery used to alter the atmosphere and direct ice \
	asteroids into strategic areas of the planet is still in operation today, but now serves primarily as a mechanism for regulating the \
	planet's rather rambunctious weather systems. The rest of the moon is the property of Sol Central and serves as the bureaucratic and \
	administrative seat for Mars, and by extension the rest of the solar system."
	viable_random_events = list(RIOTS, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, ALIEN_RAIDERS, AI_LIBERATION, MOURNING, CULT_CELL_REVEALED, SECURITY_BREACH, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)

/datum/trade_destination/ceres
	name = "Ceres"
	description = "Due to being unsuitable for settlement, devoid of any immediately easily exploitable resources, and largely unfit for \
	human habitation, huge portions of Ceres were unceremoniously auctioned off by the Department of Planetary Exploitation during the late \
	stages of human expansion, resulting in it becoming an industrial chemical synthesis hub.Environmental restrictions on industrial \
	processes on the dwarf planet were largely removed, apparently due to the idea that it would be hard to make the place any worse. \
	These days, Ceres is effectively the industrial administration hub of Sol."
	distance = 2.7
	viable_random_events = list(INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, ALIEN_RAIDERS, MOURNING, CULT_CELL_REVEALED, SECURITY_BREACH, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)

// Asteroid belt.
/datum/trade_destination/asteroids
	name = "Halo asteroid belt"
	description = "The metal-rich asteroids of the system's inner ring were the Holy Grail of the initial expansion from Earth. The factories \
	and habitats in the Halo predate the system government in many places, and their output of metals, minerals and water fuel the industries of \
	most of the other planets and stations short of the Kuiper Belt. The Halo facilities were instrumental in providing the ice asteroids used \
	to terraform Mars, and many of the dynasties ruling swathes of the belt owe their fortunes to the mad scramble for farmland that came with \
	human expansion from Earth."
	distance = 3.2
	viable_random_events = list(RIOTS, WILD_ANIMAL_ATTACK, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, ALIEN_RAIDERS, AI_LIBERATION, MOURNING, CULT_CELL_REVEALED, SECURITY_BREACH, ANIMAL_RIGHTS_RAID, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, SONG_DEBUT, MOVIE_RELEASE, BIG_GAME_HUNTERS, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)

/datum/trade_destination/jupiter
	name = "Jupiter"
	description = "The high demand for hydrogen and helium-derived fuel during the initial phases of human expansion to other planets \
	caused Jupiter's mining corporations to skyrocket in power and influence. These days Jupiter has been eclipsed by the booming HE3 \
	trade, but it is still a hub for mining and fabrication conglomerates without the cash to establish themselves in the Kuiper Belt."
	distance = 5.2
	viable_random_events = list(RIOTS, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, ALIEN_RAIDERS, AI_LIBERATION, MOURNING, CULT_CELL_REVEALED, SECURITY_BREACH, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, SONG_DEBUT, MOVIE_RELEASE, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)

/datum/trade_destination/jupiter/europa
	name = "Europa"
	description = "One of the more uninteresting moons in Jupiter's vast swathe of satellites, Europa underwent several abortive \
	and abandoned colonization attempts, most famously the Yonaguni disaster that resulted in the collapse of several colony domes \
	and the lonely deaths of thousands of people. So-far unexplained signal disturbances render the moon far more remote than mere \
	distance would account for, but a handful of colonists and corporate research bodies still inhabit the desolate place."
	// Europa is spookily out of touch and the base for the game, so no events should proc using it.
	viable_random_events = list()
	viable_mundane_events = list()

/datum/trade_destination/jupiter/ganymede
	name = "Ganymede"
	description = "Due to its size and magnetosphere, Ganymede came to house the majority of the facilities constructed during \
	Jupiter's explotiation. The abundant water and silicates, combined with geologically stability, made it an ideal base of operations \
	for the fuel refining companies and their workers. Much of Jupiter's bounty was packaged and shipped from Ganymede, and it rapidly \
	gained a relatively huge population despite significant population and capital loss following a fuel crash towards the end of human \
	expansion. Ganymede is still home to millions of people, facilities and data havens, and several engineering and technical universities \
	have established themselves there."

/datum/trade_destination/jupiter/callisto
	name = "Callisto"
	description = "One of the moons of Jupiter."

/datum/trade_destination/jupiter/io
	name = "Io"
	description = "One of the moons of Jupiter."

/datum/trade_destination/saturn
	name = "Saturn"
	description = "ecological store (seeds, flora, fauna, dna) in case of Martian collapse, colony and farm world, moons heavily populated, \
	largest population hub and second largest cultural hub in Sol after Mars."
	distance = 9.5
	viable_random_events = list(RIOTS, WILD_ANIMAL_ATTACK, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, ALIEN_RAIDERS, AI_LIBERATION, MOURNING, CULT_CELL_REVEALED, SECURITY_BREACH, ANIMAL_RIGHTS_RAID, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, SONG_DEBUT, MOVIE_RELEASE, BIG_GAME_HUNTERS, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)

/datum/trade_destination/saturn/titan
	name = "Titan"
	description = "One of the moons of Saturn."

/datum/trade_destination/saturn/pan
	name = "Pan"
	description = "One of the moons of Saturn."

/datum/trade_destination/saturn/daphnis
	name = "Daphnis"
	description = "One of the moons of Saturn."

/datum/trade_destination/saturn/atlas
	name = "Atlas"
	description = "One of the moons of Saturn."

/datum/trade_destination/saturn/prometheus
	name = "Prometheus"
	description = "One of the moons of Saturn."

/datum/trade_destination/saturn/pandora
	name = "Pandora"
	description = "One of the moons of Saturn."

/datum/trade_destination/uranus
	name = "Uranus"
	description = "Largely unimportant in terms of resource exploitiation and uninteresting for civilian uses, Uranus was claimed by \
	the Sol government shortly after it became economically feasible to construct orbital facilities there. The orbit of this ice giant \
	rapidly became host to immense amounts of habitat modules, maintenance shipyards and naval bases. Today, Uranus is called 'The \
	barracks of Sol', as most of the system fleet is housed there; the orbital habitats are predominantly populated by naval officers, \
	shipmen, marines and their families."
	distance = 19
	viable_random_events = list(RIOTS, WILD_ANIMAL_ATTACK, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, ALIEN_RAIDERS, AI_LIBERATION, MOURNING, CULT_CELL_REVEALED, SECURITY_BREACH, ANIMAL_RIGHTS_RAID, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, SONG_DEBUT, MOVIE_RELEASE, BIG_GAME_HUNTERS, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)

/datum/trade_destination/uranus/miranda
	name = "Miranda"
	description = "One of the moons of Uranus."

/datum/trade_destination/uranus/ariel
	name = "Ariel"
	description = "One of the moons of Uranus."

/datum/trade_destination/uranus/umbriel
	name = "Umbriel"
	description = "One of the moons of Uranus."

/datum/trade_destination/uranus/titania
	name = "Titania"
	description = "One of the moons of Uranus."

/datum/trade_destination/uranus/oberon
	name = "Oberon"
	description = "One of the moons of Uranus."

/datum/trade_destination/neptune
	name = "Neptune"
	description = "???"
	distance = 30
	viable_random_events = list()
	viable_mundane_events = list()

/datum/trade_destination/neptune/triton
	name = "Triton"
	description = "A moon of Neptune. Colonized, terraformed, has an atmosphere?"

/datum/trade_destination/neptune/phoebe
	name = "Phoebe"
	description = "A moon of Neptune."

/datum/trade_destination/pluto
	name = "Charon and Pluto"
	description = "There are many memorials to the victims of human explotiation and expansion. Pluto and its sister-planet Charon are \
	one of the stark reminders of the cost of greed, having been reduced to ruins by corporate mining interests unable to find water and \
	hydrogen in the Kuiper Belt or unwilling to venture far from a settled area. It was largely abandoned late in the expansion drive after \
	the Kuiper Belt was established, and now all that remains of Pluto are abadoned mining stations and a cloud of debris. The remains are \
	home to a few drifters and hermits who occupy the officially non-existent ruins, haphazardly holding the ancient facilities together."
	distance = 39.5
	viable_random_events = list(CULT_CELL_REVEALED, FESTIVAL)
	viable_mundane_events = list(CELEBRITY_DEATH)

// Kuiper belt
/datum/trade_destination/kuiperbelt
	name = "Kuiper Belt"
	description = "The Kuiper Belt was considered far too remote for habitation for many decades during the push outwards \
	from Earth. With modern ship technology and habitat constructiont techniques, the Belt has become the de facto location for \
	independant industrialists, corporate facilities and those who wish to strike it rich on a frontier that is both less remote \
	than the Oort cloud and less regimented and controlled than the inner-system Halo. Piracy and criminal enterprise are \
	significant problems in the Belt, and most corporations maintain their own armed envoys rather than trusting to the scattered \
	Sol Central naval presence."
	distance = 43
	viable_random_events = list(RIOTS, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, ALIEN_RAIDERS, AI_LIBERATION, MOURNING, CULT_CELL_REVEALED, SECURITY_BREACH, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, SONG_DEBUT, MOVIE_RELEASE, ELECTION, GOSSIP, TOURISM, CELEBRITY_DEATH, RESIGNATION)

/datum/trade_destination/kuiperbelt/haumea
	name = "Haumea"
	description = "Haumea, a dwarf planet beyond Neptune, is one of a handful of bodies recognised as extraterritorial \
	private residences by Sol. Unique amongst them, Haumea is open to the public; the reclusive and mysterious owner, \
	Bill Vorontsov, finances and maintains one of the largest museums in Human space in a warren of caves carved out \
	under the surface of the planetoid."
	distance = 50
	viable_random_events = list(FESTIVAL)
	viable_mundane_events = list(CELEBRITY_DEATH)

/datum/trade_destination/kuiperbelt/makemake
	name = "Makemake Correctional Facility"
	description = "While most settlements have their own prison facilities, the lack of space on most habitats and dangerous \
	conditions of most industrial settlements make it difficult to sustain a large population of prisoners. With Sol Central leaning \
	heavily on the abolishment of privately owned prisons during its unification and rise as a central power, it established Makemake \
	to serve as a centralized rehabilitation facility. Remote, forbidding and hostile to human life, the dwarf planet has had a grand \
	total of two escapes in its three hundred year operational history."
	distance = 67.7
	viable_random_events = list(RIOTS, WARSHIPS_ARRIVE, AI_LIBERATION, CULT_CELL_REVEALED, SECURITY_BREACH)
	viable_mundane_events = list(RESIGNATION)

/datum/trade_destination/kuiperbelt/eris
	name = "Eris"
	description = "Eris would be totally unremarkable if it was not the last significant populated human settlement before the Oort cloud \
	and the interstellar gulf. It serves predominantly as a refuelling port and a moderately large shipyard servicing the frontier."
	distance = 68
	viable_random_events = list(RIOTS, INDUSTRIAL_ACCIDENT, BIOHAZARD_OUTBREAK, WARSHIPS_ARRIVE, PIRATES, CORPORATE_ATTACK, ALIEN_RAIDERS, AI_LIBERATION, MOURNING, CULT_CELL_REVEALED, SECURITY_BREACH, FESTIVAL)
	viable_mundane_events = list(RESEARCH_BREAKTHROUGH, BARGAINS, SONG_DEBUT, MOVIE_RELEASE, ELECTION, GOSSIP, CELEBRITY_DEATH, RESIGNATION)

// Furthest extreme of the Solar System.
/datum/trade_destination/oort
	name = "Oort cloud"
	description = "A former battleground of the Sol Militia and pirates and a haven for water and ice production, the Oort \
	Cloud has lost some of its importance as material synthesis technology and growing economies in the inner system make raw materials \
	unnecessary. Today, the masses of tiny stations, industrial, military or illegal, are occupied by spacer nomads and the SolGov military. \
	The Cloud is heavily fortified with fortress stations as first line of defense against any hostile incursions from the interstellar gulf. \
	Many of the fortresses were established hundreds of years ago, and in modern times a naval posting to the Oort Cloud is considered either \
	something done to put a retiring soldier out to pasture, or a punishment for an uppity officer."
	distance = 2000 // More like 1000-100000. Oort Cloud is huge yo.
	viable_random_events = list(WARSHIPS_ARRIVE, PIRATES, ALIEN_RAIDERS, CULT_CELL_REVEALED)
	viable_mundane_events = list(CELEBRITY_DEATH, RESIGNATION)