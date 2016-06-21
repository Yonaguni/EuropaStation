#define CARCASS_EMPTY    "empty"
#define CARCASS_FRESH    "fresh"
#define CARCASS_SKINNED  "skinned"
#define CARCASS_JOINTED  "jointed"

var/list/butchery_icons = list() // Icon cache.

/mob/living/var/meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat
/mob/living/var/meat_amount = 3
/mob/living/var/skin_type = /obj/item/stack/material/skin
/mob/living/var/skin_amount = 3
/mob/living/var/bone_type = /obj/item/bone/single
/mob/living/var/bone_amount = 3
/mob/living/var/skull_type // todo

// Harvest an animal's delicious byproducts
/mob/living/proc/harvest_meat()
	blood_splatter(get_turf(src), src, large=1)
	if(!meat_type || !meat_amount)
		return
	for(var/i=0;i<meat_amount;i++)
		var/obj/item/meat = new meat_type(get_turf(src))
		if(istype(meat, /obj/item/weapon/reagent_containers/food/snacks/meat))
			var/obj/item/weapon/reagent_containers/food/snacks/meat/slab = meat
			slab.set_source_mob(src.name)
		else
			meat.name = "[src.name] [meat.name]"

/mob/living/human/harvest_meat()
	..()
	for(var/obj/item/organ/internal/I in internal_organs)
		I.removed()

/mob/living/proc/harvest_skin()
	blood_splatter(get_turf(src), src, large=1)
	if(!skin_type || !skin_amount)
		return
	var/obj/item/stack/material/skin/S = new skin_type(get_turf(src), skin_amount)
	blood_splatter(get_turf(src), src, large = 1)
	S.set_source_mob(src.name)

/mob/living/proc/harvest_bones()
	var/turf/T = get_turf(src)
	if(!istype(T))
		return
	blood_splatter(T, src, large=1)
	if(bone_type && bone_amount)
		for(var/i=1;i<=bone_amount;i++)
			new bone_type(T)
	if(skull_type)
		new skull_type(T)

// Structure for conducting butchery on.
/obj/structure/butchery_hook
	name = "meat hook"
	desc = "It looks pretty sharp."
	anchored = 1
	density = 1

	icon = 'icons/obj/structures/butchery.dmi'
	icon_state = "spike"

	var/mob/living/occupant
	var/occupant_state = CARCASS_EMPTY
	var/kills_occupant = 1
	var/busy

/obj/structure/butchery_hook/return_air()
	var/turf/T = get_turf(src)
	if(istype(T))
		return T.return_air()

/obj/structure/butchery_hook/improvised
	name = "truss"
	icon_state = "improvised"
	kills_occupant = 0

/obj/structure/butchery_hook/attack_hand(var/mob/user)

	if(!occupant)
		return ..()

	if(occupant_state == CARCASS_FRESH)
		visible_message("<span class='notice'>\The [user] removes \the [occupant] from \the [src].</span>")
		occupant.forceMove(get_turf(src))
		occupant = null
		occupant_state = CARCASS_EMPTY
		busy = 0
		update_icon()
	else
		user << "<span class='warning'>\The [occupant] is so badly mangled that removing them from \the [src] would be pointless.</span>"
		return

/obj/structure/butchery_hook/MouseDrop_T(var/mob/target, var/mob/user)

	if(!istype(target) || !Adjacent(user) || !Adjacent(target))
		return ..()

	if(user.stat || user.restrained() || user.incapacitated())
		return

	if(!target.stat)
		user << "<span class='warning'>\The [target] won't stop moving around!</span>"
		return

	if(occupant)
		user << "<span class='warning'>\The [src] already has a carcass on it.</span>"
		return

	if(suitable_for_butchery(target))

		user.visible_message("<span class='danger'>\The [user] [kills_occupant ? "impales" : "hangs"] \the [target] on \the [src][(kills_occupant && target.stat != DEAD) ? ", killing them instantly!" : "."]</span>")

		if(target.stat != DEAD && kills_occupant)
			blood_splatter(get_turf(src), target, large=1)
			target.death()
			sleep(-1)
			if(!target)
				return // In case death() deletes the mob for whatever reason.
		target.forceMove(src)
		occupant = target
		occupant_state = CARCASS_FRESH
		update_icon()

	else

		user << "<span class='warning'>You cannot butcher \the [target].</span>"

/obj/structure/butchery_hook/proc/suitable_for_butchery(var/mob/living/victim)
	return (victim.meat_type && victim.meat_amount) || (victim.skin_type && victim.skin_amount) || (victim.bone_type && victim.bone_amount)

/obj/structure/butchery_hook/update_icon()
	overlays.Cut()
	if(occupant)
		occupant.set_dir(EAST)

		if(istype(occupant, /mob/living/human))
			var/image/I = image(occupant.icon, occupant.icon_state)
			I.overlays += occupant.overlays
			var/matrix/M = matrix()
			M.Turn(180)
			I.transform = M
			overlays += I
		else
			var/cache_key = "[occupant.icon_state]-[occupant.color]-[occupant_state]"
			if(!butchery_icons[cache_key])
				var/icon/I = icon(occupant.icon, occupant.icon_state)
				I.Shift(NORTH, 8)
				I.Turn(270)
				if(occupant_state != CARCASS_FRESH)
					I.GrayScale()
					if(occupant_state == CARCASS_SKINNED)
						I.Blend("#880000", ICON_MULTIPLY)
					else if(occupant_state == CARCASS_JOINTED)
						I.Blend("#885555", ICON_MULTIPLY)
				butchery_icons[cache_key] = I
			overlays += butchery_icons[cache_key]

/obj/structure/butchery_hook/attackby(var/obj/item/weapon/thing, var/mob/user)

	if(!thing.sharp)
		return ..()

	if(!occupant)
		user << "<span class = 'warning'>There is nothing on \the [src] to butcher.</span>"
		return

	if(busy)
		return

	busy = 1

	switch(occupant_state)

		// TODO: Gutting?

		if(CARCASS_FRESH)
			user.visible_message("<span class='notice'>\The [user] begins skinning \the [occupant].</span>")
			occupant.adjustBruteLoss(rand(10,20))
			sleep(-1)
			update_icon()
			if(!do_after(user, 40) || !user || !occupant)
				busy = 0
				return
			occupant.adjustBruteLoss(rand(80,100))
			user.visible_message("<span class='notice'>\The [user] finishes skinning \the [occupant].</span>")
			occupant.harvest_skin()
			occupant_state = CARCASS_SKINNED

		if(CARCASS_SKINNED)
			occupant.adjustBruteLoss(rand(50,60))
			sleep(-1)
			update_icon()
			user.visible_message("<span class='notice'>\The [user] begins deboning \the [occupant].</span>")
			if(!do_after(user, 30) || !user || !occupant)
				busy = 0
				return
			occupant.adjustBruteLoss(rand(50,60))
			user.visible_message("<span class='notice'>\The [user] finishes deboning \the [occupant].</span>")
			if(occupant)
				occupant.harvest_bones()
				occupant_state = CARCASS_JOINTED
			else
				occupant_state = CARCASS_EMPTY // In case death() deletes it.

		if(CARCASS_JOINTED)
			occupant.adjustBruteLoss(rand(50,60))
			user.visible_message("<span class='notice'>\The [user] begins butchering \the [occupant].</span>")
			if(!do_after(user, 50) || !user || !occupant)
				busy = 0
				return
			user.visible_message("<span class='notice'>\The [user] finishes butchering \the [occupant].</span>")
			occupant.harvest_meat()
			occupant_state = CARCASS_EMPTY

	busy = 0

	// Changelings or something. Idk.
	if(occupant.stat != DEAD)
		occupant.death()

	if(occupant_state == CARCASS_EMPTY)
		if(occupant)
			for(var/obj/item/W in occupant)
				occupant.drop_from_inventory(W)
			qdel(occupant)
			occupant = null

	sleep(5)
	update_icon()

#undef CARCASS_EMPTY
#undef CARCASS_FRESH
#undef CARCASS_SKINNED
#undef CARCASS_JOINTED