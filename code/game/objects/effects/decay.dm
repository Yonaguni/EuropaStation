/obj/effect/cleanable/decay
	anchored = 1
	opacity = 0
	density = 0
	mouse_opacity = 0
	icon = 'icons/effects/environment.dmi'
	layer = TURF_LAYER + 0.03

/obj/effect/cleanable/decay/Initialize()
	. = ..()
	if(prob(75))
		var/matrix/M = matrix()
		M.Turn(pick(list(90,180,270)))
		transform = M
	if(prob(10))
		icon_state += "-edge"
	else
		var/moss_count = 0
		var/turf/current_turf = get_turf(src)
		if(istype(current_turf))
			for(var/checkdir in cardinal)
				var/turf/checking = get_step(current_turf, checkdir)
				if(istype(checking))
					for(var/obj/effect/cleanable/decay/neighbor in checking.contents)
						if(neighbor != src && istype(neighbor, type))
							moss_count++
		if(moss_count < 2 || prob(25))
			icon_state += "-edge"

/obj/effect/cleanable/decay/rust
	name = "surface rust"
	icon_state = "rust"
	alpha = 100

/obj/effect/cleanable/decay/rust/Initialize()
	. = ..()
	alpha = rand(60,100)

/obj/effect/cleanable/decay/moss
	name = "moss"
	icon_state = "moss"
	alpha = 140

/obj/effect/cleanable/decay/moss/Initialize()
	. = ..()
	alpha = rand(80,140)
