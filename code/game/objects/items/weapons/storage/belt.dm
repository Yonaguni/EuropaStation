#define BELT_OVERLAY_ITEMS		1
#define BELT_OVERLAY_HOLSTER	2

/obj/item/weapon/storage/belt
	name = "belt"
	desc = "Can hold various things."
	icon = 'icons/obj/clothing/obj_belt.dmi'
	icon_state = "utilitybelt"
	item_state = "utility"
	storage_slots = 7
	item_flags = ITEM_FLAG_IS_BELT
	max_w_class = ITEM_SIZE_NORMAL
	slot_flags = SLOT_BELT
	var/overlay_flags
	attack_verb = list("whipped", "lashed", "disciplined")

/obj/item/weapon/storage/belt/verb/toggle_layer()
	set name = "Switch Belt Layer"
	set category = "Object"

	use_alt_layer = !use_alt_layer
	update_icon()

/obj/item/weapon/storage/belt/on_update_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_belt()

	overlays.Cut()
	if(overlay_flags & BELT_OVERLAY_ITEMS)
		for(var/obj/item/I in contents)
			overlays += image('icons/obj/clothing/obj_belt_overlays.dmi', "[I.icon_state]")

/obj/item/weapon/storage/belt/get_mob_overlay(mob/user_mob, slot)
	var/image/ret = ..()
	if(slot == slot_belt_str && contents.len)
		var/list/ret_overlays = list()
		for(var/obj/item/I in contents)
			var/use_state = (I.item_state ? I.item_state : I.icon_state)
			if(ishuman(user_mob))
				var/mob/living/carbon/human/H = user_mob
				ret_overlays += H.species.get_offset_overlay_image(FALSE, 'icons/mob/onmob/onmob_belt.dmi', use_state, I.color, slot)
			else
				ret_overlays += overlay_image('icons/mob/onmob/onmob_belt.dmi', use_state, I.color, RESET_COLOR)
			ret.overlays += ret_overlays
	return ret

/obj/item/weapon/storage/belt/holster
	name = "holster belt"
	icon_state = "holsterbelt"
	item_state = "holster"
	desc = "Can holster various things."
	storage_slots = 2
	overlay_flags = BELT_OVERLAY_ITEMS|BELT_OVERLAY_HOLSTER
	var/list/can_holster //List of objects which this item can store in the designated holster slot(if unset, it will default to any holsterable items)
	var/sound_in = 'sound/effects/holster/holsterin.ogg'
	var/sound_out = 'sound/effects/holster/holsterout.ogg'
	can_hold = list(
		/obj/item/weapon/melee/baton,
		/obj/item/weapon/melee/telebaton
		)

/obj/item/weapon/storage/belt/holster/Initialize()
	. = ..()
	set_extension(src, /datum/extension/holster, /datum/extension/holster, src, sound_in, sound_out, can_holster)

/obj/item/weapon/storage/belt/holster/attackby(obj/item/W as obj, mob/user as mob)
	var/datum/extension/holster/H = get_extension(src, /datum/extension/holster)
	if(H.holster(W, user))
		return
	else
		. = ..(W, user)

/obj/item/weapon/storage/belt/holster/attack_hand(mob/user as mob)
	var/datum/extension/holster/H = get_extension(src, /datum/extension/holster)
	if(H.unholster(user))
		return
	else
		. = ..(user)

/obj/item/weapon/storage/belt/holster/examine(mob/user)
	. = ..(user)
	var/datum/extension/holster/H = get_extension(src, /datum/extension/holster)
	H.examine_holster(user)

/obj/item/weapon/storage/belt/holster/on_update_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_belt()

	overlays.Cut()
	var/datum/extension/holster/H = get_extension(src, /datum/extension/holster)
	if(overlay_flags)
		for(var/obj/item/I in contents)
			if(I == H.holstered)
				if(overlay_flags & BELT_OVERLAY_HOLSTER)
					overlays += image('icons/obj/clothing/obj_belt_overlays.dmi', "[I.icon_state]")
			else if(overlay_flags & BELT_OVERLAY_ITEMS)
				overlays += image('icons/obj/clothing/obj_belt_overlays.dmi', "[I.icon_state]")

/obj/item/weapon/storage/belt/holster/police
	name = "holster belt"
	desc = "Can hold police gear like handcuffs and flashes. This one has a convenient holster."
	icon_state = "securitybelt"
	item_state = "security"
	storage_slots = 8
	overlay_flags = BELT_OVERLAY_ITEMS|BELT_OVERLAY_HOLSTER
	can_hold = list(
		/obj/item/weapon/crowbar,
		/obj/item/weapon/grenade,
		/obj/item/weapon/reagent_containers/spray/pepper,
		/obj/item/weapon/handcuffs,
		/obj/item/device/flash,
		/obj/item/clothing/glasses,
		/obj/item/ammo_casing/shotgun,
		/obj/item/ammo_magazine,
		/obj/item/weapon/reagent_containers/food/snacks/donut/,
		/obj/item/weapon/melee/baton,
		/obj/item/weapon/melee/telebaton,
		/obj/item/weapon/flame/lighter,
		/obj/item/device/flashlight,
		/obj/item/modular_computer/pda,
		/obj/item/device/radio/headset,
		/obj/item/device/hailer,
		/obj/item/device/megaphone,
		/obj/item/weapon/melee,
		/obj/item/taperoll,
		/obj/item/device/holowarrant,
		/obj/item/weapon/magnetic_ammo,
		/obj/item/device/binoculars,
		/obj/item/clothing/gloves
		)