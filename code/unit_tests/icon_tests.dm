// Items that are unsafe to spawn with no loc, or without additional specialized args.
// These are usually intermediary types not intended to be spawned, or internal types
// that are meant to make up a component of some other object.
GLOBAL_LIST_INIT(icon_test_skip_types, list(
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
	/obj/item/underwear/undershirt,
	/obj/item/stack/material
))
// Types that should be skipped along with all descendants.
GLOBAL_LIST_INIT(icon_test_skip_types_and_subtypes, list(
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
))

/datum/unit_test/icon_test
	name = "ICON STATE template"

/datum/unit_test/icon_test/robots_shall_have_eyes_for_each_state
	name = "ICON STATE - Robot shall have eyes for each icon state"
	var/list/excepted_icon_states_ = list(
		"b1","b1+o","b2","b2+o","b3","b3+o","d1","d1+o","d2","d2+o","d3","d3+o",
		"floor1","floor2","floor3","floor4","floor5","floor6","floor7",
		"gib1","gib2","gib3","gib4","gib5","gib6","gib7","gibdown","gibup","gibbl1","gibarm","gibleg",
		"streak1","streak2","streak3","streak4","streak5",
		"droid-combat-roll","droid-combat-shield","emag","remainsrobot", "robot+o+c","robot+o-c","robot+we")

/datum/unit_test/icon_test/robots_shall_have_eyes_for_each_state/start_test()
	var/missing_states = 0
	var/list/valid_states = icon_states('icons/mob/robots.dmi')

	var/list/original_valid_states = valid_states.Copy()
	for(var/icon_state in valid_states)
		if(icon_state in excepted_icon_states_)
			continue
		if(starts_with(icon_state, "eyes-"))
			continue
		if(findtext(icon_state, "openpanel"))
			continue
		var/eye_icon_state = "eyes-[icon_state]"
		if(!(eye_icon_state in valid_states))
			log_unit_test("Eye icon state [eye_icon_state] is missing.")
			missing_states++

	if(missing_states)
		fail("[missing_states] eye icon state\s [missing_states == 1 ? "is" : "are"] missing.")
		var/list/difference = uniquemergelist(original_valid_states, valid_states)
		if(difference.len)
			log_unit_test("[ascii_yellow]---  DEBUG  --- ICON STATES AT START: " + jointext(original_valid_states, ",") + "[ascii_reset]")
			log_unit_test("[ascii_yellow]---  DEBUG  --- ICON STATES AT END: "   + jointext(valid_states, ",") + "[ascii_reset]")
			log_unit_test("[ascii_yellow]---  DEBUG  --- UNIQUE TO EACH LIST: " + jointext(difference, ",") + "[ascii_reset]")
	else
		pass("All related eye icon states exists.")
	return 1

/datum/unit_test/icon_test/sprite_accessories_shall_have_existing_icon_states
	name = "ICON STATE - Sprite accessories shall have existing icon states"

/datum/unit_test/icon_test/sprite_accessories_shall_have_existing_icon_states/start_test()
	var/sprite_accessory_subtypes = list(
		/datum/sprite_accessory/hair,
		/datum/sprite_accessory/facial_hair
	)

	var/list/failed_sprite_accessories = list()
	var/icon_state_cache = list()
	var/duplicates_found = FALSE

	for(var/sprite_accessory_main_type in sprite_accessory_subtypes)
		var/sprite_accessories_by_name = list()
		for(var/sprite_accessory_type in subtypesof(sprite_accessory_main_type))
			var/failed = FALSE
			var/datum/sprite_accessory/sat = sprite_accessory_type

			var/sat_name = initial(sat.name)
			if(sat_name)
				group_by(sprite_accessories_by_name, sat_name, sat)
			else
				failed = TRUE
				log_bad("[sat] - Did not have a name set.")

			var/sat_icon = initial(sat.icon)
			if(sat_icon)
				var/sat_icon_states = icon_state_cache[sat_icon]
				if(!sat_icon_states)
					sat_icon_states = icon_states(sat_icon)
					icon_state_cache[sat_icon] = sat_icon_states

				var/sat_icon_state = initial(sat.icon_state)
				if(sat_icon_state)
					sat_icon_state = "[sat_icon_state]_s"
					if(!(sat_icon_state in sat_icon_states))
						failed = TRUE
						log_bad("[sat] - \"[sat_icon_state]\" did not exist in '[sat_icon]'.")
				else
					failed = TRUE
					log_bad("[sat] - Did not have an icon state set.")
			else
				failed = TRUE
				log_bad("[sat] - Did not have an icon set.")

			if(failed)
				failed_sprite_accessories += sat

		if(number_of_issues(sprite_accessories_by_name, "Sprite Accessory Names"))
			duplicates_found = TRUE

	if(failed_sprite_accessories.len || duplicates_found)
		fail("One or more sprite accessory issues detected.")
	else
		pass("All sprite accessories were valid.")

	return 1

/datum/unit_test/icon_test/posters_shall_have_icon_states
	name = "ICON STATE - Posters Shall Have Icon States"

/datum/unit_test/icon_test/posters_shall_have_icon_states/start_test()
	var/contraband_icons = icon_states('icons/obj/contraband.dmi')
	var/list/invalid_posters = list()

	for(var/poster_type in subtypesof(/decl/poster))
		var/decl/poster/P = decls_repository.get_decl(poster_type)
		if(!(P.icon_state in contraband_icons))
			invalid_posters += poster_type

	if(invalid_posters.len)
		fail("/decl/poster with missing icon states: [english_list(invalid_posters)]")
	else
		pass("All /decl/poster subtypes have valid icon states.")
	return 1

/datum/unit_test/icon_test/item_modifiers_shall_have_icon_states
	name = "ICON STATE - Item Modifiers Shall Have Icon States"
	var/list/icon_states_by_type

/datum/unit_test/icon_test/item_modifiers_shall_have_icon_states/start_test()
	var/list/bad_modifiers = list()
	var/item_modifiers = list_values(decls_repository.get_decls(/decl/item_modifier))

	for(var/im in item_modifiers)
		var/decl/item_modifier/item_modifier = im
		for(var/type_setup_type in item_modifier.type_setups)
			var/list/type_setup = item_modifier.type_setups[type_setup_type]
			var/list/icon_states = icon_states_by_type[type_setup_type]

			if(!icon_states)
				var/obj/item/I = type_setup_type
				icon_states = icon_states(initial(I.icon))
				LAZYSET(icon_states_by_type, type_setup_type, icon_states)

			if(!(type_setup["icon_state"] in icon_states))
				bad_modifiers += type_setup_type

	if(bad_modifiers.len)
		fail("Item modifiers with missing icon states: [english_list(bad_modifiers)]")
	else
		pass("All item modifiers have valid icon states.")
	return 1

/datum/unit_test/icon_test/items_shall_have_valid_icon_states
	name = "ICON STATE - Items Shall Have Valid Icon States"

/datum/unit_test/icon_test/items_shall_have_valid_icon_states/New()
	for(var/thing in GLOB.icon_test_skip_types_and_subtypes)
		GLOB.icon_test_skip_types |= typesof(thing)
	..()

/datum/unit_test/icon_test/items_shall_have_valid_icon_states/start_test()
	var/list/no_base_icon = list()
	for(var/thing in subtypesof(/obj/item) - GLOB.icon_test_skip_types)
		var/obj/item/checking = new thing
		var/check_icon = checking.icon
		if(!check_icon)
			no_base_icon += "[checking.type] - no base icon"
		else
			var/check_icon_state = checking.icon_state
			if(!check_icon_state)
				no_base_icon |= "[checking.type] - no base icon_state"
			else if(!(check_icon_state in icon_states(check_icon)))
				no_base_icon |= "[checking.type] - [check_icon_state] not in states for [check_icon]"
			else
				for(var/otherthing in (checking.overlays|checking.underlays))
					if(istype(otherthing, /image))
						var/image/I = otherthing
						if(!(I.icon_state in icon_states(I.icon)))
							no_base_icon |= "[checking.type] - image overlay/underlay state [I.icon_state] not in states for [I.icon]"
					else if(istext(otherthing) && !(otherthing in icon_states(check_icon)))
						no_base_icon |= "[checking.type] - string overlay/underlay [otherthing] not in states for [check_icon]"

		qdel(checking)

	if(LAZYLEN(no_base_icon))
		fail("Some items are missing icons or icon_states:\n[jointext(no_base_icon, "\n")]")
	else
		pass("All items have valid icons and icon_states.")
	return 1

/datum/admins/proc/cmd_debug_item_icons()
	set name = "List Unused Worn/Overlay States"
	set category = "Debug"

	if(!check_rights(R_SERVER)) // Check R_SERVER since we're writing locally.
		return

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

	for(var/thing in GLOB.icon_test_skip_types_and_subtypes)
		GLOB.icon_test_skip_types |= typesof(thing)

	for(var/thing in subtypesof(/obj/item) - GLOB.icon_test_skip_types)

		var/obj/item/checking = new thing
		var/check_flags =      checking.slot_flags
		var/check_icon =       checking.icon
		var/check_icon_state = checking.icon_state
		if(check_icon && check_icon_state)
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

		for(var/otherthing in (checking.overlays|checking.underlays))
			var/overlay_icon
			var/overlay_state
			if(istype(otherthing, /image))
				var/image/I = otherthing
				overlay_icon = I.icon
				overlay_state = I.icon_state
			else if(istext(otherthing))
				overlay_icon = checking.icon
				overlay_state = otherthing
			if(!(overlay_state in icon_states(overlay_icon)))
				broken_items |= "overlay/underlay state [overlay_state] not found in [overlay_icon]"
			else
				if(!found_states_for_icons[overlay_icon])
					found_states_for_icons[overlay_icon] = list() 
				found_states_for_icons[overlay_icon] |= overlay_state

		qdel(checking)

	var/lines = list("Checking item icons...<br>")
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
