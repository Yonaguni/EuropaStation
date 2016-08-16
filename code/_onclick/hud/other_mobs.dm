
/datum/hud/proc/unplayer_hud()
	return

/mob/dead/observer/instantiate_hud(var/datum/hud/HUD)
	HUD.ghost_hud()

/datum/hud/proc/ghost_hud()
	return

/mob/living/brain/instantiate_hud(var/datum/hud/HUD)
	return
