/obj/structure/shrine
	name = "crude shrine"
	desc = "It's a crude pile of material, roughly shaped like a shrine. Not very convincing, really."
	icon = 'icons/obj/structures/convergence.dmi'
	icon_state = "shrine"
	anchored = TRUE
	density = TRUE
	opacity = FALSE

	var/unfinished = TRUE
	var/health = 100
	var/maxhealth = 100
	var/material/material
	var/mob/living/presence/sanctified_to

/obj/structure/shrine/Destroy()
	sanctified_to = null
	. = ..()

/obj/structure/shrine/New(var/newloc, var/material_name, var/_sanctified_to)
	..(newloc)
	sanctified_to = _sanctified_to
	if(!material_name) material_name = "wood"
	material = get_material_by_name("[material_name]")
	if(!material)
		qdel(src)
		return
	update_strings()
	color = material.icon_colour
	maxhealth = material.integrity
	health = maxhealth
	update_from_presence()

/obj/structure/shrine/proc/update_from_presence()
	return

/obj/structure/shrine/proc/update_strings()
	name = "[material.display_name] shrine"
	desc = "It's a crude pile of [material.name], shaped into a rough shrine. Not very convincing, really."

/obj/structure/shrine/attack_hand(var/mob/user)
	if(user.mind && godtouched.is_antagonist(user.mind))
		var/try_sanctify_to = presences.get_presence_from_believer(user)
		if(sanctified_to)
			if(sanctified_to != try_sanctify_to)
				to_chat(user, "<span class='danger'>\The [src] crackles with power, nearly burning your hand! It is sanctified to someone other than the one you serve!</span>")
			else
				to_chat(user, "<span class='notice'>\The [src] is already sanctified to your master.</span>")
			return
		user.visible_message("<span class='danger'>\The [user] slices open a palm on \the [src], sanctifying it with blood.</span>")
		sanctified_to = try_sanctify_to
		to_chat(sanctified_to, "<span class='notice'>A shrine has been raised in your name, by <b>\the [user]</b>, \
			in <b>\the [get_area(loc)]</b>. <a href='?src=\ref[sanctified_to];jump_to_believer=\ref[user]'>(JMP)</a>")
		return
	. = ..()

/obj/structure/shrine/attackby(var/obj/item/thing, var/mob/user)

	if(istype(thing, /obj/item/stack))
		var/obj/item/stack/D = thing
		if(D.get_material_name() != material.name) return
		if (health < maxhealth)
			if (D.get_amount() < 1)
				user << "<span class='warning'>You need one sheet of [material.display_name] to repair \the [src].</span>"
				return
			visible_message("<span class='notice'>\The [user] begins to repair \the [src].</span>")
			if(do_after(user,20,src) && health < maxhealth)
				if (D.use(1))
					health = maxhealth
					visible_message("<span class='notice'>\The [user] repairs \the [src].</span>")
				return
		return

	if(thing.force)
		user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
		health -= thing.force
		if(health <= 0)
			visible_message("<span class='danger'>\The [src] is smashed apart!</span>")
			material.place_dismantled_product(get_turf(src))
			qdel(src)
			return
	. = ..()

/obj/structure/shrine/ex_act(severity)
	var/damage = 0
	switch(severity)
		if(1) damage = 25
		if(2) damage = 100
	health -= damage
	if(health <= 0)
		visible_message("<span class='danger'>\The [src] is blown apart!</span>")
		material.place_dismantled_product(get_turf(src))
		qdel(src)
