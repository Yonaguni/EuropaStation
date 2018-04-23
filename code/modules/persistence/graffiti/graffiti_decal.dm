/obj/effect/decal/writing
	name = "writing"
	icon_state = "graffiti"
	icon = 'icons/effects/writing.dmi'
	desc = "It looks like someone has scratched something here."
	gender = NEUTER
	blend_mode = BLEND_SUBTRACT
	alpha = 80
	auto_init = TRUE

	var/message
	var/graffiti_age = 0
	var/author = "unknown"

/obj/effect/decal/writing/initialize()

	var/list/random_icon_states = list("writing1","writing2","writing3","writing4","writing5")
	for(var/obj/effect/decal/writing/W in loc)
		random_icon_states.Remove(W.icon_state)
	if(random_icon_states.len)
		icon_state = pick(random_icon_states)
	else
		icon_state = "writing1"
	LAZYADD(SSpersistence.graffiti, src)
	. = ..()

/obj/effect/decal/writing/Destroy()
	LAZYREMOVE(SSpersistence.graffiti, src)
	. = ..()

/obj/effect/decal/writing/examine(mob/user)
	..(user)
	user << "It reads \"[message]\"."
