/client/spawn_fluid_proc(var/override)
	..(TRUE)
	for(var/thing in trange(1, get_turf(usr)))
		var/obj/effect/fluid/F = locate() in thing
		if(!F) F = new(thing)
		SET_FLUID_DEPTH(F, 2000)

/client/jump_to_fluid_source_proc(var/override)
	..(TRUE)
	if(SSfluids.water_sources.len)
		usr.forceMove(get_turf(pick(SSfluids.water_sources)))
	else
		to_chat(usr, "No active fluid sources.")

/client/jump_to_active_fluid_proc(var/override)
	..(TRUE)
	if(SSfluids.active_fluids.len)
		usr.forceMove(get_turf(pick(SSfluids.active_fluids)))
	else
		to_chat(usr, "No active fluids.")