
/**
 *  A vending machine
 */
/obj/machinery/vending
	name = "vending machine"
	desc = "A generic vending machine."
	icon = 'icons/obj/vending.dmi'
	icon_state = "generic"
	layer = BELOW_OBJ_LAYER
	anchored = 1
	density = 1
	obj_flags = OBJ_FLAG_ANCHORABLE
	clicksound = "button"
	clickvol = 40

	var/icon_vend //Icon_state when vending
	var/icon_deny //Icon_state when denying access
	var/diona_spawn_chance = 0.1

	// Power
	idle_power_usage = 10
	var/vend_power_usage = 150 //actuators and stuff

	// Vending-related
	var/active = 1 //No sales pitches if off!
	var/vend_ready = 1 //Are we ready to vend?? Is it time??
	var/vend_delay = 10 //How long does it take to vend?
	var/categories = CAT_NORMAL // Bitmask of cats we're currently showing
	var/datum/stored_items/vending_products/currently_vending = null // What we're requesting payment for right now
	var/status_message = "" // Status screen messages like "insufficient funds", displayed in NanoUI
	var/status_error = 0 // Set to 1 if status_message is an error

	/*
		Variables used to initialize the product list
		These are used for initialization only, and so are optional if
		product_records is specified
	*/
	var/list/products	= list() // For each, use the following pattern:
	var/list/contraband	= list() // list(/type/path = amount,/type/path2 = amount2)
	var/list/premium 	= list() // No specified amount = only one in stock
	var/list/prices     = list() // Prices for each item, list(/type/path = price), items not in the list don't have a price.

	// List of vending_product items available.
	var/list/product_records = list()


	// Variables used to initialize advertising
	var/product_slogans = "" //String of slogans spoken out loud, separated by semicolons
	var/product_ads = "" //String of small ad messages in the vending screen

	var/list/ads_list = list()

	// Stuff relating vocalizations
	var/list/slogan_list = list()
	var/shut_up = 1 //Stop spouting those godawful pitches!
	var/vend_reply //Thank you for shopping!
	var/last_reply = 0
	var/last_slogan = 0 //When did we last pitch?
	var/slogan_delay = 6000 //How long until we can pitch again?

	// Things that can go wrong
	emagged = 0 //Ignores if somebody doesn't have card access to that machine.
	var/seconds_electrified = 0 //Shock customers like an airlock.
	var/shoot_inventory = 0 //Fire items at customers! We're broken!
	var/shooting_chance = 2 //The chance that items are being shot per tick

	var/scan_id = 1
	var/obj/item/weapon/material/coin/coin
	var/datum/wires/vending/wires = null

/obj/machinery/vending/New()
	..()
	wires = new(src)
	spawn(4)
		if(src.product_slogans)
			src.slogan_list += splittext(src.product_slogans, ";")

			// So not all machines speak at the exact same time.
			// The first time this machine says something will be at slogantime + this random value,
			// so if slogantime is 10 minutes, it will say it at somewhere between 10 and 20 minutes after the machine is crated.
			src.last_slogan = world.time + rand(0, slogan_delay)

		if(src.product_ads)
			src.ads_list += splittext(src.product_ads, ";")

		src.build_inventory()
		power_change()

		return

	return

/**
 *  Build src.produdct_records from the products lists
 *
 *  src.products, src.contraband, src.premium, and src.prices allow specifying
 *  products that the vending machine is to carry without manually populating
 *  src.product_records.
 */
/obj/machinery/vending/proc/build_inventory()
	var/list/all_products = list(
		list(src.products, CAT_NORMAL),
		list(src.contraband, CAT_HIDDEN),
		list(src.premium, CAT_COIN))

	for(var/current_list in all_products)
		var/category = current_list[2]

		for(var/entry in current_list[1])
			var/datum/stored_items/vending_products/product = new/datum/stored_items/vending_products(src, entry)

			product.price = (entry in src.prices) ? src.prices[entry] : 0
			product.amount = (current_list[1][entry]) ? current_list[1][entry] : 1
			product.category = category

			src.product_records.Add(product)

/obj/machinery/vending/Destroy()
	qdel(wires)
	wires = null
	qdel(coin)
	coin = null
	for(var/datum/stored_items/vending_products/R in product_records)
		qdel(R)
	product_records = null
	return ..()

/obj/machinery/vending/ex_act(severity)
	switch(severity)
		if(1.0)
			qdel(src)
			return
		if(2.0)
			if (prob(50))
				qdel(src)
				return
		if(3.0)
			if (prob(25))
				spawn(0)
					src.malfunction()
					return
				return
		else
	return

/obj/machinery/vending/emag_act(var/remaining_charges, var/mob/user)
	if (!emagged)
		src.emagged = 1
		to_chat(user, "You short out the product lock on \the [src]")
		return 1

/obj/machinery/vending/attackby(obj/item/weapon/W as obj, mob/user as mob)

	var/obj/item/weapon/card/id/I = W.GetIdCard()

	if (currently_vending && vendor_account && !vendor_account.suspended)
		var/paid = 0
		var/handled = 0

		if (I) //for IDs and PDAs and wallets with IDs
			paid = pay_with_card(I,W)
			handled = 1
		else if (istype(W, /obj/item/weapon/spacecash/ewallet))
			var/obj/item/weapon/spacecash/ewallet/C = W
			paid = pay_with_ewallet(C)
			handled = 1
		else if (istype(W, /obj/item/weapon/spacecash/bundle))
			var/obj/item/weapon/spacecash/bundle/C = W
			paid = pay_with_cash(C)
			handled = 1

		if(paid)
			src.vend(currently_vending, usr)
			return
		else if(handled)
			SSnano.update_uis(src)
			return // don't smack that machine with your 2 thalers

	if (I || istype(W, /obj/item/weapon/spacecash))
		attack_hand(user)
		return
	else if(istype(W, /obj/item/weapon/screwdriver))
		src.panel_open = !src.panel_open
		to_chat(user, "You [src.panel_open ? "open" : "close"] the maintenance panel.")
		src.overlays.Cut()
		if(src.panel_open)
			src.overlays += image(src.icon, "[initial(icon_state)]-panel")

		SSnano.update_uis(src)  // Speaker switch is on the main UI, not wires UI
		return
	else if(isMultitool(W) || isWirecutter(W))
		if(src.panel_open)
			attack_hand(user)
		return
	else if((obj_flags & OBJ_FLAG_ANCHORABLE) && isWrench(W))
		wrench_floor_bolts(user)
		power_change()
		return
	else if(istype(W, /obj/item/weapon/material/coin) && premium.len > 0)
		if(!user.unEquip(W, src))
			return
		coin = W
		categories |= CAT_COIN
		to_chat(user, "<span class='notice'>You insert \the [W] into \the [src].</span>")
		SSnano.update_uis(src)
		return
	else if(attempt_to_stock(W, user))
		return
	..()
	return

/obj/machinery/vending/MouseDrop_T(var/obj/item/I as obj, var/mob/user as mob)
	if(!CanMouseDrop(I, user) || (I.loc != user))
		return
	return attempt_to_stock(I, user)

/obj/machinery/vending/proc/attempt_to_stock(var/obj/item/I as obj, var/mob/user as mob)
	for(var/datum/stored_items/vending_products/R in product_records)
		if(I.type == R.item_path)
			stock(I, R, user)
			return 1

/**
 *  Receive payment with cashmoney.
 */
/obj/machinery/vending/proc/pay_with_cash(var/obj/item/weapon/spacecash/bundle/cashmoney)
	if(currently_vending.price > cashmoney.worth)
		// This is not a status display message, since it's something the character
		// themselves is meant to see BEFORE putting the money in
		to_chat(usr, "\icon[cashmoney] <span class='warning'>That is not enough money.</span>")
		return 0

	visible_message("<span class='info'>\The [usr] inserts some cash into \the [src].</span>")
	cashmoney.worth -= currently_vending.price

	if(cashmoney.worth <= 0)
		qdel(cashmoney)
	else
		cashmoney.update_icon()

	// Vending machines have no idea who paid with cash
	credit_purchase("(cash)")
	return 1

/**
 * Scan a chargecard and deduct payment from it.
 *
 * Takes payment for whatever is the currently_vending item. Returns 1 if
 * successful, 0 if failed.
 */
/obj/machinery/vending/proc/pay_with_ewallet(var/obj/item/weapon/spacecash/ewallet/wallet)
	visible_message("<span class='info'>\The [usr] swipes \the [wallet] through \the [src].</span>")
	if(currently_vending.price > wallet.worth)
		src.status_message = "Insufficient funds on chargecard."
		src.status_error = 1
		return 0
	else
		wallet.worth -= currently_vending.price
		credit_purchase("[wallet.owner_name] (chargecard)")
		return 1

/**
 * Scan a card and attempt to transfer payment from associated account.
 *
 * Takes payment for whatever is the currently_vending item. Returns 1 if
 * successful, 0 if failed
 */
/obj/machinery/vending/proc/pay_with_card(var/obj/item/weapon/card/id/I, var/obj/item/ID_container)
	if(I==ID_container || ID_container == null)
		visible_message("<span class='info'>\The [usr] swipes \the [I] through \the [src].</span>")
	else
		visible_message("<span class='info'>\The [usr] swipes \the [ID_container] through \the [src].</span>")
	var/datum/money_account/customer_account = get_account(I.associated_account_number)
	if (!customer_account)
		src.status_message = "Error: Unable to access account. Please contact technical support if problem persists."
		src.status_error = 1
		return 0

	if(customer_account.suspended)
		src.status_message = "Unable to access account: account suspended."
		src.status_error = 1
		return 0

	// Have the customer punch in the PIN before checking if there's enough money. Prevents people from figuring out acct is
	// empty at high security levels
	if(customer_account.security_level != 0) //If card requires pin authentication (ie seclevel 1 or 2)
		var/attempt_pin = input("Enter pin code", "Vendor transaction") as num
		customer_account = attempt_account_access(I.associated_account_number, attempt_pin, 2)

		if(!customer_account)
			src.status_message = "Unable to access account: incorrect credentials."
			src.status_error = 1
			return 0

	if(currently_vending.price > customer_account.money)
		src.status_message = "Insufficient funds in account."
		src.status_error = 1
		return 0
	else
		// Okay to move the money at this point
		var/datum/transaction/T = new("[vendor_account.owner_name] (via [name])", "Purchase of [currently_vending.item_name]", -currently_vending.price, name)

		customer_account.do_transaction(T)

		// Give the vendor the money. We use the account owner name, which means
		// that purchases made with stolen/borrowed card will look like the card
		// owner made them
		credit_purchase(customer_account.owner_name)
		return 1

/**
 *  Add money for current purchase to the vendor account.
 *
 *  Called after the money has already been taken from the customer.
 */
/obj/machinery/vending/proc/credit_purchase(var/target as text)
	vendor_account.money += currently_vending.price

	var/datum/transaction/T = new(target, "Purchase of [currently_vending.item_name]", currently_vending.price, name)
	vendor_account.do_transaction(T)

/obj/machinery/vending/attack_ai(mob/user as mob)
	return attack_hand(user)

/obj/machinery/vending/attack_hand(mob/user as mob)
	if(stat & (BROKEN|NOPOWER))
		return

	if(src.seconds_electrified != 0)
		if(src.shock(user, 100))
			return

	wires.Interact(user)
	ui_interact(user)

/**
 *  Display the NanoUI window for the vending machine.
 *
 *  See NanoUI documentation for details.
 */
/obj/machinery/vending/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	user.set_machine(src)

	var/list/data = list()
	if(currently_vending)
		data["mode"] = 1
		data["product"] = currently_vending.item_name
		data["price"] = currently_vending.price
		data["message_err"] = 0
		data["message"] = src.status_message
		data["message_err"] = src.status_error
	else
		data["mode"] = 0
		var/list/listed_products = list()

		for(var/key = 1 to src.product_records.len)
			var/datum/stored_items/vending_products/I = src.product_records[key]

			if(!(I.category & src.categories))
				continue

			listed_products.Add(list(list(
				"key" = key,
				"name" = I.item_name,
				"price" = I.price,
				"color" = I.display_color,
				"amount" = I.get_amount())))

		data["products"] = listed_products

	if(src.coin)
		data["coin"] = src.coin.name

	if(src.panel_open)
		data["panel"] = 1
		data["speaker"] = src.shut_up ? 0 : 1
	else
		data["panel"] = 0

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "vending_machine.tmpl", src.name, 440, 600)
		ui.set_initial_data(data)
		ui.open()

/obj/machinery/vending/Topic(href, href_list)
	if(stat & (BROKEN|NOPOWER))
		return
	if(..())
		return

	if(href_list["remove_coin"] && !istype(usr,/mob/living/silicon))
		if(!coin)
			to_chat(usr, "There is no coin in this machine.")
			return

		coin.forceMove(src.loc)
		if(!usr.get_active_hand())
			usr.put_in_hands(coin)
		to_chat(usr, "<span class='notice'>You remove \the [coin] from \the [src]</span>")
		coin = null
		categories &= ~CAT_COIN

	if ((usr.contents.Find(src) || (in_range(src, usr) && istype(src.loc, /turf))))
		if ((href_list["vend"]) && (src.vend_ready) && (!currently_vending))
			if((!allowed(usr)) && !emagged && scan_id)	//For SECURE VENDING MACHINES YEAH
				to_chat(usr, "<span class='warning'>Access denied.</span>")//Unless emagged of course
				flick(icon_deny,src)
				return

			var/key = text2num(href_list["vend"])
			var/datum/stored_items/vending_products/R = product_records[key]

			// This should not happen unless the request from NanoUI was bad
			if(!(R.category & src.categories))
				return

			if(R.price <= 0)
				src.vend(R, usr)
			else if(istype(usr,/mob/living/silicon)) //If the item is not free, provide feedback if a synth is trying to buy something.
				to_chat(usr, "<span class='danger'>Artificial unit recognized.  Artificial units cannot complete this transaction.  Purchase canceled.</span>")
				return
			else
				src.currently_vending = R
				if(!vendor_account || vendor_account.suspended)
					src.status_message = "This machine is currently unable to process payments due to problems with the associated account."
					src.status_error = 1
				else
					src.status_message = "Please swipe a card or insert cash to pay for the item."
					src.status_error = 0

		else if (href_list["cancelpurchase"])
			src.currently_vending = null

		else if ((href_list["togglevoice"]) && (src.panel_open))
			src.shut_up = !src.shut_up

		SSnano.update_uis(src)

/obj/machinery/vending/proc/vend(var/datum/stored_items/vending_products/R, mob/user)
	if((!allowed(usr)) && !emagged && scan_id)	//For SECURE VENDING MACHINES YEAH
		to_chat(usr, "<span class='warning'>Access denied.</span>")//Unless emagged of course
		flick(src.icon_deny,src)
		return
	src.vend_ready = 0 //One thing at a time!!
	src.status_message = "Vending..."
	src.status_error = 0
	SSnano.update_uis(src)

	if (R.category & CAT_COIN)
		if(!coin)
			to_chat(user, "<span class='notice'>You need to insert a coin to get this item.</span>")
			return
		if(!isnull(coin.string_colour))
			if(prob(50))
				to_chat(user, "<span class='notice'>You successfully pull the coin out before \the [src] could swallow it.</span>")
			else
				to_chat(user, "<span class='notice'>You weren't able to pull the coin out fast enough, the machine ate it, string and all.</span>")
				qdel(coin)
				coin = null
				categories &= ~CAT_COIN
		else
			qdel(coin)
			coin = null
			categories &= ~CAT_COIN

	if(((src.last_reply + (src.vend_delay + 200)) <= world.time) && src.vend_reply)
		spawn(0)
			src.speak(src.vend_reply)
			src.last_reply = world.time

	use_power_oneoff(vend_power_usage)	//actuators and stuff
	if (src.icon_vend) //Show the vending animation if needed
		flick(src.icon_vend,src)
	spawn(src.vend_delay) //Time to vend
		R.get_product(get_turf(src))
		src.visible_message("\The [src] whirs as it vends \the [R.item_name].")
		if(prob(1)) //The vending gods look favorably upon you
			sleep(3)
			if(R.get_product(get_turf(src)))
				src.visible_message("<span class='notice'>\The [src] clunks as it vends an additional [R.item_name].</span>")

		src.status_message = ""
		src.status_error = 0
		src.vend_ready = 1
		currently_vending = null
		SSnano.update_uis(src)

/**
 * Add item to the machine
 *
 * Checks if item is vendable in this machine should be performed before
 * calling. W is the item being inserted, R is the associated vending_product entry.
 */
/obj/machinery/vending/proc/stock(obj/item/weapon/W, var/datum/stored_items/vending_products/R, var/mob/user)
	if(!user.unEquip(W))
		return

	if(R.add_product(W))
		to_chat(user, "<span class='notice'>You insert \the [W] in the product receptor.</span>")
		SSnano.update_uis(src)
		return 1

	SSnano.update_uis(src)

/obj/machinery/vending/Process()
	if(stat & (BROKEN|NOPOWER))
		return

	if(!src.active)
		return

	if(src.seconds_electrified > 0)
		src.seconds_electrified--

	//Pitch to the people!  Really sell it!
	if(((src.last_slogan + src.slogan_delay) <= world.time) && (src.slogan_list.len > 0) && (!src.shut_up) && prob(5))
		var/slogan = pick(src.slogan_list)
		src.speak(slogan)
		src.last_slogan = world.time

	if(src.shoot_inventory && prob(shooting_chance))
		src.throw_item()

	return

/obj/machinery/vending/proc/speak(var/message)
	if(stat & NOPOWER)
		return

	if (!message)
		return

	for(var/mob/O in hearers(src, null))
		O.show_message("<span class='game say'><span class='name'>\The [src]</span> beeps, \"[message]\"</span>",2)
	return

/obj/machinery/vending/powered()
	return anchored && ..()

/obj/machinery/vending/on_update_icon()
	if(stat & BROKEN)
		icon_state = "[initial(icon_state)]-broken"
	else if( !(stat & NOPOWER) )
		icon_state = initial(icon_state)
	else
		spawn(rand(0, 15))
			src.icon_state = "[initial(icon_state)]-off"

//Oh no we're malfunctioning!  Dump out some product and break.
/obj/machinery/vending/proc/malfunction()
	for(var/datum/stored_items/vending_products/R in src.product_records)
		while(R.get_amount()>0)
			R.get_product(loc)
		break
	set_broken(TRUE)

//Somebody cut an important wire and now we're following a new definition of "pitch."
/obj/machinery/vending/proc/throw_item()
	var/obj/throw_item = null
	var/mob/living/target = locate() in view(7,src)
	if(!target)
		return 0

	for(var/datum/stored_items/vending_products/R in shuffle(src.product_records))
		throw_item = R.get_product(loc)
		if (throw_item)
			break
	if (!throw_item)
		return 0
	spawn(0)
		throw_item.throw_at(target, rand(1,2), 3, src)
	src.visible_message("<span class='warning'>\The [src] launches \a [throw_item] at \the [target]!</span>")
	return 1

/*
 * Vending machine types
 */

/*

/obj/machinery/vending/[vendors name here]   // --vending machine template   :)
	name = ""
	desc = ""
	icon = ''
	icon_state = ""
	vend_delay = 15
	products = list()
	contraband = list()
	premium = list()

*/
