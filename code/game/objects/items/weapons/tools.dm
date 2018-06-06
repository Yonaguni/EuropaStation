//Decides whether or not to damage a player's eyes based on what they're wearing as protection
//Note: This should probably be moved to mob
/proc/handle_welding_damage(var/mob/user)
	if(!iscarbon(user))	return 1
	if(istype(user, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		var/obj/item/organ/internal/eyes/E = H.internal_organs_by_name[BP_EYES]
		if(!E)
			return
		var/safety = H.eyecheck()
		switch(safety)
			if(FLASH_PROTECTION_MODERATE)
				H << "<span class='warning'>Your eyes sting a little.</span>"
				E.damage += rand(1, 2)
				if(E.damage > 12)
					H.eye_blurry += rand(3,6)
			if(FLASH_PROTECTION_NONE)
				H << "<span class='warning'>Your eyes burn.</span>"
				E.damage += rand(2, 4)
				if(E.damage > 10)
					E.damage += rand(4,10)
			if(FLASH_PROTECTION_REDUCED)
				H << "<span class='danger'>Your equipment intensifies the welder's glow. Your eyes itch and burn severely.</span>"
				H.eye_blurry += rand(12,20)
				E.damage += rand(12, 16)
		if(safety<FLASH_PROTECTION_MAJOR)
			if(E.damage > 10)
				user << "<span class='warning'>Your eyes are really starting to hurt. This can't be good for you!</span>"

			if (E.damage >= E.min_bruised_damage)
				H << "<span class='danger'>You go blind!</span>"
				H.eye_blind = 5
				H.eye_blurry = 5

//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/* Tools!
 * Note: Multitools are /obj/item
 *
 * Contains:
 * 		Wrench
 * 		Screwdriver
 * 		Wirecutters
 * 		Welding Tool
 * 		Crowbar
 */

/*
 * Wrench
 */
/obj/item/wrench
	name = "wrench"
	desc = "A wrench with many common uses. Can be usually found in your hand."
	icon = 'icons/obj/items.dmi'
	icon_state = "wrench"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 5.0
	throwforce = 7.0
	w_class = 2.0

	matter = list(MATERIAL_STEEL = 150)
	center_of_mass = "x=17;y=16"
	attack_verb = list("bashed", "battered", "bludgeoned", "whacked")

/obj/item/wrench/iswrench()
	return 1

/*
 * Screwdriver
 */
/obj/item/screwdriver
	name = "screwdriver"
	desc = "You can be totally screwwy with this."
	icon = 'icons/obj/items.dmi'
	icon_state = "screwdriver"
	flags = CONDUCT
	slot_flags = SLOT_BELT | SLOT_EARS
	force = 5.0
	w_class = 1.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
	matter = list(MATERIAL_STEEL = 75)
	center_of_mass = "x=16;y=7"
	attack_verb = list("stabbed")
	lock_picking_level = 5
	sharp = TRUE

/obj/item/screwdriver/isscrewdriver()
	return 1

/obj/item/screwdriver/New()
	switch(pick("red","blue","purple","brown","green","cyan","yellow"))
		if ("red")
			icon_state = "screwdriver2"
			item_state = "screwdriver"
		if ("blue")
			icon_state = "screwdriver"
			item_state = "screwdriver_blue"
		if ("purple")
			icon_state = "screwdriver3"
			item_state = "screwdriver_purple"
		if ("brown")
			icon_state = "screwdriver4"
			item_state = "screwdriver_brown"
		if ("green")
			icon_state = "screwdriver5"
			item_state = "screwdriver_green"
		if ("cyan")
			icon_state = "screwdriver6"
			item_state = "screwdriver_cyan"
		if ("yellow")
			icon_state = "screwdriver7"
			item_state = "screwdriver_yellow"

	if (prob(75))
		src.pixel_y = rand(0, 16)
	..()

/obj/item/screwdriver/attack(var/mob/living/carbon/M, var/mob/living/carbon/user)
	if(!istype(M) || user.a_intent == "help")
		return ..()
	if(user.zone_sel.selecting != BP_EYES && user.zone_sel.selecting != BP_HEAD)
		return ..()
	return eyestab(M,user)

/*
 * Wirecutters
 */
/obj/item/wirecutters
	name = "wirecutters"
	desc = "This cuts wires."
	icon = 'icons/obj/items.dmi'
	icon_state = "cutters"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 6.0
	throw_speed = 2
	throw_range = 9
	w_class = 2.0

	matter = list(MATERIAL_STEEL = 80)
	center_of_mass = "x=18;y=10"
	attack_verb = list("pinched", "nipped")
	sharp = 1
	edge = 1

/obj/item/wirecutters/iswirecutter()
	return TRUE

/obj/item/wirecutters/New()
	if(prob(50))
		icon_state = "cutters-y"
		item_state = "cutters_yellow"
	..()

/obj/item/wirecutters/attack(var/mob/living/carbon/C, var/mob/user)
	if(user.a_intent == I_HELP && (C.handcuffed) && (istype(C.handcuffed, /obj/item/handcuffs/cable)))
		usr.visible_message("\The [usr] cuts \the [C]'s restraints with \the [src]!",\
		"You cut \the [C]'s restraints with \the [src]!",\
		"You hear cable being cut.")
		C.handcuffed = null
		if(C.buckled && C.buckled.buckle_require_restraints)
			C.buckled.unbuckle_mob()
		C.update_inv_handcuffed()
		return
	else
		..()

/*
 * Welding Tool
 */
/obj/item/weldingtool
	name = "welding tool"
	icon = 'icons/obj/items.dmi'
	icon_state = "welder"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	center_of_mass = "x=14;y=15"

	//Amount of OUCH when it's thrown
	force = 3.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = 2.0

	//Cost to make in the autolathe
	matter = list(MATERIAL_STEEL = 70, MATERIAL_GLASS = 30)

	//R&D tech level


	//Welding tool specific stuff
	var/welding = 0 	//Whether or not the welding tool is off(0), on(1) or currently welding(2)
	var/status = 1 		//Whether the welder is secured or unsecured (able to attach rods to it to make a flamethrower)
	var/max_fuel = 20 	//The max amount of fuel the welder can hold

/obj/item/weldingtool/Initialize(mapload)
	create_reagents(max_fuel)
	. = ..()

/obj/item/weldingtool/Destroy()
	if(welding)
		processing_objects -= src
	return ..()

/obj/item/weldingtool/examine(mob/user)
	if(..(user, 0))
		user << text("\icon[] [] contains []/[] units of fuel!", src, src.name, get_fuel(),src.max_fuel )


/obj/item/weldingtool/attackby(obj/item/W as obj, var/mob/user)
	if(W.isscrewdriver())
		if(welding)
			user << "<span class='danger'>Stop welding first!</span>"
			return
		status = !status
		if(status)
			user << "<span class='notice'>You secure the welder.</span>"
		else
			user << "<span class='notice'>The welder can now be attached and modified.</span>"
		src.add_fingerprint(user)
		return

	if((!status) && (istype(W,/obj/item/stack/rods)))
		var/obj/item/stack/rods/R = W
		R.use(1)
		var/obj/item/flamethrower/F = new/obj/item/flamethrower(user.loc)
		src.loc = F
		F.weldtool = src
		if (user.client)
			user.client.screen -= src
		if (user.r_hand == src)
			user.remove_from_mob(src)
		else
			user.remove_from_mob(src)
		src.master = F
		src.layer = initial(src.layer)
		user.remove_from_mob(src)
		if (user.client)
			user.client.screen -= src
		src.loc = F
		src.add_fingerprint(user)
		return

	..()
	return


/obj/item/weldingtool/process()
	if(welding)
		if(!remove_fuel(0.05))
			setWelding(0)

/obj/item/weldingtool/afterattack(obj/O as obj, var/mob/user, proximity)
	if(!proximity) return
	if (istype(O, /obj/structure/reagent_dispensers/fueltank) && get_dist(src,O) <= 1 && !src.welding)
		O.reagents.trans_to_obj(src, max_fuel)
		user << "<span class='notice'>Welder refueled</span>"
		playsound(src.loc, 'sound/effects/refill.ogg', 50, 1, -6)
		return
	else if (istype(O, /obj/structure/reagent_dispensers/fueltank) && get_dist(src,O) <= 1 && src.welding)
		message_admins("[key_name_admin(user)] triggered a fueltank explosion with a welding tool.")
		log_game("[key_name(user)] triggered a fueltank explosion with a welding tool.")
		user << "<span class='danger'>You begin welding on the fueltank and with a moment of lucidity you realize, this might not have been the smartest thing you've ever done.</span>"
		var/obj/structure/reagent_dispensers/fueltank/tank = O
		tank.explode()
		return
	if (src.welding)
		remove_fuel(1)
		var/turf/location = get_turf(user)
		if(isliving(O))
			var/mob/living/L = O
			L.IgniteMob()
		if (istype(location, /turf))
			location.hotspot_expose(700, 50, 1)
	return


/obj/item/weldingtool/attack_self(var/mob/user)
	setWelding(!welding, usr)
	return

//Returns the amount of fuel in the welder
/obj/item/weldingtool/proc/get_fuel()
	return reagents.get_reagent_amount(REAGENT_FUEL)


//Removes fuel from the welding tool. If a mob is passed, it will perform an eyecheck on the mob. This should probably be renamed to use()
/obj/item/weldingtool/proc/remove_fuel(var/amount = 1, var/mob/M = null)
	if(!welding)
		return 0
	if(get_fuel() >= amount)
		burn_fuel(amount)
		if(M)
			handle_welding_damage(M)
		return 1
	else
		if(M)
			M << "<span class='notice'>You need more welding fuel to complete this task.</span>"
		return 0

/obj/item/weldingtool/proc/burn_fuel(var/amount)
	var/mob/living/in_mob = null

	//consider ourselves in a mob if we are in the mob's contents and not in their hands
	if(isliving(src.loc))
		var/mob/living/L = src.loc
		if(!(L.l_hand == src || L.r_hand == src))
			in_mob = L

	if(in_mob)
		amount = max(amount, 2)
		reagents.trans_id_to(in_mob, REAGENT_FUEL, amount)
		in_mob.IgniteMob()
	else
		reagents.remove_reagent(REAGENT_FUEL, amount)
		var/turf/location = get_turf(src.loc)
		if(location)
			location.hotspot_expose(700, 5)

//Returns whether or not the welding tool is currently on.
/obj/item/weldingtool/proc/isOn()
	return src.welding

/obj/item/weldingtool/get_storage_cost()
	if(isOn())
		return DO_NOT_STORE
	return ..()

/obj/item/weldingtool/update_icon()
	..()
	icon_state = welding ? "welder1" : "welder"
	var/mob/M = loc
	if(istype(M))
		M.update_inv_l_hand()
		M.update_inv_r_hand()

//Sets the welding state of the welding tool. If you see W.welding = 1 anywhere, please change it to W.setWelding(1)
//so that the welding tool updates accordingly
/obj/item/weldingtool/proc/setWelding(var/set_welding, var/mob/M)
	if(!status)	return

	var/turf/T = get_turf(src)
	//If we're turning it on
	if(set_welding && !welding)
		if (get_fuel() > 0)
			if(M)
				M << "<span class='notice'>You switch the [src] on.</span>"
			else if(T)
				T.visible_message("<span class='danger'>\The [src] turns on.</span>")
			src.force = 15
			src.damtype = "fire"
			welding = 1
			update_icon()
			processing_objects |= src
		else
			if(M)
				M << "<span class='notice'>You need more welding fuel to complete this task.</span>"
			return
	//Otherwise
	else if(!set_welding && welding)
		processing_objects -= src
		if(M)
			M << "<span class='notice'>You switch \the [src] off.</span>"
		else if(T)
			T.visible_message("<span class='warning'>\The [src] turns off.</span>")
		src.force = 3
		src.damtype = "brute"
		src.welding = 0
		update_icon()

/obj/item/weldingtool/largetank
	name = "industrial welding tool"
	max_fuel = 40

	matter = list(MATERIAL_STEEL = 70, MATERIAL_GLASS = 60)

/obj/item/weldingtool/hugetank
	name = "upgraded welding tool"
	max_fuel = 80
	w_class = 3.0

	matter = list(MATERIAL_STEEL = 70, MATERIAL_GLASS = 120)

/obj/item/weldingtool/experimental
	name = "experimental welding tool"
	max_fuel = 40
	w_class = 3.0

	matter = list(MATERIAL_STEEL = 70, MATERIAL_GLASS = 120)
	var/last_gen = 0



/obj/item/weldingtool/experimental/proc/fuel_gen()//Proc to make the experimental welder generate fuel, optimized as fuck -Sieve
	var/gen_amount = ((world.time-last_gen)/25)
	reagents += (gen_amount)
	if(reagents > max_fuel)
		reagents = max_fuel

/*
 * Crowbar
 */

/obj/item/crowbar
	name = "crowbar"
	desc = "Used to remove floors and to pry open doors."
	icon = 'icons/obj/items.dmi'
	icon_state = "crowbar"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	force = 5.0
	throwforce = 7.0
	item_state = "crowbar"
	w_class = 2.0

	matter = list(MATERIAL_STEEL = 50)
	center_of_mass = "x=16;y=20"
	attack_verb = list("attacked", "bashed", "battered", "bludgeoned", "whacked")

/obj/item/crowbar/iscrowbar()
	return 1

/obj/item/crowbar/red
	icon = 'icons/obj/items.dmi'
	icon_state = "red_crowbar"
	item_state = "crowbar_red"

/obj/item/weldingtool/attack(mob/living/M, mob/living/user, target_zone)

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/external/S = H.organs_by_name[target_zone]

		if(!S || !(S.robotic >= ORGAN_ROBOT) || user.a_intent != I_HELP)
			return ..()

		if(!welding)
			user << "<span class='warning'>You'll need to turn [src] on to patch the damage on [M]'s [S.name]!</span>"
			return 1

		if(S.robo_repair(15, BRUTE, "some dents", src, user))
			remove_fuel(1, user)

	else
		return ..()

/obj/item/weldingtool/iswelder()
	return 1

/obj/item/combitool
	name = "combi-tool"
	desc = "It even has one of those nubbins for doing the thingy."
	icon = 'icons/obj/combitool.dmi'
	icon_state = "combitool"
	w_class = 2

	var/list/tools = list(
		"screwdriver",
		"wrench",
		"wirecutters"
		)
	var/current_tool = 1

/obj/item/combitool/Initialize()
	desc = "[initial(desc)] ([tools.len]. [tools.len] possibilit[tools.len == 1 ? "y" : "ies"])"
	. = ..()

/obj/item/combitool/examine(var/mob/user)
	. = ..()
	if(. && tools.len)
		to_chat(user, "It has the following fittings:")
		for(var/tool in tools)
			to_chat(user, "- [tool][tools[current_tool] == tool ? " (selected)" : ""]")

/obj/item/combitool/istool()
	return TRUE

/obj/item/combitool/iswrench()
	return tools[current_tool] == "wrench"

/obj/item/combitool/isscrewdriver()
	return tools[current_tool] == "screwdriver"

/obj/item/combitool/iswirecutter()
	return tools[current_tool] == "wirecutters"

/obj/item/combitool/iscrowbar()
	return tools[current_tool] == "crowbar"

/obj/item/combitool/proc/update_tool()
	icon_state = "[initial(icon_state)]-[tools[current_tool]]"

/obj/item/combitool/attack_self(var/mob/user)
	if(++current_tool > tools.len) current_tool = 1
	var/tool = tools[current_tool]
	if(!tool)
		to_chat(user, "You can't seem to find any fittings in \the [src].")
	else
		to_chat(user, "You switch \the [src] to the [tool] fitting.")
	update_tool()
	return 1

/obj/item/combitool/omni
	name = "digitool"
	icon_state = "digitool"
	desc = "An advanced design with countless possibilities."
	tools = list(
		"crowbar",
		"screwdriver",
		"wrench",
		"wirecutters",
		"welder",
		"multitool"
		)

	var/welding
	var/max_fuel = 15

/obj/item/combitool/omni/Initialize()
	. = ..()
	create_reagents(max_fuel)
	reagents.add_reagent(REAGENT_FUEL, max_fuel)

/obj/item/combitool/omni/update_tool()
	..()
	welding = (tools[current_tool] == "welder")

/obj/item/combitool/omni/iswelder()
	return tools[current_tool] == "welder"

/obj/item/combitool/omni/ismultitool()
	return tools[current_tool] == "multitool"

/obj/item/combitool/omni/proc/remove_fuel(var/amount = 1, var/mob/user)
	if(!welding)
		return 0
	if(reagents.get_reagent_amount(REAGENT_FUEL) >= amount)
		reagents.remove_reagent(REAGENT_FUEL, amount)
		var/turf/location = get_turf(src.loc)
		if(location)
			location.hotspot_expose(700, 5)
		if(user)
			handle_welding_damage(user)
		return 1
	else
		if(user)
			to_chat(user, "<span class='notice'>You need more welding fuel to complete this task.</span>")
		return 0
