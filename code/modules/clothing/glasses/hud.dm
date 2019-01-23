/obj/item/clothing/glasses/hud
	name = "HUD"
	desc = "A heads-up display that provides important info in (almost) real time."
	origin_tech = list(TECH_MAGNET = 3, TECH_BIO = 2)
	electric = 1
	gender = NEUTER
	species_restricted = null
	var/list/icon/current = list() //the current hud icons

/obj/item/clothing/glasses/hud/process_hud(var/mob/M)
	return

/obj/item/clothing/glasses/hud/health
	name = "health scanner HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their health status."
	icon_state = "healthhud"
	hud_type = HUD_MEDICAL
	body_parts_covered = 0

/obj/item/clothing/glasses/hud/health/process_hud(var/mob/M)
	process_med_hud(M, 1)

/obj/item/clothing/glasses/hud/security
	name = "security HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their ID status and security records."
	icon_state = "securityhud"
	hud_type = HUD_SECURITY
	body_parts_covered = 0
	var/global/list/jobs[0]

/obj/item/clothing/glasses/hud/security/process_hud(var/mob/M)
	process_sec_hud(M, 1)

/obj/item/clothing/glasses/hud/janitor
	name = "janiHUD"
	desc = "A heads-up display that scans for messes and alerts the user. Good for finding puddles hiding under catwalks."
	icon_state = "janihud"
	body_parts_covered = 0
	hud_type = HUD_JANITOR

/obj/item/clothing/glasses/hud/janitor/process_hud(var/mob/M)
	process_jani_hud(M)