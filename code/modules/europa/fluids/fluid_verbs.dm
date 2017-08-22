/client/spawn_fluid_proc(var/override)
	..(TRUE)
	for(var/thing in trange(1, get_turf(usr)))
		var/obj/effect/fluid/F = locate() in thing
		if(!F) F = new(thing)
		F.set_depth(2000)

/client/jump_to_fluid_source_proc(var/override)
	..(TRUE)
	if(fluid_master.water_sources.len)
		usr.forceMove(get_turf(pick(fluid_master.water_sources)))
	else
		to_chat(usr, "No active fluid sources.")

/client/jump_to_active_fluid_proc(var/override)
	..(TRUE)
	if(fluid_master.active_fluids.len)
		usr.forceMove(get_turf(pick(fluid_master.active_fluids)))
	else
		to_chat(usr, "No active fluids.")