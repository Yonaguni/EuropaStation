/obj/item/weapon/storage/belt
	name = "belt"
	desc = "Can hold various things."
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "utilitybelt"
	item_state = "utility"
	storage_slots = 7
	max_w_class = 3
	max_storage_space = 28
	slot_flags = SLOT_BELT
	attack_verb = list("whipped", "lashed", "disciplined")
	var/show_above_suit = 0

/obj/item/weapon/storage/belt/update_icon()
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_belt()
