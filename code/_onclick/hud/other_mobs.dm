
/datum/hud/proc/unplayer_hud()
	return

/mob/dead/observer/instantiate_hud(var/datum/hud/HUD)
	HUD.ghost_hud()

/datum/hud/proc/ghost_hud()
	return

/mob/living/carbon/brain/instantiate_hud(var/datum/hud/HUD)
	return

/mob/living/silicon/ai/instantiate_hud(var/datum/hud/HUD)
	HUD.ai_hud()

/datum/hud/proc/ai_hud()
	return

/datum/hud/proc/blob_hud(ui_style = 'icons/mob/screen1_Midnight.dmi')

	blobpwrdisplay = new /obj/screen()
	blobpwrdisplay.name = "blob power"
	blobpwrdisplay.icon_state = "block"
	blobpwrdisplay.screen_loc = ui_health
	blobpwrdisplay.layer = 20

	blobhealthdisplay = new /obj/screen()
	blobhealthdisplay.name = "blob health"
	blobhealthdisplay.icon_state = "block"
	blobhealthdisplay.screen_loc = ui_internal
	blobhealthdisplay.layer = 20

	mymob.client.screen = null

	mymob.client.screen += list(blobpwrdisplay, blobhealthdisplay)
