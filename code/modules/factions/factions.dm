#define FACTION_LUNAR_TRADE      "Lunar Trade Council"
#define FACTION_FIRST_WAVE       "First Wave"
#define FACTION_NONHUMAN_BLOC    "Nonhuman Bloc"
#define FACTION_BIOCONSERVATIVES "Bioconservatives"
#define FACTION_OUTER_SYSTEM     "Outer System Bloc"
#define FACTION_INNER_SYSTEM     "Inner System Bloc"
#define FACTION_CUCHULAIN        "Cuchulain Foundation"
#define FACTION_TERRAN_STATE     "Terran State"
#define FACTION_CENTRAL_SOLAR    "Central Solar Authority"

/datum/faction/csa
	name = FACTION_CENTRAL_SOLAR
	blurb = "The <b>Central Solar Authority</b> is the 'official' government of the entirety of Sol, at least \
	in name. It administrates the solar system from the government hub on Mars, overseeing industry and science \
	and ensuring the safety of its citizens through judicious application of the Jovian and Saturnian navies. \
	Critics like the Terran State call the CSA authoritarian, top-heavy and brutal when enforcing the Pax Solar."
	secondary_langs = list(LANGUAGE_SIGN)
/datum/faction/ts
	name = FACTION_TERRAN_STATE
	blurb = "The <b>Terran State</b> is something of a dinosaur, tracing its roots to the early days of human \
	expansion into space. These days, it is the national identity for the poor and downtrodden people of Earth, \
	labouring under the heel of the hyper-rich elite of the Lunar Trade Council. The Terran State as a whole \
	presents as fiercely, violently independant of 'upstarts' like the Central Solar Authority."
	financial_influence = 0.5
	secondary_langs = list(LANGUAGE_SIGN, LANGUAGE_RUNGLISH)

/datum/faction/ltc
	name = FACTION_LUNAR_TRADE
	blurb = "The <b>Lunar Trade Council</b> is an aggregate of glitterati, industrial tycoons and politicians and \
	within the complex ruling body of Asphodel and the other Lunar dome cities. The LTC wields a great deal of \
	political power, and their weapon emplacement provide them with a more literal form. Generally speaking, \
	members affiliated with the LTC find themselves at odds with other groups, especially the Central Solar Government."
	financial_influence = 1.3
	secondary_langs = list(LANGUAGE_SIGN, LANGUAGE_RUNGLISH, LANGUAGE_LUNAR)

/datum/faction/firstwave
	name = FACTION_FIRST_WAVE
	blurb = "The <b>First Wave</b> was a major genetic engineering project conducted during the mass exodus from Earth \
	in the 2000s. Many genotypes and uplifts trace their roots to the modification programs executed during those hectic \
	decades, and in many places they still suffer from prejudice that damages their quality of life. Around Saturn and \
	the Kuiper belt they represent a political bloc with a tendency to stick together against the 'basics'."
	financial_influence = 0.85
	secondary_langs = list(LANGUAGE_SIGN, LANGUAGE_RUNGLISH)

/datum/faction/nonhuman
	name = FACTION_NONHUMAN_BLOC
	blurb = "The <b>nonhuman bloc</b> represents non-human interests across Sol, such as uplifted species like octopodes \
	and corvidae, as well as digitals like AGIs and disembodied mind-states. Such minority groups find it difficult to retain \
	cultural cohesion and exert power in the human political sphere due to their significant physical and cultural differences \
	from baseline humanity, and often act as a group, combining a multitude of small voices into a single loud one."
	financial_influence = 0.7
	secondary_langs = list(LANGUAGE_SIGN, LANGUAGE_CEPHLAPODA, LANGUAGE_CORVID, LANGUAGE_EAL)

/datum/faction/nonhuman/get_random_name(var/gender, var/species)
	switch(species)
		if(SPECIES_CORVID)
			name_language = LANGUAGE_CORVID
		if(SPECIES_OCTOPUS)
			name_language = LANGUAGE_CEPHLAPODA
		else
			name_language = initial(name_language)
	. = ..(gender, species)

/datum/faction/outer
	name = FACTION_OUTER_SYSTEM
	blurb = "The <b>Outer System</b> bloc is a loose collection of political interests found beyond the orbit of \
	Jupiter, largely centralized on Saturn, Uranus and Neptune. Outer System groups tend to align with a more liberal \
	view of humanity than baseline, advocating for increased digital rights, inclusion of nonhuman uplifts in society, \
	and the adoption of more 'radical' technologies like genetic engineering and ego forking."
	financial_influence = 0.85
	secondary_langs = list(LANGUAGE_SIGN, LANGUAGE_EXTERIOR, LANGUAGE_EAL)

/datum/faction/inner
	name = FACTION_INNER_SYSTEM
	blurb = "The <b>Inner System</b> bloc is a socially and technologically conservative grouping centered on Mars and \
	generally covers all planets and habitats from there inward, with the notable exclusion of Earth under the aegis \
	of the Lunar Trade Council. Most Inner System bloc adherents spurn uplifts, digital intelligences and radical \
	genetic alteration as reckless and unnatural, and push for strong, stable, democractic government."
	financial_influence = 1.15
	secondary_langs = list(LANGUAGE_SIGN, LANGUAGE_RUNGLISH, LANGUAGE_BELTER)

/datum/faction/cuchulain
	name = FACTION_CUCHULAIN
	blurb = "The <b>Cuchulain Foundation</b>, located on Neptune, represents the single largest psionic research body \
	in human space. They offer funding, training and logistical support for groups across Sol in the interests of \
	educating psi-operant individuals before they hurt themselves or others. Due to the legislative censorship efforts \
	of the Inner System, they tend to operate beyond Mars orbit, and often serve as consultants to larger organizations."
	secondary_langs = list(LANGUAGE_SIGN, LANGUAGE_RUNGLISH, LANGUAGE_EXTERIOR)

/datum/faction/test_subjects
	name = "Test Subjects"
	blurb = "Ook?"
	default_language = LANGUAGE_MONKEY
	mob_faction = "monkey"
	chargen_available = FALSE
