/obj/item/storage/belt
	name = "belt"
	desc = "Can hold various things."
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "utilitybelt"
	item_state = "utility"
	storage_slots = 7
	max_w_class = 3
	slot_flags = SLOT_BELT
	attack_verb = list("whipped", "lashed", "disciplined")
	sprite_sheets = list(
		BODYTYPE_OCTOPUS = 'icons/mob/species/octopus/belt.dmi',
		BODYTYPE_CORVID = 'icons/mob/species/corvid/belt.dmi'
		)
	var/show_above_suit = 0

/obj/item/storage/belt/verb/toggle_layer()
	set name = "Switch Belt Layer"
	set category = "Object"

	if(show_above_suit == -1)
		usr << "<span class='notice'>\The [src] cannot be worn above your suit!</span>"
		return
	show_above_suit = !show_above_suit
	update_icon()

/obj/item/storage/update_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_belt()


/obj/item/storage/belt/get_mob_overlay(mob/user_mob, slot)
	var/image/ret = ..()
	var/overlay_icon
	if(ishuman(user_mob))
		var/mob/living/carbon/human/H = user_mob
		overlay_icon = sprite_sheets[H.species.get_bodytype(H)]
	if(!overlay_icon)
		overlay_icon = 'icons/mob/belt.dmi'
	if(slot == slot_belt_str && contents.len)
		for(var/obj/item/I in contents)
			ret.overlays += image("icon" = overlay_icon, "icon_state" = "[I.item_state ? I.item_state : I.icon_state]")
	return ret

/obj/item/storage/belt/utility
	name = "tool-belt" //Carn: utility belt is nicer, but it bamboozles the text parsing.
	desc = "Can hold various tools."
	icon_state = "utilitybelt"
	item_state = "utility"
	can_hold = list(
		///obj/item/combitool,
		/obj/item/crowbar,
		/obj/item/screwdriver,
		/obj/item/weldingtool,
		/obj/item/wirecutters,
		/obj/item/wrench,
		/obj/item/multitool,
		/obj/item/flashlight,
		/obj/item/stack/cable_coil,
		/obj/item/t_scanner,
		/obj/item/analyzer,
		/obj/item/taperoll/engineering,
		/obj/item/robotanalyzer,
		/obj/item/material/minihoe,
		/obj/item/material/hatchet,
		/obj/item/analyzer/plant_analyzer,
		/obj/item/extinguisher/mini
		)


/obj/item/storage/belt/utility/full/New()
	..()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/wirecutters(src)
	new /obj/item/stack/cable_coil(src,30,pick("red","yellow","orange"))


/obj/item/storage/belt/utility/atmostech/New()
	..()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/wirecutters(src)
	new /obj/item/t_scanner(src)



/obj/item/storage/belt/medical
	name = "medical belt"
	desc = "Can hold various medical equipment."
	icon_state = "medicalbelt"
	item_state = "medical"
	can_hold = list(
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/glass/beaker,
		/obj/item/reagent_containers/glass/bottle,
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/flame/lighter/zippo,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/flashlight/pen,
		/obj/item/clothing/mask/surgical,
		/obj/item/clothing/head/surgery,
		/obj/item/clothing/gloves/latex,
		/obj/item/reagent_containers/hypospray,
		/obj/item/clothing/glasses/hud/health,
		/obj/item/crowbar,
		/obj/item/flashlight,
		/obj/item/extinguisher/mini
		)

/obj/item/storage/belt/medical/emt
	name = "EMT utility belt"
	desc = "A sturdy black webbing belt with attached pouches."
	icon_state = "emsbelt"
	item_state = "emsbelt"

/obj/item/storage/belt/security
	name = "security belt"
	desc = "Can hold security gear like handcuffs and flashes."
	icon_state = "securitybelt"
	item_state = "security"
	can_hold = list(
		/obj/item/grenade,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/handcuffs,
		/obj/item/flash,
		/obj/item/clothing/glasses,
		/obj/item/ammo_casing/shotgun,
		/obj/item/ammo_magazine,
		/obj/item/reagent_containers/food/snacks/donut/,
		/obj/item/melee/baton,
		/obj/item/flame/lighter,
		/obj/item/clothing/glasses/hud/security,
		/obj/item/flashlight,
		/obj/item/radio/headset/pda,
		/obj/item/radio/headset,
		/obj/item/hailer,
		/obj/item/megaphone,
		/obj/item/melee,
		/obj/item/gun/composite/premade/pistol/a38/preloaded,
		/obj/item/taperoll/police
		)

/obj/item/storage/belt/champion
	name = "championship belt"
	desc = "Proves to the world that you are the strongest!"
	icon_state = "championbelt"
	item_state = "champion"
	storage_slots = 1
	can_hold = list(
		/obj/item/clothing/mask/luchador
		)

/obj/item/storage/belt/security/tactical
	name = "combat belt"
	desc = "Can hold security gear like handcuffs and flashes, with more pouches for more storage."
	icon_state = "swatbelt"
	item_state = "swatbelt"
	storage_slots = 9
