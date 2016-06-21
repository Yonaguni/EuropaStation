atom/proc/tram_act()

mob/living/human/tram_act(var/obj/tram/tram_controller/tram,dir)
	if(lying)
		gib()
		tram.gibbed += src
	else //if it's not lying down, push it and break its face
		apply_damage(5) //brute by default, 50 damage in one second
		if(prob(2)) Weaken(2) //RNGesus is not in your favor, RIP buddy...
		step_towards(src, get_step(get_turf(src),dir))
mob/living/tram_act(var/obj/tram/tram_controller/tram)
	gib() //gib all non-carbon things like simple mobs
	tram.gibbed += src
obj/tram/tram_act(var/obj/tram/tram_controller/tram)
	ex_act(1.0)