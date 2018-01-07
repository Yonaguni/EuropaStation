#define JAMMER_MAX_RANGE world.view*2
#define JAMMER_POWER_CONSUMPTION ((max(0.75, range)**2 * jammer_method.energy_cost * SS_OBJECT_TR) / 10)

/obj/item/suit_sensor_jammer
	name = "small device"
	desc = "This object menaces with tiny, dull spikes of plastic."
	icon_state = "jammer"
	w_class = 2
	var/active = FALSE
	var/range = 2 // This is a radius, thus a range of 7 covers the entire visible screen
	var/obj/item/cell/bcell = /obj/item/cell/high
	var/suit_sensor_jammer_method/jammer_method
	var/list/suit_sensor_jammer_methods_by_type
	var/list/suit_sensor_jammer_methods

/obj/item/suit_sensor_jammer/New()
	..()
	if(ispath(bcell))
		bcell = new bcell(src)
	suit_sensor_jammer_methods = list()
	suit_sensor_jammer_methods_by_type = list()
	for(var/jammer_method_type in subtypesof(/suit_sensor_jammer_method))
		var/new_method = new jammer_method_type(src, /obj/item/suit_sensor_jammer/proc/may_process_crew_data)
		dd_insertObjectList(suit_sensor_jammer_methods, new_method)
		suit_sensor_jammer_methods_by_type[jammer_method_type] = new_method
	jammer_method = suit_sensor_jammer_methods[1]
	update_icon()

/obj/item/suit_sensor_jammer/Destroy()
	. = ..()
	qdel(bcell)
	bcell = null
	jammer_method = null
	for(var/method in suit_sensor_jammer_methods)
		qdel(method)
	suit_sensor_jammer_methods = null
	suit_sensor_jammer_methods_by_type = null
	disable()

/obj/item/suit_sensor_jammer/attack_self(var/mob/user)
	ui_interact(user)

/obj/item/suit_sensor_jammer/ui_interact(var/mob/user)

	var/dat = list()
	dat += "<a href='?src=\ref[src];toggle_active=1'>[active ? "Active" : "Inactive"]</a>"
	if(bcell)
		dat += "Current charge: [round(bcell.charge)]/[bcell.maxcharge]"
	else
		dat += "No cell installed!"
	dat += "Range: [range] \[<a href='?src=\ref[src];increase_range=1'>Increase</a> | <a href='?src=\ref[src];decrease_range=1'>Decrease</a>\]"
	dat += "Power consumption: [JAMMER_POWER_CONSUMPTION]"
	dat += "Current mode: [jammer_method.name], cost: [jammer_method.energy_cost]"
	dat += "<hr>"
	for(var/suit_sensor_jammer_method/ssjm in suit_sensor_jammer_methods - jammer_method)
		dat += "[ssjm.name], cost: [ssjm.energy_cost] <a href='?src=\ref[src];select_mode=\ref[ssjm]'>\[Select\]</a>"

	var/datum/browser/popup = new(user, "suitjammer", "Suit Sensor Jammer", 600, 250)
	popup.set_content(jointext(dat, "<br>"))
	popup.open()

/obj/item/suit_sensor_jammer/Topic(href, href_list)
	. = ..()
	if(.)
		return
	if(href_list["toggle_active"])
		. = TRUE
		if(active)
			disable()
		else
			enable()
	if(href_list["increase_range"])
		set_range(range+1)
		. = TRUE
	if(href_list["decrease_range"])
		set_range(range-1)
		. = TRUE
	if(href_list["select_mode"])
		var/suit_sensor_jammer_method/ssjm = locate(href_list["select_mode"])
		if(istype(ssjm) && (ssjm in suit_sensor_jammer_methods))
			. = TRUE
			jammer_method = ssjm
	if(.)
		ui_interact(usr)

/obj/item/suit_sensor_jammer/attackby(obj/item/I as obj, var/mob/user)
	if(I.iscrowbar())
		if(bcell)
			user << "<span class='notice'>You remove \the [bcell].</span>"
			disable()
			bcell.dropInto(loc)
			bcell = null
		else
			user << "<span class='warning'>There is no cell to remove.</span>"
	else if(istype(I, /obj/item/cell))
		if(bcell)
			user << "<span class='warning'>There's already a cell in \the [src].</span>"
		else if(user.unEquip(I))
			I.forceMove(src)
			bcell = I
			user << "<span class='notice'>You insert \the [bcell] into \the [src]..</span>"
		else
			user << "<span class='warning'>You're unable to insert the battery.</span>"

/obj/item/suit_sensor_jammer/update_icon()
	overlays.Cut()
	if(bcell)
		switch(bcell.charge/bcell.maxcharge)
			if(0 to 0.25)
				overlays += "forth_quarter"
			if(0.25 to 0.50)
				overlays += "one_quarter"
				overlays += "third_quarter"
			if(0.50 to 0.75)
				overlays += "two_quarters"
				overlays += "second_quarter"
			if(0.75 to 0.99)
				overlays += "three_quarters"
				overlays += "first_quarter"
			else
				overlays += "four_quarters"

		if(active)
			overlays += "active"

/obj/item/suit_sensor_jammer/emp_act(var/severity)
	..()
	if(bcell)
		bcell.emp_act(severity)

	if(prob(70/severity))
		enable()
	else
		disable()

	if(prob(90/severity))
		set_method(suit_sensor_jammer_methods_by_type[/suit_sensor_jammer_method/random])
	else
		set_method(pick(suit_sensor_jammer_methods))

	var/new_range = range + (rand(0,6) / severity) - (rand(0,3) / severity)
	set_range(new_range)

obj/item/suit_sensor_jammer/examine(var/user)
	. = ..(user, 3)
	if(.)
		var/list/message = list()
		message += "This device appears to be [active ? "" : "in"]active and "
		if(bcell)
			message += "displays a charge level of [bcell.charge * 100 / bcell.maxcharge]%."
		else
			message += "is lacking a cell."
		user << jointext(message,.)

/obj/item/suit_sensor_jammer/process()
	if(bcell)
		// With a range of 2 and jammer cost of 3 the default (high capacity) cell will last for almost 14 minutes, give or take
		// 10000 / (2^2 * 3 / 10) ~= 8333 ticks ~= 13.8 minutes
		var/deduction = JAMMER_POWER_CONSUMPTION
		if(!bcell.use(deduction))
			disable()
	else
		disable()
	update_icon()

/obj/item/suit_sensor_jammer/proc/enable()
	if(active)
		return FALSE
	active = TRUE
	processing_objects += src
	jammer_method.enable()
	update_icon()
	return TRUE

/obj/item/suit_sensor_jammer/proc/disable()
	if(!active)
		return FALSE
	active = FALSE
	jammer_method.disable()
	processing_objects -= src
	update_icon()
	return TRUE

/obj/item/suit_sensor_jammer/proc/set_range(var/new_range)
	range = Clamp(new_range, 0, JAMMER_MAX_RANGE) // 0 range still covers the current turf
	return range != new_range

/obj/item/suit_sensor_jammer/proc/set_method(var/suit_sensor_jammer_method/sjm)
	if(sjm == jammer_method)
		return
	if(active)
		jammer_method.disable()
		sjm.enable()
	jammer_method = sjm

/obj/item/suit_sensor_jammer/proc/may_process_crew_data(var/mob/living/carbon/human/H, var/obj/item/clothing/under/C, var/turf/pos)
	if(!pos)
		return FALSE
	var/turf/T = get_turf(src)
	return T && T.z == pos.z && get_dist(T, pos) <= range

#undef JAMMER_MAX_RANGE
#undef JAMMER_POWER_CONSUMPTION
