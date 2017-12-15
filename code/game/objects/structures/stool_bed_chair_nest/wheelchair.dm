/obj/structure/bed/chair/wheelchair
	name = "wheelchair"
	desc = "You sit in this. Either by will or force."
	icon_state = "wheelchair"
	anchored = 0
	buckle_movable = 1

	var/mob/living/pulling = null
	var/bloodiness

/obj/structure/bed/chair/wheelchair/update_icon()
	return

/obj/structure/bed/chair/wheelchair/set_dir()
	..()
	overlays = null
	var/image/O = image(icon = 'icons/obj/furniture.dmi', icon_state = "w_overlay", layer = FLY_LAYER, dir = src.dir)
	overlays += O
	if(buckled_mob)
		buckled_mob.set_dir(dir)

/obj/structure/bed/chair/wheelchair/attackby(var/obj/item/W, var/mob/user)
	if(W.iswrench() || istype(W,/obj/item/stack) || W.iswirecutter())
		return
	..()

/obj/structure/bed/chair/wheelchair/relaymove(mob/user, direction)
	step(src, direction)
	if(bloodiness) create_track()
	set_dir(direction)

/obj/structure/bed/chair/wheelchair/Move()
	. = ..()
	if(. && buckled_mob)
		buckled_mob.forceMove(get_turf(src))

/obj/structure/bed/chair/wheelchair/attack_hand(var/mob/living/user)
	if (pulling)
		MouseDrop(usr)
	else
		user_unbuckle_mob(user)

/obj/structure/bed/chair/wheelchair/proc/create_track()
	var/obj/effect/decal/cleanable/blood/tracks/B = new(loc)
	var/newdir = get_dir(get_step(loc, dir), loc)
	if(newdir == dir)
		B.set_dir(newdir)
	else
		newdir = newdir | dir
		if(newdir == 3)
			newdir = 1
		else if(newdir == 12)
			newdir = 4
		B.set_dir(newdir)
	bloodiness--
