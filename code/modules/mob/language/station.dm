/datum/language/diona
	name = LANGUAGE_ROOTSPEAK
	desc = "A creaking, subvocal language spoken instinctively by the Dionaea. Due to the unique makeup of the average Diona, a phrase of Rootspeak can be a combination of anywhere from one to twelve individual voices and notes."
	speech_verb = "creaks and rustles"
	ask_verb = "creaks"
	exclaim_verb = "rustles"
	colour = "soghun"
	key = "q"
	flags = RESTRICTED
	syllables = list("hs","zt","kr","st","sh")
	speech_sounds = list(
		'sound/voice/rootspeak/rootspeak1.ogg',
		'sound/voice/rootspeak/rootspeak2.ogg',
		'sound/voice/rootspeak/rootspeak3.ogg',
		'sound/voice/rootspeak/rootspeak4.ogg',
		'sound/voice/rootspeak/rootspeak5.ogg',
		'sound/voice/rootspeak/rootspeak6.ogg',
		'sound/voice/rootspeak/rootspeak7.ogg',
		'sound/voice/rootspeak/rootspeak8.ogg'
		)

/datum/language/diona/get_random_name()
	var/new_name = "[pick(list("To Sleep Beneath","Wind Over","Embrace of","Dreams of","Witnessing","To Walk Beneath","Approaching the"))]"
	new_name += " [pick(list("the Void","the Sky","Encroaching Night","Planetsong","Starsong","the Wandering Star","the Empty Day","Daybreak","Nightfall","the Rain"))]"
	return new_name

/datum/language/skrell
	name = LANGUAGE_SKRELLIAN
	desc = "A melodic and complex language spoken by the Skrell of Qerrbalak. Some of the notes are inaudible to humans."
	speech_verb = "warbles"
	ask_verb = "warbles"
	exclaim_verb = "warbles"
	colour = "skrell"
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

/datum/language/resomi
	name = LANGUAGE_RESOMI
	desc = "A trilling language spoken by the diminutive Resomi."
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

/datum/language/resomi/get_random_name(gender)
	return ..(gender, 1, 4, 1.5)
