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
		'sound/voice/skrellian/skrellian1.ogg',
		'sound/voice/skrellian/skrellian2.ogg',
		'sound/voice/skrellian/skrellian3.ogg',
		'sound/voice/skrellian/skrellian4.ogg',
		'sound/voice/skrellian/skrellian5.ogg',
		'sound/voice/skrellian/skrellian6.ogg',
		'sound/voice/skrellian/skrellian7.ogg',
		'sound/voice/skrellian/skrellian8.ogg',
		'sound/voice/skrellian/skrellian9.ogg',
		'sound/voice/skrellian/skrellian10.ogg',
		'sound/voice/skrellian/skrellian11.ogg'
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
		'sound/voice/resomi/owl1.ogg',
		'sound/voice/resomi/owl2.ogg',
		'sound/voice/resomi/owl3.ogg'
		)

/datum/language/corvid/get_random_name(gender)
	return ..(gender, 1, 4, 1.5)
