//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:31

/obj/item/weapon/airlock_electronics
	name = "airlock electronics"
	icon = 'icons/obj/doors/door_assembly.dmi'
	icon_state = "door_electronics"
	w_class = ITEM_SIZE_SMALL //It should be tiny! -Agouri

	matter = list(MATERIAL_STEEL = 50,MATERIAL_GLASS = 50)

	req_access = list(access_engine)

	var/secure = 0 //if set, then wires will be randomized and bolts will drop if the door is broken
	var/list/conf_access = list()
	var/one_access = 0 //if set to 1, door would receive req_one_access instead of req_access
	var/last_configurator = null
	var/locked = 1
	var/lockable = 1

/obj/item/weapon/airlock_electronics/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = 1, var/master_ui = null, var/datum/topic_state/state = GLOB.default_state)

	var/list/data = list()
	var/list/regions = list()

	for(var/i in ACCESS_REGION_SECURITY to ACCESS_REGION_SUPPLY) //code/game/jobs/_access_defs.dm
		var/list/region = list()
		var/list/accesses = list()
		for(var/j in get_region_accesses(i))
			var/list/access = list()
			access["name"] = get_access_desc(j)
			access["id"] = j
			access["req"] = (j in src.conf_access)
			accesses[++accesses.len] = access
		region["name"] = get_region_accesses_name(i)
		region["accesses"] = accesses
		regions[++regions.len] = region
	data["regions"] = regions
	data["oneAccess"] = one_access
	data["locked"] = locked
	data["lockable"] = lockable

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "airlock_electronics.tmpl", src.name, 325, 625, master_ui = master_ui, state = state)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/item/weapon/airlock_electronics/OnTopic(var/mob/user, href_list, var/datum/topic_state/state)
	if(href_list["clear"])
		conf_access = list()
		one_access = 0
		. = TRUE
	if(href_list["one_access"])
		one_access = !one_access
		. = TRUE
	if(href_list["set"])
		var/access = text2num(href_list["access"])
		if (!(access in conf_access))
			conf_access += access
		else
			conf_access -= access
		. = TRUE
	if(href_list["unlock"])
		if(lockable)
			if(!req_access || istype(user,/mob/living/silicon))
				locked = 0
				last_configurator = user.name
				to_chat(user, SPAN_NOTICE("You unlock \the [src]."))
			else
				var/obj/item/weapon/card/id/I = user.get_active_hand()
				I = I ? I.GetIdCard() : null
				if(!istype(I, /obj/item/weapon/card/id))
					to_chat(user, SPAN_WARNING("\The [src] flashes a yellow LED near the ID scanner. Did you remember to scan your ID or PDA?"))
				else
					if (check_access(I))
						locked = 0
						last_configurator = I.registered_name
						to_chat(user, SPAN_NOTICE("You unlock \the [src]."))
					else
						to_chat(user, SPAN_WARNING("\The [src] flashes a red LED near the ID scanner, indicating your access has been denied."))
		else
			to_chat(user, SPAN_WARNING("\The [src] cannot be locked or unlocked.."))
		. = TRUE
	if(href_list["lock"])
		if(lockable)
			locked = 1
		. = TRUE

/obj/item/weapon/airlock_electronics/attack_self(mob/user as mob)
	if (!ishuman(user) && !istype(user,/mob/living/silicon/robot))
		return ..(user)
	ui_interact(user)

/obj/item/weapon/airlock_electronics/secure
	name = "secure airlock electronics"
	desc = "designed to be somewhat more resistant to hacking than standard electronics."
	secure = 1

/obj/item/weapon/airlock_electronics/brace
	name = "airlock brace access circuit"
	req_access = list()
	locked = 0
	lockable = 0
