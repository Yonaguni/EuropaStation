
/datum/hud/proc/unplayer_hud()
	return

/mob/observer/ghost/instantiate_hud(var/datum/hud/HUD)
	HUD.ghost_hud()

/datum/hud/proc/ghost_hud()
	return

/mob/living/carbon/brain/instantiate_hud(var/datum/hud/HUD)
	return

/mob/living/silicon/ai/instantiate_hud(var/datum/hud/HUD)
	HUD.ai_hud()

/datum/hud/proc/ai_hud()
	return

/datum/hud/proc/blob_hud(ui_style = 'icons/screen/styles/white.dmi')

	blobpwrdisplay = new /obj/screen()
	blobpwrdisplay.name = "blob power"
	blobpwrdisplay.icon_state = "block"
	blobpwrdisplay.screen_loc = ui_health
	blobpwrdisplay.layer = SCREEN_LAYER

	blobhealthdisplay = new /obj/screen()
	blobhealthdisplay.name = "blob health"
	blobhealthdisplay.icon_state = "block"
	blobhealthdisplay.screen_loc = ui_internal
	blobhealthdisplay.layer = SCREEN_LAYER

	mymob.client.screen = list()

	mymob.client.screen += list(blobpwrdisplay, blobhealthdisplay)
	common_hud()

/mob/living/carbon/slime/instantiate_hud(var/datum/hud/HUD)
	HUD.slime_hud()

/datum/hud/proc/slime_hud(ui_style = 'icons/screen/styles/white.dmi')
	src.adding = list()
	build_intent_selector(src)
	mymob.client.screen = list()
	mymob.client.screen += src.adding
	common_hud()

/mob/living/simple_animal/construct/instantiate_hud(var/datum/hud/HUD)
	HUD.construct_hud()

/datum/hud/proc/construct_hud()
	var/constructtype

	if(istype(mymob,/mob/living/simple_animal/construct/armoured) || istype(mymob,/mob/living/simple_animal/construct/behemoth))
		constructtype = "juggernaut"
	else if(istype(mymob,/mob/living/simple_animal/construct/builder))
		constructtype = "artificer"
	else if(istype(mymob,/mob/living/simple_animal/construct/wraith))
		constructtype = "wraith"
	else if(istype(mymob,/mob/living/simple_animal/construct/harvester))
		constructtype = "harvester"

	if(constructtype)
		mymob.fire = new /obj/screen()
		mymob.fire.icon = 'icons/screen/hud_construct.dmi'
		mymob.fire.icon_state = "fire0"
		mymob.fire.name = "fire"
		mymob.fire.screen_loc = ui_construct_fire

		mymob.healths = new /obj/screen()
		mymob.healths.icon = 'icons/screen/hud_construct.dmi'
		mymob.healths.icon_state = "[constructtype]_health0"
		mymob.healths.name = "health"
		mymob.healths.screen_loc = ui_construct_health

		mymob.zone_sel = new /obj/screen/zone_sel()
		mymob.zone_sel.icon = 'icons/screen/hud_construct.dmi'
		mymob.zone_sel.overlays.len = 0
		mymob.zone_sel.overlays += image('icons/mob/zone_sel.dmi', "[mymob.zone_sel.selecting]")

		mymob.purged = new /obj/screen()
		mymob.purged.icon = 'icons/screen/hud_construct.dmi'
		mymob.purged.icon_state = "purge0"
		mymob.purged.name = "purged"
		mymob.purged.screen_loc = ui_construct_purge

	mymob.client.screen = list()
	mymob.client.screen += list(mymob.fire, mymob.healths, mymob.zone_sel, mymob.purged)
	common_hud()
