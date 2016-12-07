////////////////////////////////////////////////////////////////////////////////
/// Pills.
////////////////////////////////////////////////////////////////////////////////
/obj/item/reagent_containers/pill
	name = "pill"
	desc = "A pill."
	icon = 'icons/obj/chemical.dmi'
	icon_state = null
	item_state = "pill"
	randpixel = 7
	possible_transfer_amounts = null
	w_class = 1
	slot_flags = SLOT_EARS
	volume = 60

	New()
		..()
		if(!icon_state)
			icon_state = "pill[rand(1, 20)]"

	attack(var/mob/M, var/mob/user, def_zone)
		//TODO: replace with standard_feed_mob() call.

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

	afterattack(obj/target, mob/user, proximity)
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
/obj/item/reagent_containers/pill/antitox
	name = "anti-toxins pill"
	desc = "Neutralizes many common toxins."
	icon_state = "pill17"
	New()
		..()
		reagents.add_reagent("anti_toxin", 25)

/obj/item/reagent_containers/pill/tox
	name = "toxins pill"
	desc = "Highly toxic."
	icon_state = "pill5"
	New()
		..()
		reagents.add_reagent("toxin", 50)

/obj/item/reagent_containers/pill/cyanide
	name = "cyanide pill"
	desc = "Don't swallow this."
	icon_state = "pill5"
	New()
		..()
		reagents.add_reagent("cyanide", 50)

/obj/item/reagent_containers/pill/adminordrazine
	name = "adminordrazine pill"
	desc = "It's magic. We don't have to explain it."
	icon_state = "pill16"
	New()
		..()
		reagents.add_reagent("adminordrazine", 50)

/obj/item/reagent_containers/pill/stox
	name = "sleeping pill"
	desc = "Commonly used to treat insomnia."
	icon_state = "pill8"
	New()
		..()
		reagents.add_reagent("stoxin", 15)

/obj/item/reagent_containers/pill/fotiazine
	name = "fotiazine pill"
	desc = "Used to treat burns."
	icon_state = "pill11"
	New()
		..()
		reagents.add_reagent("fotiazine", 15)

/obj/item/reagent_containers/pill/paracetamol
	name = "paracetamol pill"
	desc = "Tylenol! A painkiller for the ages. Chewables!"
	icon_state = "pill8"
	New()
		..()
		reagents.add_reagent("paracetamol", 15)

/obj/item/reagent_containers/pill/morphine
	name = "morphine pill"
	desc = "A highly addictive painkiller."
	icon_state = "pill8"
	New()
		..()
		reagents.add_reagent("morphine", 15)


/obj/item/reagent_containers/pill/methylphenidate
	name = "methylphenidate pill"
	desc = "Improves the ability to concentrate."
	icon_state = "pill8"
	New()
		..()
		reagents.add_reagent("methylphenidate", 15)

/obj/item/reagent_containers/pill/citalopram
	name = "citalopram pill"
	desc = "Mild anti-depressant."
	icon_state = "pill8"
	New()
		..()
		reagents.add_reagent("citalopram", 15)


/obj/item/reagent_containers/pill/adrenaline
	name = "adrenaline pill"
	desc = "Used to stabilize patients."
	icon_state = "pill20"
	New()
		..()
		reagents.add_reagent("adrenaline", 30)

/obj/item/reagent_containers/pill/dexalin
	name = "dexalin pill"
	desc = "Used to treat oxygen deprivation."
	icon_state = "pill16"
	New()
		..()
		reagents.add_reagent("dexalin", 15)

/obj/item/reagent_containers/pill/dylovene
	name = "dylovene pill"
	desc = "A broad-spectrum anti-toxin."
	icon_state = "pill13"
	New()
		..()
		reagents.add_reagent("anti_toxin", 15)

/obj/item/reagent_containers/pill/styptazine
	name = "styptazine pill"
	desc = "Used to treat physical injuries."
	icon_state = "pill18"
	New()
		..()
		reagents.add_reagent("styptazine", 20)

/obj/item/reagent_containers/pill/happy
	name = "\improper Happy pill"
	desc = "Happy happy joy joy!"
	icon_state = "pill18"
	New()
		..()
		reagents.add_reagent("glint", 15)
		reagents.add_reagent("sugar", 15)

/obj/item/reagent_containers/pill/zoom
	name = "\improper Zoom pill"
	desc = "Zoooom!"
	icon_state = "pill18"
	New()
		..()
		reagents.add_reagent("impedrezene", 10)
		reagents.add_reagent("synaptizine", 5)
		reagents.add_reagent("jumpstart", 5)

/obj/item/reagent_containers/pill/antibiotic
	name = "antibiotic pill"
	desc = "Contains antiviral agents."
	icon_state = "pill19"
	New()
		..()
		reagents.add_reagent("antibiotic", 15)

/obj/item/reagent_containers/pill/diet
	name = "diet pill"
	desc = "Guaranteed to get you slim!"
	icon_state = "pill9"
	New()
		..()
		reagents.add_reagent("lipozine", 2)

/obj/item/reagent_containers/pill/pax
	name = "\improper Pax pill"
	desc = "You're already feeling peaceful."
	icon_state = "pill18"
	New()
		..()
		reagents.add_reagent("pax", 15)

/obj/item/reagent_containers/pill/ladder
	name = "\improper Ladder pill"
	desc = "You won't like you when you're angry."
	icon_state = "pill18"
	New()
		..()
		reagents.add_reagent("ladder", 15)

/obj/item/reagent_containers/pill/threeeye
	name = "\improper Three Eye pill"
	desc = "Whoa."
	icon_state = "pill18"
	New()
		..()
		reagents.add_reagent("threeeye", 15)

/obj/item/reagent_containers/pill/lsd
	name = "\improper LSD pill"
	desc = "We can't stop here."
	icon_state = "pill18"
	New()
		..()
		reagents.add_reagent("lsd", 15)

/obj/item/reagent_containers/pill/glint
	name = "\improper Glint pill"
	desc = "for when you want to see the rainbow."
	icon_state = "pill18"
	New()
		..()
		reagents.add_reagent("glint", 15)

/obj/item/reagent_containers/pill/jumpstart
	name = "\improper Jumpstart pill"
	desc = "Gotta go fast."
	icon_state = "pill18"
	New()
		..()
		reagents.add_reagent("jumpstart", 15)
