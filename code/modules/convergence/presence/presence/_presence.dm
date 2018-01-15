var/list/presence_templates = list()

/proc/populate_presence_templates()
	for(var/godtype in subtypesof(/decl/presence_template))
		var/decl/presence_template/godhood = new godtype
		presence_templates[godhood.archetype] = godhood

/decl/presence_template

	// Various display strings and IDs.
	var/title
	var/audience = "folks"
	var/archetype = "God"
	var/icon_state = "generic"
	var/welcome_message = "Don't mess it up."
	var/sigil_activation_failure_message = "You cannot activate this sigil with an uncharged rod."
	var/unit_name = "mojo"

	// Regalia strings/icons.
	var/structure_material = "marble"

	var/rod_name = "rod"
	var/rod_desc = "It's a rod."
	var/rod_icon = "rod"
	var/rod_path = /obj/item/convergence/rod

	var/crown_name = "crown"
	var/crown_desc = "It's a crown."
	var/crown_icon = "crown"
	var/crown_path = /obj/item/convergence/crown

	var/orb_name = "orb"
	var/orb_desc = "It's an orb."
	var/orb_icon = "orb"
	var/orb_path = /obj/item/convergence/orb

	var/altar_name = "altar"
	var/altar_desc = "An altar."
	var/altar_icon = "altar"
	var/altar_path = /obj/structure/shrine/altar

	var/totem_name = "totem"
	var/totem_desc = "A totem."
	var/totem_icon = "totem"
	var/totem_path = /obj/structure/shrine/totem

	var/death_message = "A strange, thin cry, felt rather than heard, pounds through your skull as an unnatural presence is thrust back into the irreal continuum that spawned it."

	// Power and miracle tracking. Only contains the root powers, all further checking is done via children.
	var/list/available_powers = list()

/decl/presence_template/New()
	..()
	var/list/base_power_types = available_powers.Copy()
	available_powers.Cut()
	for(var/ptype in base_power_types)
		available_powers += new ptype(src)

/decl/presence_template/proc/regalia_melee_attack_used(var/mob/user, var/atom/target, var/obj/item/convergence/regalia)
	var/obj/structure/shrine/altar/altar = locate(altar_path) in target.loc // Used frequently.

	if(istype(altar) && altar.sanctified_to == regalia.sanctified_to)

		if(regalia.regalia_type == REGALIA_ROD)
			var/sacrifice_failed = is_acceptable_sacrifice(target)
			if(sacrifice_failed)
				to_chat(user, "<span class='warning'>[sacrifice_failed]</span>")
				return TRUE
			return perform_sacrifice(user, target, regalia, altar)

		if(regalia.regalia_type == REGALIA_ORB)
			return altar.try_force_convert(user, target)

	return FALSE

// This is basically an example placeholder so specifics don't matter much.
/decl/presence_template/proc/perform_sacrifice(var/mob/user, var/atom/target, var/obj/item/convergence/regalia, var/obj/structure/shrine/altar)
	return FALSE

/decl/presence_template/proc/is_acceptable_sacrifice(var/atom/movable/sacrificing)
	return "Your master does not desire sacrifices."

/decl/presence_template/proc/regalia_ranged_attack_used(var/mob/user, var/atom/target, var/obj/item/convergence/regalia)
	return FALSE

/decl/presence_template/proc/regalia_used_in_hand(var/mob/user, var/obj/item/convergence/regalia)
	return FALSE

/decl/presence_template/proc/get_regalia_size(var/obj/item/convergence/regalia)
	switch(regalia.regalia_type)
		if(REGALIA_ORB)
			return 2
		if(REGALIA_ROD)
			return 4
		if(REGALIA_CROWN)
			return 3

/decl/presence_template/proc/welcome_presence(var/mob/living/presence/new_presence)
	to_chat(new_presence, "<span class='notice'>You are \a <b>[archetype]</b>, known to [audience] as <b>[title]</b>. [welcome_message].</span>")
	for(var/thing in available_powers)
		new_presence.purchased_powers[thing] = TRUE

/decl/presence_template/proc/do_melee_manifested_interaction(var/mob/presence/user, var/atom/target)
	return

/decl/presence_template/proc/do_ranged_manifested_interaction(var/mob/presence/user, var/atom/target)
	return
