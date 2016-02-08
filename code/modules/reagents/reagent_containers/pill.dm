////////////////////////////////////////////////////////////////////////////////
/// Pills.
////////////////////////////////////////////////////////////////////////////////
/obj/item/weapon/reagent_containers/pill
	name = "pill"
	desc = "a pill."
	icon = 'icons/obj/chemical.dmi'
	icon_state = null
	item_state = "pill"
	possible_transfer_amounts = null
	w_class = 1
	slot_flags = SLOT_EARS
	volume = 60

/obj/item/weapon/reagent_containers/pill/New()
	..()
	if(!icon_state)
		icon_state = "pill[rand(1, 20)]"

/obj/item/weapon/reagent_containers/pill/attack(mob/M as mob, mob/user as mob, def_zone)

	if(M == user)
		if(!M.can_eat(src))
			return

		M << "<span class='notice'>You swallow \the [src].</span>"
		M.drop_from_inventory(src) //icon update
		if(reagents.total_volume)
			reagents.trans_to_mob(M, reagents.total_volume, CHEM_INGEST)
		qdel(src)
		return 1

	else if(istype(M, /mob/living/carbon/human))
		if(!M.can_force_feed(user, src))
			return

		user.visible_message("<span class='warning'>[user] attempts to force [M] to swallow \the [src].</span>")

		user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
		if(!do_mob(user, M))
			return

		user.drop_from_inventory(src) //icon update
		user.visible_message("<span class='warning'>[user] forces [M] to swallow \the [src].</span>")

		var/contained = reagentlist()
		M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been fed [name] by [key_name(user)] Reagents: [contained]</font>")
		user.attack_log += text("\[[time_stamp()]\] <font color='red'>Fed [name] to [key_name(M)] Reagents: [contained]</font>")
		msg_admin_attack("[key_name_admin(user)] fed [key_name_admin(M)] with [name] Reagents: [contained] (INTENT: [uppertext(user.a_intent)]) (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)")

		if(reagents.total_volume)
			reagents.trans_to_mob(M, reagents.total_volume, CHEM_INGEST)
		qdel(src)

		return 1

	return 0

/obj/item/weapon/reagent_containers/pill/afterattack(obj/target, mob/user, proximity)
	if(!proximity) return

	if(target.is_open_container() && target.reagents)
		if(!target.reagents.total_volume)
			user << "<span class='notice'>[target] is empty. Can't dissolve \the [src].</span>"
			return
		user << "<span class='notice'>You dissolve \the [src] in [target].</span>"

		user.attack_log += text("\[[time_stamp()]\] <font color='red'>Spiked \a [target] with a pill. Reagents: [reagentlist()]</font>")
		msg_admin_attack("[user.name] ([user.ckey]) spiked \a [target] with a pill. Reagents: [reagentlist()] (INTENT: [uppertext(user.a_intent)]) (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)")

		reagents.trans_to(target, reagents.total_volume)
		for(var/mob/O in viewers(2, user))
			O.show_message("<span class='warning'>[user] puts something in \the [target].</span>", 1)

		qdel(src)

	return

////////////////////////////////////////////////////////////////////////////////
/// Pills. END
////////////////////////////////////////////////////////////////////////////////

//Pills
/obj/item/weapon/reagent_containers/pill/antitox
	name = "anti-toxins pill"
	desc = "Neutralizes many common toxins."
	icon_state = "pill17"

/obj/item/weapon/reagent_containers/pill/antitox/initialize()
	..()
	reagents.add_reagent("anti_toxin", 25)

/obj/item/weapon/reagent_containers/pill/cyanide
	name = "cyanide pill"
	desc = "Don't swallow this."
	icon_state = "pill5"

/obj/item/weapon/reagent_containers/pill/cyanide/initialize()
	..()
	reagents.add_reagent("cyanide", 50)

/obj/item/weapon/reagent_containers/pill/stox
	name = "sleeping pill"
	desc = "Commonly used to treat insomnia."
	icon_state = "pill8"

/obj/item/weapon/reagent_containers/pill/stox/initialize()
	..()
	reagents.add_reagent("stoxin", 15)

/obj/item/weapon/reagent_containers/pill/paracetamol
	name = "paracetamol pill"
	desc = "Tylenol! A painkiller for the ages. Chewables!"
	icon_state = "pill8"

/obj/item/weapon/reagent_containers/pill/paracetamol/initialize()
	..()
	reagents.add_reagent("paracetamol", 15)

/obj/item/weapon/reagent_containers/pill/morphine
	name = "morphine pill"
	desc = "A powerful and addictive painkiller."
	icon_state = "pill8"

/obj/item/weapon/reagent_containers/pill/morphine/initialize()
	..()
	reagents.add_reagent("morphine", 15)

/obj/item/weapon/reagent_containers/pill/antidepressant
	name = "antidepressant pill"
	desc = "Mild anti-depressant."
	icon_state = "pill8"

/obj/item/weapon/reagent_containers/pill/antidepressant/initialize()
	..()
	reagents.add_reagent("antidepressant", 15)

/obj/item/weapon/reagent_containers/pill/adrenaline
	name = "adrenaline pill"
	desc = "Used to stabilize patients."
	icon_state = "pill20"

/obj/item/weapon/reagent_containers/pill/adrenaline/initialize()
	..()
	reagents.add_reagent("adrenaline", 30)

/obj/item/weapon/reagent_containers/pill/antitoxin
	name = "Dylovene pill"
	desc = "A broad-spectrum anti-toxin."
	icon_state = "pill13"

/obj/item/weapon/reagent_containers/pill/antitoxin/initialize()
	..()
	reagents.add_reagent("anti_toxin", 15)

/obj/item/weapon/reagent_containers/pill/antibiotic
	name = "antibiotic pill"
	desc = "Contains antibiotic and antiviral agents."
	icon_state = "pill19"

/obj/item/weapon/reagent_containers/pill/antibiotic/initialize()
	..()
	reagents.add_reagent("antibiotic", 15)

/obj/item/weapon/reagent_containers/pill/jumpstart
	name = "jumpstart pill"
	desc = "A Hell of a kick-start, in convenient pill form."
	icon_state = "pill19"

/obj/item/weapon/reagent_containers/pill/jumpstart/initialize()
	..()
	reagents.add_reagent("jumpstart", 15)
