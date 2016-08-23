// Switch this out to use a database at some point. Each ckey is
// associated with a list of custom item datums. When the character
// spawns, the list is checked and all appropriate datums are spawned.
// See config/example/custom_items.txt for a more detailed overview
// of how the config system works.

// CUSTOM ITEM ICONS:
// Inventory icons must be in CUSTOM_ITEM_OBJ with state name [item_icon].
// On-mob icons must be in CUSTOM_ITEM_MOB with state name [item_icon].
// Inhands must be in CUSTOM_ITEM_MOB as [icon_state]_l and [icon_state]_r.

// Kits must have mech icons in CUSTOM_ITEM_OBJ under [kit_icon].

// Broken must be [kit_icon]-broken and open must be [kit_icon]-open.

// Kits must also have hardsuit icons in CUSTOM_ITEM_MOB as [kit_icon]_suit
// and [kit_icon]_helmet, and in CUSTOM_ITEM_OBJ as [kit_icon].

/var/list/custom_items = list()

/datum/custom_item
	var/assoc_key
	var/character_name
	var/inherit_inhands = 1 //if unset, and inhands are not provided, then the inhand overlays will be invisible.
	var/item_icon
	var/item_desc
	var/name
	var/item_path = /obj/item
	var/req_access = 0
	var/list/req_titles = list()
	var/kit_name
	var/kit_desc
	var/kit_icon
	var/additional_data

/datum/custom_item/proc/spawn_item(var/newloc)
	var/obj/item/citem = new item_path(newloc)
	apply_to_item(citem)
	return citem

/datum/custom_item/proc/apply_to_item(var/obj/item/item)
	if(!item)
		return
	if(name)
		item.name = name
	if(item_desc)
		item.desc = item_desc
	if(item_icon)
		if(!istype(item))
			item.icon = CUSTOM_ITEM_OBJ
			item.icon_state = item_icon
			return
		else
			if(inherit_inhands)
				apply_inherit_inhands(item)
			else
				item.item_state_slots = null
				item.item_icons = null

			item.icon = CUSTOM_ITEM_OBJ
			item.icon_state = item_icon
			item.item_state = null
			item.icon_override = CUSTOM_ITEM_MOB

	// Kits are dumb so this is going to have to be hardcoded/snowflake.
	if(istype(item, /obj/item/device/kit))
		var/obj/item/device/kit/K = item
		K.new_name = kit_name
		K.new_desc = kit_desc
		K.new_icon = kit_icon
		K.new_icon_file = CUSTOM_ITEM_OBJ
		if(istype(item, /obj/item/device/kit/suit))
			var/obj/item/device/kit/suit/kit = item
			kit.new_light_overlay = additional_data
			kit.new_mob_icon_file = CUSTOM_ITEM_MOB

	return item

/datum/custom_item/proc/apply_inherit_inhands(var/obj/item/item)
	var/list/new_item_icons = list()
	var/list/new_item_state_slots = list()

	var/list/available_states = icon_states(CUSTOM_ITEM_MOB)

	//If l_hand or r_hand are not present, preserve them using item_icons/item_state_slots
	//Then use icon_override to make every other slot use the custom sprites by default.
	//This has to be done before we touch any of item's vars
	if(!("[item_icon]_l" in available_states))
		new_item_state_slots[slot_l_hand_str] = get_state(item, slot_l_hand_str, "_l")
		new_item_icons[slot_l_hand_str] = get_icon(item, slot_l_hand_str, 'icons/mob/items/lefthand.dmi')
	if(!("[item_icon]_r" in available_states))
		new_item_state_slots[slot_r_hand_str] = get_state(item, slot_r_hand_str, "_r")
		new_item_icons[slot_r_hand_str] = get_icon(item, slot_r_hand_str, 'icons/mob/items/righthand.dmi')

	item.item_state_slots = new_item_state_slots
	item.item_icons = new_item_icons

//this has to mirror the way update_inv_*_hand() selects the state
/datum/custom_item/proc/get_state(var/obj/item/item, var/slot_str, var/hand_str)
	var/t_state
	if(item.item_state_slots && item.item_state_slots[slot_str])
		t_state = item.item_state_slots[slot_str]
	else if(item.item_state)
		t_state = item.item_state
	else
		t_state = item.icon_state
	if(item.icon_override)
		t_state += hand_str
	return t_state

//this has to mirror the way update_inv_*_hand() selects the icon
/datum/custom_item/proc/get_icon(var/obj/item/item, var/slot_str, var/icon/hand_icon)
	var/icon/t_icon
	if(item.icon_override)
		t_icon = item.icon_override
	else if(item.item_icons && (slot_str in item.item_icons))
		t_icon = item.item_icons[slot_str]
	else
		t_icon = hand_icon
	return t_icon