var/list/rune_icon_cache = list()
var/list/all_rune_idents = list()
var/list/all_rune_states = icon_states('icons/effects/runes.dmi')-"blank"

/datum/presence_power/rune
	passive = TRUE
	header_text = null
	children = null
	sigil_del_after_use = TRUE

/datum/presence_power/rune/purchased(var/mob/living/presence/purchased_by)
	..()
	for(var/mob/believer in purchased_by.believers)
		if(believer.client)
			to_chat(believer, "<span class='notice'>A stabbing headache overcomes you as you suddenly recall how to scribe a <span class='danger'>[name]</span>. Consult your tome for more information.</span>")
