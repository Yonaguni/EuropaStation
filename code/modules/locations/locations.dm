// These are all either real stellar objects or fictional facilities built on real stellar objects, please refer to both Wikipedia before adding/removing them.
/datum/stellar_location/sol
	name = "Sol"
	character_info = "People from the innermost area of Sol are usually career officers in the CSA navy, as there is \
	nothing of note between Sol and Mercury other than military bases, listening posts and solar mining facilities. It's \
	an isolated and lonely place to try and raise a child, but that never stopped anyone."
	description = "There is almost no human presence on this dense belt of Sun-blasted asteroids orbiting between \
	Sol and Mercury. The handful of constructed settlements there are deep underground, dug out by automated systems \
	and dedicated to the most top-secret and sensitive research, storage and disposal operations conducted by \
	the Solar government. A perimeter is patrolled regularly by heavily shielded naval vessels and trespassing on the Vulcanoids \
	tends to be dealt with terminally. Rumours suggest that at least a handful of the facilities orbiting Sol are also dedicated \
	computer processing stacks used by the solar government for decryption, file cracking and cryptocurrency mining."
	distance = 0
	is_a_planet = 1
	capitol = "Daystar Central Administration"
	flavour_locations = list(
		"the Daystar Energy Chain" = \
			"A government-commercial conglomerate operates this dense chain of heavily shielded automated \
			stations, clustered around the Sun, and they serve as an 'energy mining' operation that converts \
			solar energy into a usable form, then shunts it to other portions of the system either by coordinated \
			masers or huge shipments of batteries. Human presence on these stations is minimal and generally \
			restricted to shifts of workers who are only woken from cryogenic storage for emergency maintenance \
			tasks; positions on the ring are extremely taxing and correspondingly extremely well-paid."
		)
	random_map_locations = list(
		"the Vulcanoid asteroid field" = /datum/random_map/automata/asteroids/superheated
		)

/datum/stellar_location/mercury
	name = "Mercury"
	character_info = "Almost half the human population residing in the massive factory complexes on and around Mercury \
	is composed of gene-modified labourers, and there's not much in the way of culture or social events to speak of at \
	the best of times. Pollution and radiation are constant risks, and the hostile conditions breed cynical folk."
	description = "Due to its stable and unique rotational period, tremendously hostile conditions, and huge exploitable solar power \
	potential, Mercury is the single largest and oldest automated factory hub in human space. Much of the output of the colossal factory \
	complexes is shunted into orbit for use in the construction of new capital ships and orbital habitats in the rest of the system."
	distance = 0.3
	is_a_planet = 1
	capitol = "Taforalt Station, high Mercury orbit"
	flavour_locations = list(
		"the public docks",
		"the Caduceus listening post" = \
			"Named for an ancient practical joke, the Caduceus listening post is a government-run facility \
			positioned in Mercury's solar shadow. The purpose of the facility is to monitor signals supposedly \
			received from deep within the corona in the late 2200's, but in practice it is considered a joke \
			posting used to punish those that CSA internal administration has some kind of displeasure with."
		)
	random_map_locations = list(
		"the Mercurial asteroid field" = /datum/random_map/automata/asteroids/superheated
		)

/datum/stellar_location/venus
	name = "Venus"
	is_a_planet = 1
	character_info = "Venus is completely unlivable, but the sheer amount of personnel and money flooding into the \
	terraforming efforts over the decades has resulted in a lively and cosmopolitan social scene amid the orbital \
	habitats. Birth citizens qualify for free education at the Institute of Planetary Science on Neith, too."
	description = "After the success of the Martian terraforming project, the conglomerate responsible set their sights on Venus. \
	With arable land at a premium and huge volumes of money and raw materials flooding the industrial markets thanks to the asteroid \
	mining operations near Mercury, it was feasible to begin work on the significantly more complex problem of reducing the Venusian \
	surface temperature and making the atmosphere compatible with human life. Many are considering the ongoing project, which has been \
	running for approaching six decades, a test run for using the currently experimental technologies to restore the devastated \
	ecosphere of Earth to a better state."
	capitol = "Morningstar Station, high Venus orbit"
	distance = 0.7
	flavour_locations = list(
		"the public docks",
		"Neith" = \
			"Named for the mythical moon of Venus, Neith is a large and complex facility constructed in and on \
			the repositioned and re-purposed quasi-satellite 2002 VE68. It is a corporate-run spaceport and home \
			to the Venusian Terraforming Project and Sol Institute of Planetary Science, which both research and \
			apply techniques for terraforming and planetary engineering. Neith is probably the most highly-regarded \
			hub of scientific research and cosmological understanding in Sol."
		)
	random_map_locations = list(
		"the Venusian halo" = /datum/random_map/automata/asteroids
		)

/datum/stellar_location/earth
	name = "Earth"
	is_a_planet = 1
	character_info = "Earth is a corporate playground and a polluted, overpopulated hellhole - most people born there \
	try to leave as soon as possible, assuming they aren't part of the Lunar Trade Council and consequently living it up \
	in the hyper-rich dome city of Asphodel on the moon. The Terran State considers itself independant of the Central \
	Solar Authority, leading to strained relations between Earth and the rest of the system."
	description = "The period between achieving spaceflight and the unification of Sol was not kind to the birthplace \
	of Humanity. Earth is now a desolate, war-torn shell, populated by teeming billions of poor and downtrodden people \
	unable to afford the excessive cost of getting into orbit and into the rest of the system. Earth is fiercely independant \
	of the Sol union and rejects the authority of Mars, serving the Lunar Trade Council as a kind of tax haven and city-state \
	combined."
	distance = 1
	capitol = "Asphodel, Luna"
	ruling_body = "Terran State"
	flavour_locations = list(
		"Luna" = \
			"By contrast to her sovereign planet, Luna is a gleaming jewel. Vast quantities of political/economic power and money reside \
			in the cities constructed all across the Lunar surface, particularly the capital of Asphodel, administrated and overseen by the \
			Lunar Trade Council. Corporate power on the moon easily outclasses the government, making it a playground for the hyper-rich and \
			not an easy place to live for anyone else. Luna also administrates travel to and from the desolate surface of Earth.",
		"the public docks",
		"the corporate docks"
		)
	random_map_locations = list(
		"the O'Neil debris field" = /datum/random_map/automata/asteroids/debris
	)

// Capitol of Sol.
/datum/stellar_location/mars
	name = "Mars"
	character_info = "Mars is the breadbasket and cultural beacon of Sol, representing both the main population center and government \
	administration hub for the entire system with the exception of Earth, which considers itself independant. Socialized healthcare, \
	free tertiary education and a thriving economy make Mars a pleasant and stable place to live, but many find the milquetoast and \
	conservative social attitudes to be stifling."
	capitol = "Barsoom Dome City, Tharsis"
	description = "During the initial phases of the expansion from Earth, Mars was earmarked as an agricultural food basket for the fledgling \
	CSA. The terraforming project was hugely expensive, financed both by the Solar government and several corporate backers, and took over a \
	century to change the desolate planet to a point that humans could survive outside of radiation-shielded domes. These days, Mars is the \
	official capitol of Sol, boasting a population of six billion people living in the dome cities, and huge shipbuilding and administration \
	facilities sailing above in orbit. The chief export is biomass; Mars is still one of the only planets in the solar system capable of supporting \
	mass industrial farming."
	is_a_planet = 1
	distance = 1.5
	flavour_locations = list(
		"Phobos" = \
			"Phobos is a shipbuilding and advanced naval system research and fabrication hub with mixed corporate and government \
			presences. Significant portions of the moon's surface are dedicated to naval facilities, both for ship production and \
			personnel training. During the settlement of Mars, Phobos was also the coordinating hub for colony activities, \
			directing the terraforming project established on its sister moon, Deimos. The moon has a markedly poor reputation with \
			CSA military personnel, who have often publicly stated that getting a posting there is like 'Hell on Earth' due to \
			hostile conditions and demanding surprise military exercises.",
		"Deimos" = \
			"Deimos was the muscle of the Martian terraforming project; the machinery used to alter the atmosphere and direct ice \
			asteroids into strategic areas of the planet is still in operation today, but now serves primarily as a mechanism for \
			regulating the planet's rather rambunctious weather systems. The rest of the moon is the property of the CSA and serves \
			as the bureaucratic and administrative seat for Mars, and by extension the rest of the solar system.",
		"the public docks",
		"the corporate docks"
		)
	random_map_locations = list("the Barsoom debris field" = /datum/random_map/automata/asteroids/debris)

// Asteroid belt.
/datum/stellar_location/asteroids
	name = "the Halo asteroid belt"
	character_info = "Most of the people living in the Halo are 'belters', members of the long-running mining dynasties responsible \
	for prospecting and settling the belt in the early years of human expansion. These days the ruling families are rich, independant and \
	self-supporting, but often send their children and crews off on visits to the more populated and interesting parts of the system."
	description = "The metal-rich asteroids of the system's inner ring were the Holy Grail of the initial expansion from Earth. The factories \
	and habitats in the Halo predate the system government in many places, and their output of metals, minerals and water fuel the industries of \
	most of the other planets and stations short of the Kuiper Belt. The Halo facilities were instrumental in providing the ice asteroids used \
	to terraform Mars, and many of the dynasties ruling swathes of the belt owe their fortunes to the mad scramble for farmland that came with \
	human expansion from Earth."
	distance = 3.2
	capitol = "Tempestus Dome, Ceres"
	flavour_locations = list(
		"Ceres" = \
			"Due to being unsuitable for settlement, devoid of any immediately easily exploitable resources, and largely unfit for human \
			habitation, huge portions of Ceres were unceremoniously auctioned off by the Department of Planetary Exploitation during the late \
			stages of human expansion, resulting in it becoming an industrial chemical synthesis hub. Environmental restrictions on industrial \
			processes on the dwarf planet were largely removed, apparently due to the idea that it would be hard to make the place any worse. \
			These days, Ceres is the industrial administration hub of Sol.",
		"Vesta",
		"Pallas",
		"Hygiea",
		"434 Hungaria",
		)
	random_map_locations = list(
		"the Gefion family" =  /datum/random_map/automata/asteroids,
		"the Phocaea family" = /datum/random_map/automata/asteroids,
		"the Karin cluster" =  /datum/random_map/automata/asteroids
		)

/datum/stellar_location/jupiter
	name = "Jupiter"
	character_info = "Jupiter is second only to Mars in significance, serves as the main shipyard for the system defense fleet, and boasts \
	an economic index to beggar any other system in Sol. The planet itself isn't populated, only mined for fuel, but Ganymede, Callisto and Io all \
	have large populations, including long-term residents, visitors, navy personnel and their families."
	description = "The high demand for hydrogen and helium-derived fuel during the initial phases of human expansion to other planets \
	caused Jupiter's mining corporations to skyrocket in power and influence. These days Jupiter has been eclipsed by the booming HE3 \
	trade, but it is still a hub for mining and fabrication conglomerates without the cash to establish themselves in the Kuiper Belt."
	capitol = "Jove City, Ganymede"
	is_a_planet = 1
	distance = 5.2
	flavour_locations = list(
		"the public docks",
		"the corporate docks",
		"the Jovian Naval docks",
		"Callisto" = \
			"Largely unimportant in terms of resource exploitation and uninteresting for civilian uses, Callisto was claimed by the \
			central government shortly after it became economically feasible to construct facilities there. The orbit of this moon \
			rapidly became host to immense numbers of habitat modules, maintenance shipyards and naval bases. Today, Callisto is called \
			'The barracks of Sol', as most of the system fleet is housed there; the orbital habitats are predominantly populated by naval \
			officers, marines and their families.",
		"Io",
		"Ganymede" = \
			"Due to its size and magnetosphere, Ganymede came to house the majority of the facilities constructed during Jupiter's \
			exploitation. The abundant water and silicates, combined with geologically stability, made it an ideal base of operations \
			for the fuel refining companies and their workers. Much of Jupiter's bounty was packaged and shipped from Ganymede, and \
			it rapidly gained a relatively huge population despite significant population and capital loss following a fuel crash \
			towards the end of human expansion. Ganymede is still home to millions of people, facilities and data havens, and several \
			engineering and technical universities have established themselves there."
		)
	random_map_locations = list(
		"the Jovian asteroid halo" = /datum/random_map/automata/asteroids/debris
		)

/datum/stellar_location/europa
	name = "Europa"
	capitol = "Rhadamanthus"
	is_a_planet = 1
	character_info = "Europa is a water moon of Jupiter, and yet is one of the most isolated places known to man. The sub-ice \
	facilities and colonies are lonely, dilapidated places, services mostly by corporate drones and ignored by the system \
	government. Growing up in a pressure dome at the bottom of a midnight ocean can't be good for a child."
	description = "One of the more uninteresting moons in Jupiter's vast swathe of satellites, Europa underwent several abortive \
	and abandoned colonization attempts, most famously the Yonaguni disaster that resulted in the collapse of several colony domes \
	and the lonely deaths of thousands of people. So-far unexplained signal disturbances render the moon far more remote than mere \
	distance would account for, but a handful of colonists and corporate research bodies still inhabit the desolate place."
	flavour_locations = list(
		"Rhadamanthus Starport" = \
			"A once-bustling facility servicing the Europa colonies; now largely abandoned other than automated systems and \
			once-a-year maintenance crews."
		)
	random_map_locations = list(
		"the ice belt" = /datum/random_map/automata/asteroids/debris/strange
		)

/datum/stellar_location/saturn
	name = "Saturn"
	is_a_planet = 1
	character_info = "Although it doesn't have a large population by comparison to Mars or Jupiter, Saturn is reputed to be the most \
	frenetic and lively place in the system. Large populations of uplifts, permissive genetic modification laws and highly advanced, \
	automated habitats make it an extremely appealing place to live for the less conservative and stodgy portions of the population."
	description = "Saturn is home to a 'backup plan' ecological store (seeds, flora, fauna and DNA samples) for use in case of \
	Martian and Terran collapse, termed the Long Now Project. While the planet itself is uninhabited, the vast number of moons \
	scattered around it are heavily settled and populated and it boasts one of the strongest economies in Sol, placed as it is \
	outside the reach of the CSA and quite close to the Kuiper belt. Significant numbers of the moonlets are home to mass industrial \
	aquaculture and vat biomass production plants and many others are heavily populated as residential zones. Saturn is the single \
	densest and largest population hub in Sol and second largest human cultural hub after Mars. It is also known as the most \
	uplift-friendly and bioprogressive human world, outpaced only by some of the more radical Kuiper Belt and Oort dedicated fringe \
	habitats."
	capitol = "Distributed government with nodes on Pandora, Titan and Hyperion."
	distance = 9.5
	flavour_locations = list(
		"the public docks",
		"the private docks",
		"Titan" = \
			"Heavily engineered and artificially flooded with water from ice asteroids; home to the largest dolphin and octopus \
			societies in human space.",
		"Pan",
		"Daphnis",
		"Atlas" = "The primary ecological DNA/sample/seed storehouse and bunker for the Long Now Project.",
		"Prometheus" = "The primary technological database storage/data vault for the Long Now Project.",
		"Pandora" = \
			"Home to numerous refineries and factories as well as the largest civilian base in Saturn orbit. Also ironically home \
			to a large cloning and genetic engineering facility owned by a conglomerate of corporate interests, which is turn home \
			to the Uplift Adaptation Project and the First Wave Institute.",
		"Hyperion" = \
			"This moon is the chosen motherland for corvid uplifts, ceded to them after the completion of the Martian Terraforming \
			Project. It was chosen due to its remoteness from Sol's government centre and its egg-like shape - nobody ever accused \
			corvidae of being deep thinkers. Huge reinforced domes cover the craters of the moon, giving it a pebbled appearance \
			from space, and large open spaces are the favoured habitation for the citizenry. It has a very small population of humans, \
			numbering in the low hundreds, and several thousand corvid citizens."
		)
	random_map_locations = list(
		"the rings of Saturn" = /datum/random_map/automata/asteroids/debris
		)

/datum/stellar_location/uranus
	name = "Uranus"
	capitol = "Hub, low Oberon orbit"
	character_info = "Most of the long-term population of Uranus is made up of military officers and service personnel, although there are \
	a handful of civil stations, usually corporate or government research facilities there to liaise with the fleet. Naval schools also \
	offer education to children of military personnel, but generally most people only hang around Uranus if they have nowhere else to go."
	description = "Largely unimportant in terms of resource exploitiation and uninteresting for civilian uses, Uranus was claimed by \
	the Sol government shortly after it became economically feasible to construct orbital facilities there. The orbit of this ice giant \
	rapidly became host to immense amounts of habitat modules, maintenance shipyards and naval bases. Today, Uranus is called 'The \
	barracks of Sol', as most of the system fleet is housed there; the orbital habitats are predominantly populated by naval officers, \
	shipmen, marines and their families."
	is_a_planet = 1
	distance = 19
	flavour_locations = list(
		"the public docks",
		"the private docks",
		"Miranda",
		"Ariel",
		"Umbriel",
		"Titania",
		"Oberon"
		)
	random_map_locations = list(
		"the Saturnine debris field" = /datum/random_map/automata/asteroids/debris
		)

/datum/stellar_location/neptune
	name = "Neptune"
	is_a_planet = 1
	capitol = "HRLDSA-H Administrative Office, Triton"
	character_info = "Neptune is a frigid and unpleasant world, and has never had anything close to a large civil population. Most of \
	the stations and habitats orbiting it are dedicated to the enormous listening arrays and governmental science projects being conducted \
	there, or are related to the psionic research facilities maintained by the Cuchulain Foundation."
	description = "The remote and desolate ice world of Neptune was never particularly appealing as a target for colonization, but \
	now maintains a relatively small population as part of the Saturnian territorial umbrella. Most of the economy of the region is \
	fueled by academic tourism, as the listening arrays over Neptune were the first facilities to decipher and display the Signal and \
	correspondingly the planet boasts some of the finest psi research centers known to man."
	distance = 30
	flavour_locations = list(
		"the public docks",
		"the private docks",
		"Triton",
		"Phoebe",
		"S/2004 N 1" = \
			"A tiny moon of Neptune. Home to the subterranean, heavily shielded and isolated vaults and laboratories that house the \
			Cuchulain Foundation."
		)
	random_map_locations = list(
		"the Neptune debris field" = /datum/random_map/automata/asteroids/debris
		)

/datum/stellar_location/kuiperbelt
	name = "the Kuiper Belt"
	capitol = "Charon"
	character_info = "The Kuiper Belt is the most remote portion of the system that isn't full-on wilderness, and is generally only \
	inhabited by the desperate, the crazed, or the unhinged. Brinker habitats running experimental government forms, genetic \
	engineering projects gone terribly wrong, and all other kinds of bizarre outer-system chicanery are found here."
	ruling_body = "No single authority."
	description = "The Kuiper Belt was considered far too remote for habitation for many decades during the push outwards \
	from Earth. With modern ship technology and habitat constructiont techniques, the Belt has become the de facto location for \
	independant industrialists, corporate facilities and those who wish to strike it rich on a frontier that is both less remote \
	than the Oort cloud and less regimented and controlled than the inner-system Halo. Piracy and criminal enterprise are \
	significant problems in the Belt, and most corporations maintain their own armed envoys rather than trusting to the scattered \
	SolFed naval presence."
	distance = 43
	flavour_locations = list(
		"Charon",
		"2003 UB",
		"1992 QB1",
		"Orcus",
		"Quaoar",
		"Ixion",
		"Varuna",
		"Haumea" = \
			"Haumea, a dwarf planet beyond Neptune, is one of a handful of bodies recognised as extraterritorial private residences by \
			the CSA. Unique amongst them, Haumea is open to the public; the reclusive and mysterious owner, Bill Vorontsov, finances and \
			maintains one of the largest museums in Human space in a warren of caves carved out under the surface of the planetoid.",
		"Makemake Correctional Facility" = \
			"While most settlements have their own prison facilities, the lack of space on most habitats and dangerous conditions \
			of most industrial settlements make it difficult to sustain a large population of prisoners. With the CSA leaning heavily \
			on the abolishment of privately owned prisons during its unification and rise as a central power, it established Makemake \
			to serve as a centralised rehabilitation facility. Remote, forbidding and hostile to human life, the dwarf planet has had \
			a grand total of two escapes in its two hundred year operational history."
		)
	random_map_locations = list(
		"the ruins of Pluto" = /datum/random_map/automata/asteroids
	)

/datum/stellar_location/oort
	name = "the Oort cloud"
	character_info = "There are only three kinds of people who live in the depths of the mind-rendingly distant Oort cloud: criminals, \
	CSA agents chasing criminals, and folk who are very, very lost."
	ruling_body = "No single authority."
	description = "A former battleground of the Sol Militia and pirates and a haven for water and ice production, the Oort \
	Cloud has lost some of its importance as material synthesis technology and growing economies in the inner system make raw materials \
	unnecessary. Today, the masses of tiny stations, industrial, military or illegal, are occupied by spacer nomads and the SolGov military. \
	The Cloud is heavily fortified with fortress stations as first line of defense against any hostile incursions from the interstellar gulf. \
	Many of the fortresses were established hundreds of years ago, and in modern times a naval posting to the Oort Cloud is considered either \
	something done to put a retiring soldier out to pasture, or a punishment for an uppity officer."
	capitol = "Eris, technically."
	distance = 2000 // See New().
	flavour_locations = list(
		"Eris" = \
			"Eris would be totally unremarkable if it was not the last significant populated human settlement before the Oort cloud and the \
			interstellar gulf. It serves predominantly as a refuelling port and a moderately large shipyard servicing the frontier.",
		"Dysnomia",
		"Hyakutake-2",
		"Hale-Bopp-54",
		"Sedna",
		)
	random_map_locations = list(
		"2006 SQ372" = /datum/random_map/automata/asteroids/distant,
		"2008 KV42" =  /datum/random_map/automata/asteroids/distant,
		"2000 CR105" = /datum/random_map/automata/asteroids/distant
		)

/datum/stellar_location/oort/New()
	..()
	distance = rand(1000,100000)