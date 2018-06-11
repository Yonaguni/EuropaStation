////////////////////////////////////////////////////////////////////////////////
/// Pills.
////////////////////////////////////////////////////////////////////////////////
/obj/item/reagent_containers/pill
	name = "pill"
	desc = "A pill of some sort of medicine."
	icon = 'icons/obj/chemical.dmi'
	icon_state = null
	item_state = "pill"
	randpixel = 7
	possible_transfer_amounts = null
	w_class = 1
	slot_flags = SLOT_EARS
	volume = 60
	var/obfuscate_contents = TRUE
	var/actual_reagent_name
	var/medication_name

/obj/item/reagent_containers/pill/get_default_codex_value(var/mob/user)
	return (HAS_ASPECT(user, ASPECT_PHARMACIST) && !isnull(actual_reagent_name)) ? "[actual_reagent_name] (chemical)" : ..()

/obj/item/reagent_containers/pill/examine(var/mob/user)
	..(user, 1)
	if(!isnull(actual_reagent_name) && !isnull(medication_name) && HAS_ASPECT(user, ASPECT_PHARMACIST))
		to_chat(user, "<span class='notice'>As far as you know, the brandname is <b>[medication_name]</b> and the active ingredient is <b>[actual_reagent_name]</b>.</span>")

/obj/item/reagent_containers/pill/attack(var/mob/M, var/mob/user, var/def_zone)
	return standard_feed_mob(user, M)

/obj/item/reagent_containers/pill/Initialize()
	. = ..()

	if(reagents && reagents.total_volume && obfuscate_contents)
		var/reagent_id = reagents.get_master_reagent()
		if(reagent_id)
			actual_reagent_name = reagents.get_master_reagent_name()
			if(actual_reagent_name && istype(loc, /obj/item/storage/firstaid))
				name = "[actual_reagent_name] pill"
			medication_name = get_random_medication_name_for_reagent(reagent_id)
			if(isnull(medicine_name_to_pill_state[medication_name]))
				medicine_name_to_pill_state[medication_name] = "pill[rand(1,20)]"
			icon_state = medicine_name_to_pill_state[medication_name]

	if(!icon_state)
		icon_state = "pill[rand(1, 20)]"

/obj/item/reagent_containers/pill/self_feed_message(var/mob/user)
	to_chat(user, "<span class='notice'>You swallow \the [src]</span>")

/obj/item/reagent_containers/pill/other_feed_message_start(var/mob/user, var/mob/target)
	user.visible_message("<span class='warning'>[user] is trying to force \the [target] to swallow \the [src]!</span>")

/obj/item/reagent_containers/pill/other_feed_message_finish(var/mob/user, var/mob/target)
	user.visible_message("<span class='warning'>[user] has forced \the [target] to swallow \the [src]!</span>")

/obj/item/reagent_containers/pill/feed_self_to(var/mob/user)
	if(istype(user) && istype(reagents))
		reagents.trans_to_mob(user, reagents.total_volume, CHEM_INGEST)
	var/mob/M = loc
	if(istype(M))
		if(user != M) // Aggressive pill feeding.
			M.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
		M.drop_from_inventory(src)
	qdel(src)

/obj/item/reagent_containers/pill/afterattack(obj/target, mob/user, proximity)
	if(proximity)
		if(target.is_open_container() && target.reagents)
			if(!target.reagents.total_volume)
				to_chat(user, "<span class='warning'>\The [target] is empty and can't dissolve \the [src].</span>")
				return
			to_chat(user, "<span class='notice'>You dissolve \the [src] in \the [target].</span>")
			user.attack_log += text("\[[time_stamp()]\] <font color='red'>Spiked \a [target] with a pill. Reagents: [reagentlist()]</font>")
			msg_admin_attack("[user.name] ([user.ckey]) spiked \a [target] with a pill. Reagents: [reagentlist()] (INTENT: [uppertext(user.a_intent)]) (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)")
			reagents.trans_to(target, reagents.total_volume)
			visible_message("<span class='warning'>\The [user] puts something in \the [target].</span>", 1)
			qdel(src)
