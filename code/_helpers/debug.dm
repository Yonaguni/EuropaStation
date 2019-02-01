/datum/admins/proc/cmd_debug_item_icons()
	set name = "Debug Item Icons"
	set category = "Debug"

	if(!check_rights(R_SERVER)) // Check R_SERVER since we're writing locally.
		return

	var/list/no_base_icon = list()
	var/list/broken_items = list()
	var/list/found_states_for_icons = list()

	// Overlays, etc. that should not be considered 'unused'.
	var/list/reserved_states = list(
		'icons/obj/clothing/obj_under.dmi' = list(
			"jumpsuit_stripe",
			"jumpsuit_d",
			"jumpsuit_d_stripe",
			"jumpsuit_d_collar",
			"jumpsuit_collar"
		)
	)
	// Items that are unsafe to spawn with no loc, or without additional specialized args.
	// These are usually intermediary types not intended to be spawned, or internal types
	// that are meant to make up a component of some other object.
	var/list/skip_types = list(
		/obj/item,
		/obj/item/weapon,
		/obj/item/weapon/engine,
		/obj/item/toy,
		/obj/item/toy/desk,
		/obj/item/trash,
		/obj/item/device,
		/obj/item/device/tankassemblyproxy,
		/obj/item/device/assembly,
		/obj/item/robot_rack,
		/obj/item/rig_module,
		/obj/item/instrument,
		/obj/item/device/synthesized_instrument,
		/obj/item/weapon/reagent_containers/pill/pouch_pill,
		/obj/item/weapon/storage,
		/obj/item/weapon/storage/fancy,
		/obj/item/ai_verbs,
		/obj/item/rig_module/device,
		/obj/item/voice_changer,
		/obj/item/seeds,
		/obj/item/seeds/cutting,
		/obj/item/weapon/grown,
		/obj/item/weapon/contraband,
		/obj/item/weapon/grenade/flashbang/cluster,
		/obj/item/weapon/grenade/flashbang/clusterbang/segment,
		/obj/item/organ,
		/obj/item/organ/internal,
		/obj/item/organ/internal/augment,
		/obj/item/organ/internal/augment/active,
		/obj/item/organ/internal/augment/active/simple,
		/obj/item/sign,
		/obj/item/weapon/holo,
		/obj/item/assembly,
		/obj/item/weapon/stock_parts,
		/obj/item/weapon/stock_parts/subspace,
		/obj/item/weapon/melee,
		/obj/item/weapon/melee/energy,
		/obj/item/weapon/material,
		/obj/item/weapon/material/kitchen/utensil,
		/obj/item/weapon/material/kitchen,
		/obj/item/weapon/material/shrapnel,
		/obj/item/weapon/material/twohanded,
		/obj/item/weapon/material/lock_construct,
		/obj/item/weapon/flame,
		/obj/item/trash/cigbutt,
		/obj/item/weapon/toy,
		/obj/item/weapon/computer_hardware,
		/obj/item/weapon/module,
		/obj/item/rig_module,
		/obj/item/weapon/glass_extra,
		/obj/item/weapon/storage/secure,
		/obj/item/weapon/reagent_containers,
		/obj/item/weapon/reagent_containers/glass,
		/obj/item/weapon/reagent_containers/food,
		/obj/item/weapon/reagent_containers/food/snacks,
		/obj/item/weapon/reagent_containers/food/snacks/variable,
		/obj/item/weapon/reagent_containers/food/snacks/old,
		/obj/item/weapon/reagent_containers/food/drinks,
		/obj/item/weapon/reagent_containers/food/snacks/human,
		/obj/item/weapon/reagent_containers/food/snacks/pie,
		/obj/item/weapon/reagent_containers/food/snacks/fruit_slice,
		/obj/item/weapon/reagent_containers/food/snacks/slice,
		/obj/item/weapon/reagent_containers/food/snacks/sliceable,
		/obj/item/weapon/reagent_containers/food/snacks/sliceable/pizza,
		/obj/item/weapon/reagent_containers/food/drinks/cans,
		/obj/item/weapon/reagent_containers/food/drinks/bottle,
		/obj/item/weapon/reagent_containers/food/drinks/bottle/small,
		/obj/item/clothing,
		/obj/item/clothing/under,
		/obj/item/clothing/under/lower,
		/obj/item/clothing/under/upper,
		/obj/item/clothing/head,
		/obj/item/clothing/suit,
		/obj/item/clothing/suit/storage,
		/obj/item/clothing/suit/storage/hooded,
		/obj/item/clothing/suit/storage/toggle,
		/obj/item/clothing/glasses,
		/obj/item/clothing/glasses/hud,
		/obj/item/clothing/gloves,
		/obj/item/clothing/ears,
		/obj/item/clothing/ring,
		/obj/item/clothing/mask,
		/obj/item/clothing/mask/smokable,
		/obj/item/clothing/mask/smokable/ecig,
		/obj/item/clothing/mask/chewable,
		/obj/item/weapon/shield,
		/obj/item/weapon/tank,
		/obj/item/weapon/rig,
		/obj/item/weapon/forensics,
		/obj/item/weapon/sample,
		/obj/item/weapon/spacecash/bundle,
		/obj/item/weapon/light,
		/obj/item/stack,
		/obj/item/stack/medical,
		/obj/item/stack/medical/advanced,
		/obj/item/stack/tile,
		/obj/item/stack/flag,
		/obj/item/inflatable,
		/obj/item/underwear,
		/obj/item/underwear/socks,
		/obj/item/underwear/top,
		/obj/item/underwear/bottom,
		/obj/item/underwear/undershirt
	)

	// Types that should be skipped along with all descendants.
	var/list/skip_types_and_subtypes = list(
		/obj/item/proxy_debug,
		/obj/item/weapon/gun,
		/obj/item/weapon/hand,
		/obj/item/weapon/storage/internal,
		/obj/item/weapon/robot_module,
		/obj/item/device/radio/borg,
		/obj/item/device/radio/announcer,
		/obj/item/device/uplink,
		/obj/item/grab,
		/obj/item/borg,
		/obj/item/weapon/holder,
		/obj/item/weapon/stool,
		/obj/item/modular_computer,
		/obj/item/organ/external
	)

	for(var/thing in skip_types_and_subtypes)
		skip_types |= typesof(thing)

	for(var/thing in subtypesof(/obj/item) - skip_types)

		var/obj/item/checking = new thing
		var/check_flags =      checking.slot_flags
		var/check_icon =       checking.icon
		var/check_icon_state = checking.icon_state

		if(!check_icon)
			no_base_icon += "[checking.type] - no base icon"
		else if(!check_icon_state)
			no_base_icon += "[checking.type] - no base icon_state"
		else if(!(check_icon_state in icon_states(check_icon)))
			no_base_icon |= "[checking.type] - [check_icon_state] not in states for [check_icon]"
		else
			if(!found_states_for_icons[check_icon])
				found_states_for_icons[check_icon] = list() 
			found_states_for_icons[check_icon] |= check_icon_state
		
		var/check_mob_state = checking.item_state
		if(!check_mob_state && check_icon_state)
			check_mob_state = check_icon_state

		check_worn_icon_states(checking.item_icons, slot_l_hand_str, check_mob_state, broken_items, found_states_for_icons)
		check_worn_icon_states(checking.item_icons, slot_r_hand_str, check_mob_state, broken_items, found_states_for_icons)
		if(check_flags & SLOT_OCLOTHING)
			check_worn_icon_states(checking.item_icons, slot_wear_suit_str, check_mob_state, broken_items, found_states_for_icons)
		if(check_flags & SLOT_ICLOTHING)
			check_worn_icon_states(checking.item_icons, slot_w_uniform_str, check_mob_state, broken_items, found_states_for_icons)
		if(check_flags & SLOT_GLOVES)
			check_worn_icon_states(checking.item_icons, slot_gloves_str, check_mob_state, broken_items, found_states_for_icons)
		if(check_flags & SLOT_EYES)
			check_worn_icon_states(checking.item_icons, slot_glasses_str, check_mob_state, broken_items, found_states_for_icons)
		if(check_flags & SLOT_EARS)
			check_worn_icon_states(checking.item_icons, slot_l_ear_str, check_mob_state, broken_items, found_states_for_icons)
			check_worn_icon_states(checking.item_icons, slot_r_ear_str, check_mob_state, broken_items, found_states_for_icons)
		if(check_flags & SLOT_MASK)
			check_worn_icon_states(checking.item_icons, slot_wear_mask_str, check_mob_state, broken_items, found_states_for_icons)
		if(check_flags & SLOT_HEAD)
			check_worn_icon_states(checking.item_icons, slot_head_str, check_mob_state, broken_items, found_states_for_icons)
		if(check_flags & SLOT_FEET)
			check_worn_icon_states(checking.item_icons, slot_shoes_str, check_mob_state, broken_items, found_states_for_icons)
		if(check_flags & SLOT_ID)
			check_worn_icon_states(checking.item_icons, slot_wear_id_str, check_mob_state, broken_items, found_states_for_icons)
		if(check_flags & SLOT_BELT)
			check_worn_icon_states(checking.item_icons, slot_belt_str, check_mob_state, broken_items, found_states_for_icons)
		if(check_flags & SLOT_BACK)
			check_worn_icon_states(checking.item_icons, slot_back_str, check_mob_state, broken_items, found_states_for_icons)
		if(check_flags & SLOT_TIE)
			check_worn_icon_states(checking.item_icons, slot_tie_str, check_mob_state, broken_items, found_states_for_icons)

		qdel(checking)

	var/lines = list()
	lines += "Checking item icons...<br>"

	if(LAZYLEN(no_base_icon))
		lines += "Missing base icons:<br>[jointext(no_base_icon, "<br>")]"

	if(LAZYLEN(broken_items))
		lines += "Broken worn icons:<br>[jointext(broken_items, "<br>")]"

	if(LAZYLEN(found_states_for_icons))
		lines += "<br>Unused states:<br>"
		for(var/check_icon in found_states_for_icons)
			var/list/check_states = icon_states(check_icon)
			for(var/state in found_states_for_icons[check_icon])
				check_states -= state
			if(reserved_states[check_icon])
				check_states -= reserved_states[check_icon]
			if(LAZYLEN(check_states))
				lines += "<br>[check_icon]:<br>- [jointext(check_states, "<br>- ")]"
	lines += "<br>Done."

	var/save_path = "data/item_icon_debug.txt"
	to_chat(usr, "Wrote icon debug to file '[save_path]'.")
	var/list/write_text = jointext(lines, "\n")
	write_text = replacetext(write_text, "<br>", "\n")
	text2file(write_text, save_path)

/proc/check_worn_icon_states(var/list/check_icons, var/slot_str, var/check_state, var/list/results, var/list/additional_results)
	var/check_icon
	if(!islist(check_icons) || !check_icons[slot_str])
		check_icon = default_onmob_icons[slot_str]
	else
		check_icon = check_icons[slot_str]
	if(check_icon)
		if(!(check_state in icon_states(check_icon)))
			results |= "item_state [check_state] not found in [check_icon]"
		else
			if(!additional_results[check_icon])
				additional_results[check_icon] = list() 
			additional_results[check_icon] |= check_state
