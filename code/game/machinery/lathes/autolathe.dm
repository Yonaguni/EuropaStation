/obj/machinery/autolathe
	name = "autolathe"
	desc = "It produces items using metal and glass."
	icon_state = "autolathe"
	density = 1
	anchored = 1
	use_power = 1
	idle_power_usage = 10
	active_power_usage = 2000
	icon = 'icons/obj/machines/autolathes.dmi'

	var/datum/console_program/lathe/control_system = /datum/console_program/lathe

	var/base_icon = "autolathe"
	var/lathe_type = LATHE_TYPE_GENERIC
	var/list/machine_recipes
	var/list/stored_material =  list(MATERIAL_STEEL = 0, MATERIAL_GLASS = 0, MATERIAL_PLASTIC = 0)
	var/list/storage_capacity = list(MATERIAL_STEEL = 0, MATERIAL_GLASS = 0, MATERIAL_PLASTIC = 0)
	var/show_category = "All"

	var/hacked = 0
	var/disabled = 0
	var/shocked = 0
	var/busy = 0

	var/mat_efficiency = 1
	var/build_time = 50

	var/datum/wires/autolathe/wires = null


/obj/machinery/autolathe/New()

	..()
	wires = new(src)
	if(ispath(control_system))
		control_system = new control_system(src)

	//Create parts for lathe.
	component_parts = list()
	component_parts += new /obj/item/circuitboard/autolathe(src)
	component_parts += new /obj/item/stock_parts/matter_bin(src)
	component_parts += new /obj/item/stock_parts/matter_bin(src)
	component_parts += new /obj/item/stock_parts/matter_bin(src)
	component_parts += new /obj/item/stock_parts/manipulator(src)
	component_parts += new /obj/item/stock_parts/console_screen(src)
	RefreshParts()

/obj/machinery/autolathe/Destroy()
	qdel(wires)
	wires = null
	return ..()

/obj/machinery/autolathe/proc/update_recipe_list()
	populate_lathe_recipes()
	if(lathe_type == LATHE_TYPE_ROBOTICS)
		machine_recipes = autolathe_robotics
	else if(lathe_type == LATHE_TYPE_CIRCUIT)
		machine_recipes = autolathe_circuits
	else if(lathe_type == LATHE_TYPE_ADVANCED)
		machine_recipes = autolathe_advanced
	else if(lathe_type == LATHE_TYPE_HEAVY)
		machine_recipes = autolathe_heavy
	else if(lathe_type == LATHE_TYPE_AMMUNITION)
		machine_recipes = autolathe_ammo
	else if(lathe_type == LATHE_TYPE_CURRENCY)
		machine_recipes = autolathe_currency
	else
		machine_recipes = autolathe_generic

/obj/machinery/autolathe/attack_ai(var/mob/user)
	return attack_hand(user)

/obj/machinery/autolathe/attack_hand(var/mob/user)
	interact(user)

/obj/machinery/autolathe/interact(user)

	if(shocked)
		shock(user, 50)
		return

	if(!istype(user, /mob/living/silicon))
		playsound(loc, 'sound/effects/keyboard.ogg', 50)

	update_recipe_list()
	control_system.Run(user)

	//Hacking.
	if(panel_open)
		user << browse("<h2>Maintenance Panel</h2> [wires.GetInteractWindow()]", "window=[base_icon]")

/obj/machinery/autolathe/attackby(var/obj/item/O, var/mob/user)

	if(busy)
		user << "<span class='notice'>\The [src] is busy. Please wait for completion of previous operation.</span>"
		return

	if(default_deconstruction_screwdriver(user, O))
		updateUsrDialog()
		return
	if(default_deconstruction_crowbar(user, O))
		return
	if(default_part_replacement(user, O))
		return

	if(stat)
		return

	if(panel_open)
		//Don't eat multitools or wirecutters used on an open lathe.
		if(O.ismultitool() || O.iswirecutter())
			attack_hand(user)
			return

	if(O.loc != user && !(istype(O,/obj/item/stack)))
		return 0

	if(is_robot_module(O))
		return 0

	//Resources are being loaded.
	var/obj/item/eating = O
	if(!eating.matter)
		user << "\The [eating] does not contain significant amounts of useful materials and cannot be accepted."
		return

	var/filltype = 0       // Used to determine message.
	var/total_used = 0     // Amount of material used.
	var/mass_per_sheet = 0 // Amount of material constituting one sheet.

	for(var/material in eating.matter)

		if(isnull(stored_material[material]) || isnull(storage_capacity[material]))
			continue

		if(stored_material[material] >= storage_capacity[material])
			continue

		var/total_material = eating.matter[material]

		//If it's a stack, we eat multiple sheets.
		if(istype(eating,/obj/item/stack))
			var/obj/item/stack/stack = eating
			total_material *= stack.get_amount()

		if(stored_material[material] + total_material > storage_capacity[material])
			total_material = storage_capacity[material] - stored_material[material]
			filltype = 1
		else
			filltype = 2

		stored_material[material] += total_material
		total_used += total_material
		mass_per_sheet += eating.matter[material]

	if(!filltype)
		user << "<span class='notice'>\The [src] is full. Please remove material from \the [src] in order to insert more.</span>"
		return
	else if(filltype == 1)
		user << "You fill \the [src] to capacity with \the [eating]."
	else
		user << "You fill \the [src] with \the [eating]."

	flick("[base_icon]_o", src) // Plays metal insertion animation. Work out a good way to work out a fitting animation. ~Z

	if(istype(eating,/obj/item/stack))
		var/obj/item/stack/stack = eating
		stack.use(max(1, round(total_used/mass_per_sheet))) // Always use at least 1 to prevent infinite materials.
	else
		user.remove_from_mob(O)
		qdel(O)

	updateUsrDialog()
	return

/obj/machinery/autolathe/Topic(href, href_list)

	if(..())
		return

	usr.set_machine(src)
	add_fingerprint(usr)

	if(busy)
		usr << "<span class='notice'>\The [src] is busy. Please wait for completion of previous operation.</span>"
		return

	if(href_list["change_category"])

		var/list/selection_category = list("All" = 1)
		for(var/datum/autolathe/recipe/R in machine_recipes)
			if(R.hidden && !hacked)
				continue
			selection_category[R.category] = 1

		var/choice = input("Which category do you wish to display?") as null|anything in selection_category
		if(!choice) return
		show_category = choice

	if(href_list["make"] && machine_recipes)

		var/index = text2num(href_list["make"])
		var/multiplier = text2num(href_list["multiplier"])
		var/datum/autolathe/recipe/making

		if(index > 0 && index <= machine_recipes.len)
			making = machine_recipes[index]

		//Exploit detection, not sure if necessary after rewrite.
		if(!making || multiplier < 0 || multiplier > 100)
			var/turf/exploit_loc = get_turf(usr)
			message_admins("[key_name_admin(usr)] tried to exploit \a [src] to duplicate an item! ([exploit_loc ? "<a href='?_src_=holder;adminplayerobservecoodjump=1;X=[exploit_loc.x];Y=[exploit_loc.y];Z=[exploit_loc.z]'>JMP</a>" : "null"])", 0)
			log_admin("EXPLOIT : [key_name(usr)] tried to exploit \a [src] to duplicate an item!")
			return

		busy = 1
		update_use_power(2)

		//Check if we still have the materials.
		for(var/material in making.resources)
			if(!isnull(stored_material[material]))
				if(stored_material[material] < round(making.resources[material] * mat_efficiency) * multiplier)
					return

		//Consume materials.
		for(var/material in making.resources)
			if(!isnull(stored_material[material]))
				stored_material[material] = max(0, stored_material[material] - round(making.resources[material] * mat_efficiency) * multiplier)

		//Fancy autolathe animation.
		flick("[base_icon]_n", src)

		sleep(build_time)

		busy = 0
		update_use_power(1)

		//Sanity check.
		if(!making || !src) return

		//Create the desired item.
		var/obj/item/I = new making.path(loc)
		if(istype(I, /obj/item/stack))
			var/obj/item/stack/S = I
			S.amount = multiplier
		else
			multiplier--
			while(multiplier > 0)
				new making.path(loc)
				multiplier--

	updateUsrDialog()

/obj/machinery/autolathe/update_icon()
	icon_state = (panel_open ? "[base_icon]_t" : "[base_icon]")

//Updates overall lathe storage size.
/obj/machinery/autolathe/RefreshParts()
	..()
	var/mb_rating = 0
	var/man_rating = 0
	for(var/obj/item/stock_parts/matter_bin/MB in component_parts)
		mb_rating += MB.rating
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		man_rating += M.rating

	for(var/mat_type in storage_capacity)
		storage_capacity[mat_type] = mb_rating * 15000
	build_time = 50 / man_rating
	mat_efficiency = 1.1 - man_rating * 0.1// Normally, price is 1.25 the amount of material, so this shouldn't go higher than 0.8. Maximum rating of parts is 3

/obj/machinery/autolathe/dismantle()
	for(var/mat in stored_material)
		var/material/M = SSmaterials.get_material(mat)
		if(istype(M) && stored_material[mat] >= M.units_per_sheet)
			new M.stack_type(get_turf(src), amount = Floor(stored_material[mat] / M.units_per_sheet))
	. = ..()
