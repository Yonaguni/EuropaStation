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
	desc = "A rough, loud language spoken by Corvidae."
	speech_verb = "chirps"
	ask_verb = "rattles"
	exclaim_verb = "calls"
	colour = "alien"
	key = "v"
	flags = WHITELISTED
	space_chance = 50
	syllables = list(
			"ca", "ra", "ma", "sa", "na", "ta", "la", "sha",
			"ti","hi","ki","ya","ta","ha","ka","ya","chi","cha","kah",
			"skre","ahk","ek","rawk","kraa","ii","kri","ka"
		)
	speech_sounds = list(
		'sound/voice/corvid/crow1.ogg',
		'sound/voice/corvid/crow2.ogg',
		'sound/voice/corvid/crow3.ogg',
		'sound/voice/corvid/crow4.ogg'
		)

/datum/language/corvid/get_random_name(gender)
	var/new_name = gender==FEMALE ? capitalize(pick(first_names_female)) : capitalize(pick(first_names_male))
	new_name += " [pick(list("Albus","Corax","Corone","Meeki","Insularis","Orru","Sinaloae", "Enca", "Edithae", "Kubaryi"))]"
	new_name += " [pick(list("Hyperion","Earth","Mars","Venus","Neith","Luna","Halo","Pandora","Neptune","Triton", "Haumea", "Eris", "Makemake"))]"
	return new_name