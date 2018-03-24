////////////////////////////////////////////////////////////////////////
//SUPPLY COMPUTER
////////////////////////////////////////////////////////////////////////

/obj/machinery/computer/supply
	name = "cargo supply console"
	icon = 'icons/obj/computer.dmi'
	icon_screen = "request"
	light_color = "#b88b2e"
	req_access = list(access_cargo)
	circuit = /obj/item/circuitboard/supplycomp

	var/datum/console_program/supply/control_system = /datum/console_program/supply
	var/can_order_contraband = 0
	var/activeterminal = 0
	var/lastprint = 0
	var/printdelay = 10 SECONDS
	var/orderdelay = 2 SECONDS
	var/lastorder = 0
	var/list/supplylist

/obj/machinery/computer/supply/Initialize()
	if(ispath(control_system))
		control_system = new control_system(src)
	. = ..()
	generateSupplyList()

/obj/machinery/computer/supply/proc/generateSupplyList()
	supplylist = list()
	control_system.category_text = null
	for(var/decl/hierarchy/supply_pack/sp in cargo_supply_pack_root.children)
		if(sp.is_category())
			supplylist[sp.name] = list(
				"name" = sp.name,
				"pack" = list()
				)
			for(var/decl/hierarchy/supply_pack/spc in sp.children)
				if((spc.hidden && !emagged) || (spc.contraband && !can_order_contraband))
					continue
				supplylist[sp.name]["pack"] += list(list(
					"name" = spc.name,
					"cost" = spc.cost,
					"id" = "\ref[spc]",
					"available" = !(using_map && using_map.stellar_location && \
					 using_map.stellar_location.blacklisted_cargo && \
					 (spc.type in using_map.stellar_location.blacklisted_cargo))
					))

/obj/machinery/computer/supply/proc/isActiveTerminal()
	if(supply_controller.primaryterminal == src)
		return TRUE
	return FALSE

/obj/machinery/computer/supply/proc/servicesActive()
	if(supply_controller.primaryterminal)
		return TRUE
	return FALSE

/obj/machinery/computer/supply/proc/login()
	if(supply_controller.primaryterminal)
		supply_controller.primaryterminal.logout()
	supply_controller.primaryterminal = src
	activeterminal = TRUE
	icon_screen = "supply"
	update_icon()

/obj/machinery/computer/supply/proc/logout()
	activeterminal = FALSE
	supply_controller.primaryterminal = null
	icon_screen = "request"
	update_icon()

/obj/machinery/computer/supply/attack_ai(var/mob/user)
	return attack_hand(user)

/obj/machinery/computer/supply/attack_hand(var/mob/user)
	interact(user)

/obj/machinery/computer/supply/interact(user)
	if(!istype(user, /mob/living/silicon))
		playsound(loc, 'sound/effects/keyboard.ogg', 50)
	control_system.Run(user)

/obj/machinery/computer/supply/Topic(var/href, var/list/href_list)

	if(..())
		return 1

	if(href_list["show"])
		if(href_list["id"])
			control_system.show_pack_info = locate(href_list["id"]) in supply_controller.master_supply_list
		else
			control_system.show_pack_info = null

	if(href_list["setcategory"])
		control_system.category_current = href_list["setcategory"]

	if(href_list["changescreen"])
		control_system.set_screen(text2num(href_list["changescreen"]))

	if(href_list["send"])
		finalize_purchase()

	if(href_list["add"])
		if(lastorder > world.time) return TRUE
		lastorder = world.time + orderdelay
		var/notenoughpoints = 0
		var/decl/hierarchy/supply_pack/P = locate(href_list["id"]) in supply_controller.master_supply_list
		if(!istype(P) || P.is_category())	return TRUE

		if(using_map && using_map.stellar_location && \
		 using_map.stellar_location.blacklisted_cargo && \
		 (P.type in using_map.stellar_location.blacklisted_cargo))
			return TRUE

		if(P.hidden && !emagged) return TRUE

		if(P.cost > supply_controller.points && activeterminal)
			usr << "<span class='notice'>Not enough points to add to cart. Adding to request list.</span>"
			notenoughpoints = 1

		var/timeout = world.time + 1 MINUTE
		var/reason = sanitize(input(usr,"Reason:","Why do you require this item?","") as null|text,,0)
		if(world.time > timeout)	return TRUE
		if(!reason)	return TRUE

		var/idname = "*None Provided*"
		var/idrank = "*None Provided*"
		if(ishuman(usr))
			var/mob/living/carbon/human/H = usr
			idname = H.get_authentification_name()
			idrank = H.get_assignment()
		else if(issilicon(usr))
			idname = usr.real_name

		supply_controller.ordernum++

		//make our supply_order datum
		var/datum/supply_order/O = new /datum/supply_order()
		O.ordernum = supply_controller.ordernum
		O.object = P
		O.orderedby = idname
		O.reason = reason
		O.orderedrank = idrank
		O.comment = "#[O.ordernum]" // crates will be labeled with this.

		//We're going to print the main supply request.
		if(supply_controller.primaryterminal)
			printOrder(O,0,supply_controller.primaryterminal) // print hard copy at terminal
		else
			printOrder(O,0,src) // print hard copy at station due to no defined primary terminal yet.


		//request consoles can only add to the request list
		if(!activeterminal || notenoughpoints)
			supply_controller.requestlist += O
		else
			supply_controller.shoppinglist += O
			supply_controller.points -= P.cost // purchase immediately

	if(href_list["remove"])
		var/datum/supply_order/SO = locate(href_list["id"]) in supply_controller.shoppinglist
		if(istype(SO))
			supply_controller.points += SO.object.cost //refund
			supply_controller.shoppinglist -= SO
			supply_controller.requestlist += SO
			. = TRUE

	if(href_list["clear"])
		switch(alert("Are you sure you want to clear the shopping cart?",, "Yes", "No"))
			if("Yes")
				for(var/datum/supply_order/SO in supply_controller.shoppinglist)
					supply_controller.points += SO.object.cost //refund all
					supply_controller.shoppinglist -= SO
					supply_controller.requestlist += SO
		. = TRUE

	if(href_list["approve"])
		var/datum/supply_order/SO = locate(href_list["id"]) in supply_controller.requestlist
		if(istype(SO))
			if(SO.object.cost > supply_controller.points)
				usr << "<span class='warning'>Not enough points to purchase \the [SO.object.name]!</span>"
				return TRUE
			supply_controller.requestlist -= SO
			supply_controller.shoppinglist += SO
			supply_controller.points -= SO.object.cost // purchase
			. = TRUE

	if(href_list["deny"])
		switch(alert("Are you sure you want to deny the entry? this will permanently delete the request",, "Yes", "No"))
			if("Yes")
				var/datum/supply_order/SO = locate(href_list["id"]) in supply_controller.requestlist
				if(istype(SO))
					supply_controller.requestlist -= SO
					. = TRUE

	if(href_list["denyall"])
		switch(alert("Are you sure you want to deny the entry? this will permanently delete ALL requests",, "Yes", "No"))
			if("Yes")
				switch(alert("Final warning: Selecting continue will delete all request entries not currently in the cart.",, "Continue", "Stop"))
					if("Continue")
						supply_controller.requestlist.Cut()
		. = TRUE

	if(href_list["edit"])
		var/datum/supply_order/SO = locate(href_list["id"]) in supply_controller.shoppinglist
		if(istype(SO))
			var/comment = sanitize(input(usr,"Comment: ","How do you want the delivery to be labeled?", SO.comment) as null|text,,0)
			if(comment) SO.comment = comment
		. = TRUE

	if(href_list["print"])
		var/datum/supply_order/SO = locate(href_list["id"]) in supply_controller.requestlist
		if(istype(SO))
			printOrder(SO, 1, src)
			lastprint = world.time + printdelay
		. = TRUE

	if(href_list["login"]) //sign in as merchant
		if(!src.allowed(usr))
			return TRUE
		login()
		. = TRUE

	if(href_list["logout"])
		logout()
		. = TRUE

	//played at the end so only genuine presses that don't get stopped beep.
	playsound(src, 'sound/machines/buttonbeep.ogg', 10, 1, rand(40000, 50000)) // restricting pitch so we don't sound like a bike horn.
	interact(usr)

	return TRUE

/obj/machinery/computer/supply/emag_act(var/remaining_charges, var/mob/user)
	if(!emagged)
		user << "<span class='notice'>Special supplies unlocked.</span>"
		emagged = 1 // why this wasn't set before is beyond me
		generateSupplyList()
		return 1

/obj/machinery/computer/supply/proc/printOrder(var/datum/supply_order/O, var/isreciept = 0, var/atom/printloc = src)
	if(O)
		var/obj/item/paper/reqform
		if(printloc)
			reqform = new /obj/item/paper(printloc.loc)
		else
			reqform = new /obj/item/paper(src.loc)

		if(isreciept)
			reqform.name = "Cargo Reciept - [O.object.name]"
			reqform.info += "<h3>[station_name()] Supply Requisition Reciept</h3><hr>"
		else
			reqform.name = "Requisition Form - [O.object.name]"
			reqform.info += "<h3>[station_name()] Supply Requisition Form</h3><hr>"

		reqform.info += "INDEX: #[O.ordernum]<br>"
		reqform.info += "REQUESTED BY: [O.orderedby]<br>"
		reqform.info += "RANK: [O.orderedrank]<br>"
		reqform.info += "REASON: [O.reason]<br>"
		reqform.info += "SUPPLY CRATE TYPE: [O.object.name]<br>"
		reqform.info += "ACCESS RESTRICTION: [get_access_desc(O.object.access)]<br>"
		reqform.info += "CONTENTS:<br>"
		reqform.info += O.object.manifest
		reqform.info += "<hr>"
		if(!isreciept)
			reqform.info += "STAMP BELOW IF REQUISITION APPROVED:<br>"

		reqform.update_icon()	//Fix for appearing blank when printed.
		playsound(printloc,'sound/machines/dotprinter.ogg', 40, 1)

/obj/machinery/computer/supply/verb/cargo_buy()

	set name = "Confirm Cargo Purchase"
	set desc = "Confirm a cargo purchase on the console."
	set src in view(1)

	if(stat & (NOPOWER|BROKEN))
		return

	if(check_access(usr.GetIdCard()))
		finalize_purchase()
	else
		to_chat(usr, "<span class='warning'>Access denied.</span>")

/obj/machinery/computer/supply/proc/finalize_purchase()
	supply_controller.buy(src)
	playsound(src, 'sound/machines/buttonbeep.ogg', 10, 1, rand(40000, 50000))
