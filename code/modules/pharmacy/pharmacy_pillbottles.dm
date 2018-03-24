obj/item/storage/pill_bottle
	name = "bottle of pills"
	desc = "It's an airtight container for storing medication."
	icon_state = "pill_canister"
	icon = 'icons/obj/chemical.dmi'
	item_state = "contsolid"
	w_class = 2
	max_w_class = 1
	max_storage_space = 7
	can_hold = list(/obj/item/reagent_containers/pill,/obj/item/dice,/obj/item/paper)
	allow_quick_gather = 1
	use_to_pickup = 1
	use_sound = null

	var/medication_name
	var/actual_reagent_name
	var/obfuscate_contents = TRUE

/obj/item/storage/pill_bottle/get_default_codex_value(var/mob/user)
	return (HAS_ASPECT(user, ASPECT_PHARMACIST) && !isnull(actual_reagent_name)) ? "[actual_reagent_name] (chemical)" : ..()

/obj/item/storage/pill_bottle/Initialize()
	. = ..()

	if(obfuscate_contents)
		for(var/obj/item/reagent_containers/pill/P in contents)
			if(P.obfuscate_contents && P.reagents)
				var/reagent_id = P.reagents.get_master_reagent_id()
				if(!isnull(reagent_id))
					actual_reagent_name = P.reagents.get_master_reagent_name()
					medication_name = get_random_medication_name_for_reagent(reagent_id)
					break

		if(!isnull(medication_name))
			if(!medicine_name_to_bottle_label[medication_name])
				var/image/I = image(icon, "pill_canister_label")
				if(isnull(medicine_name_to_color[medication_name]))
					medicine_name_to_color[medication_name] = get_random_colour()
				I.color = medicine_name_to_color[medication_name]
				medicine_name_to_bottle_label[medication_name] = I
			add_overlay(medicine_name_to_bottle_label[medication_name])
			name = "bottle of [medication_name] pills"

	if(isnull(medication_name))
		add_overlay(image(icon, "pill_canister_label"))

/obj/item/storage/pill_bottle/examine(var/mob/user)
	..(user, 1)
	if(!isnull(actual_reagent_name) && HAS_ASPECT(user, ASPECT_PHARMACIST))
		to_chat(user, "<span class='notice'>As far as you know, the active ingredient is <b>[actual_reagent_name]</b>.</span>")
