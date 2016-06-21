/mob/living/var/radio_voice

/mob/living/New()
	..()
	if(!radio_voice)
		radio_voice = "a "
		if(gender == MALE)
			radio_voice += " male"
		else if(gender == FEMALE)
			radio_voice += " female"
		radio_voice += " voice"

/mob/living/human/initialize()
	..()
	radio_voice = species.get_radio_voice(src)

/mob/proc/get_radio_voice()
	return name

/mob/living/get_radio_voice()
	return radio_voice

/mob/living/human/get_radio_voice()
	if(wear_mask && istype(wear_mask, /obj/item/clothing/mask/gas/voice))
		var/obj/item/clothing/mask/gas/voice/V = wear_mask
		if(V.changer.active)
			return V.changer.voice
	return radio_voice

/datum/species/proc/get_radio_voice(var/mob/living/human/H)
	var/result = "a "
	if(H.gender == MALE)
		result += " male"
	else if(H.gender == FEMALE)
		result += " female"
	result += "[name] voice"
	return result