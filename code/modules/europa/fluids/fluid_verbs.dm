/client/spawn_fluid_proc()
	..()
	for(var/thing in trange(1, get_turf(usr)))
		var/obj/effect/fluid/F = locate() in thing
		if(!F) F = new(thing)
		F.set_depth(2000)