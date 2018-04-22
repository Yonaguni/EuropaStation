/obj/structure/pit
	name = "pit"
	desc = "Watch your step, partner."
	icon = 'icons/obj/structures/pit.dmi'
	icon_state = "pit1"
	blend_mode = BLEND_MULTIPLY
	density = 0
	anchored = 1
	var/open = 1

/obj/structure/pit/attackby(obj/item/W, mob/user)
	if( istype(W,/obj/item/shovel) )
		visible_message("<span class='notice'>\The [user] starts [open ? "filling" : "digging open"] \the [src]</span>")
		if( do_after(user, 50) )
			visible_message("<span class='notice'>\The [user] [open ? "fills" : "digs open"] \the [src]!</span>")
			if(open)
				close(user)
			else
				open()
		else
			user << "<span class='notice'>You stop shoveling.</span>"
		return
	if (!open && istype(W,/obj/item/stack/material/wood))
		if(locate(/obj/structure/gravemarker) in src.loc)
			user << "<span class='notice'>There's already a grave marker here.</span>"
		else
			visible_message("<span class='notice'>\The [user] starts making a grave marker on top of \the [src]</span>")
			if( do_after(user, 50) )
				visible_message("<span class='notice'>\The [user] finishes the grave marker</span>")
				var/obj/item/stack/material/wood/plank = W
				plank.use(1)
				new/obj/structure/gravemarker(src.loc)
			else
				user << "<span class='notice'>You stop making a grave marker.</span>"
		return
	..()

/obj/structure/pit/update_icon()
	icon_state = "pit[open]"
	if(istype(loc,/turf/simulated/floor/water))
		icon_state="pit[open]mud"
		blend_mode = BLEND_OVERLAY

/obj/structure/pit/proc/open()
	name = "pit"
	desc = "Watch your step, partner."
	open = 1
	for(var/atom/movable/A in src)
		A.forceMove(src.loc)
	update_icon()

/obj/structure/pit/proc/close(var/user)
	name = "mound"
	desc = "Some things are better left buried."
	open = 0
	for(var/atom/movable/A in src.loc)
		if(!A.anchored && A != user)
			A.forceMove(src)
	update_icon()

/obj/structure/pit/return_air()
	return open

/obj/structure/pit/proc/digout(mob/escapee)
	var/breakout_time = 1 //2 minutes by default

	if(open)
		return

	if(escapee.stat || escapee.restrained())
		return

	escapee.setClickCooldown(100)
	escapee << "<span class='warning'>You start digging your way out of \the [src] (this will take about [breakout_time] minute\s)</span>"
	visible_message("<span class='danger'>Something is scratching its way out of \the [src]!</span>")

	for(var/i in 1 to (6*breakout_time * 2)) //minutes * 6 * 5seconds * 2
		playsound(src.loc, 'sound/weapons/bite.ogg', 100, 1)

		if(!do_after(escapee, 50))
			escapee << "<span class='warning'>You have stopped digging.</span>"
			return
		if(!escapee || escapee.stat || escapee.loc != src)
			return
		if(open)
			return

		if(i == 6*breakout_time)
			escapee << "<span class='warning'>Halfway there...</span>"

	escapee << "<span class='warning'>You successfuly dig yourself out!</span>"
	visible_message("<span class='danger'>\the [escapee] emerges from \the [src]!</span>")
	playsound(src.loc, 'sound/effects/squelch1.ogg', 100, 1)
	open()

/obj/structure/pit/closed
	name = "mound"
	desc = "Some things are better left buried."
	open = 0
	auto_init = TRUE

/obj/structure/pit/closed/initialize()
	..()
	close()

//invisible until unearthed first
/obj/structure/pit/closed/hidden
	invisibility = INVISIBILITY_OBSERVER

/obj/structure/pit/closed/hidden/open()
	..()
	invisibility = INVISIBILITY_LEVEL_ONE

//spoooky
/obj/structure/pit/closed/grave
	name = "grave"
	icon_state = "pit0"

/obj/structure/pit/closed/grave/initialize()
	var/obj/structure/closet/coffin/C = new(src.loc)
	var/obj/item/remains/human/bones = new(C)
	bones.layer = MOB_LAYER

	/*
	var/loot
	var/list/suits = list()
	loot = pick(suits)
	new loot(C)

	var/list/uniforms = list()
	loot = pick(uniforms)
	new loot(C)

	if(prob(30))
		var/list/misc = list()
		loot = pick(misc)
		new loot(C)
	*/

	var/obj/structure/gravemarker/random/R = new(src.loc)
	R.generate()
	..()

/obj/structure/gravemarker
	name = "grave marker"
	desc = "You're not the first."
	icon = 'icons/obj/structures/gravestone.dmi'
	icon_state = "wood"
	pixel_x = 15
	pixel_y = 8
	anchored = 1
	var/message = "Unknown."

/obj/structure/gravemarker/cross
	icon_state = "cross"

/obj/structure/gravemarker/examine()
	..()
	usr << message

/obj/structure/gravemarker/random
	auto_init = TRUE

/obj/structure/gravemarker/random/initialize()
	generate()
	..()

/obj/structure/gravemarker/random/proc/generate()
	icon_state = pick("wood","cross")

	var/datum/faction/faction = factions_by_name[pick(factions_by_name)]
	var/nam = faction.get_random_name(pick(MALE,FEMALE))
	var/born = game_year - rand(5,150)
	var/died = max(game_year - rand(0,70),born)
	message = "Here lies [nam], [born] - [died]."

/obj/structure/gravemarker/attackby(obj/item/W, mob/user)
	if(istype(W,/obj/item/material/hatchet))
		visible_message("<span class = 'warning'>\The [user] starts hacking away at \the [src] with \the [W].</span>")
		if(!do_after(user, 30))
			visible_message("<span class = 'warning'>\The [user] hacks \the [src] apart.</span>")
			new /obj/item/stack/material/wood(src)
			qdel(src)
	if(istype(W,/obj/item/pen))
		var/msg = sanitize(input(user, "What should it say?", "Grave marker", message) as text|null)
		if(msg)
			message = msg
