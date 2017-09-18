/datum/language/cephlapoda
	name = LANGUAGE_CEPHLAPODA
	desc = "A melodic and complex language spoken by octopode uplifts. Some of the notes are inaudible to humans."
	speech_verb = "warbles"
	ask_verb = "warbles"
	exclaim_verb = "warbles"
	colour = "alien"
	key = "k"
	flags = WHITELISTED
	syllables = list("qr","qrr","xuq","qil","quum","xuqm","vol","xrim","zaoo","qu-uu","qix","qoo","zix","*","!")
	speech_sounds = list(
		'sound/voice/cephlapod/warble1.ogg',
		'sound/voice/cephlapod/warble2.ogg',
		'sound/voice/cephlapod/warble3.ogg',
		'sound/voice/cephlapod/warble4.ogg',
		'sound/voice/cephlapod/warble5.ogg',
		'sound/voice/cephlapod/warble6.ogg',
		'sound/voice/cephlapod/warble7.ogg',
		'sound/voice/cephlapod/warble8.ogg',
		'sound/voice/cephlapod/warble9.ogg',
		'sound/voice/cephlapod/warble10.ogg',
		'sound/voice/cephlapod/warble11.ogg'
		)

/datum/language/corvid
	name = LANGUAGE_CORVID
	desc = "A trilling language spoken by Neo-Corvidae."
	speech_verb = "chirps"
	ask_verb = "chirrups"
	exclaim_verb = "trills"
	colour = "alien"
	key = "v"
	flags = WHITELISTED
	space_chance = 50
	syllables = list(
			"ca", "ra", "ma", "sa", "na", "ta", "la", "sha", "scha", "a", "a",
			"ce", "re", "me", "se", "ne", "te", "le", "she", "sche", "e", "e",
			"ci", "ri", "mi", "si", "ni", "ti", "li", "shi", "schi", "i", "i"
		)
	speech_sounds = list(
		'sound/voice/corvid/owl1.ogg',
		'sound/voice/corvid/owl2.ogg',
		'sound/voice/corvid/owl3.ogg'
		)

/datum/language/corvid/get_random_name(gender)
	return ..(gender, 1, 4, 1.5)
