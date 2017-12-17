///Process_Grab()
///Called by client/Move()
///Checks to see if you are grabbing or being grabbed by anything and if moving will affect your grab.
/client/proc/Process_Grab()
	//if we are being grabbed
	if(isliving(mob))
		var/mob/living/L = mob
		if(!L.canmove && LAZYLEN(L.grabbed_by))
			L.resist() //shortcut for resisting grabs

	//if we are grabbing someone
	for(var/obj/item/grab/G in mob.get_grabs())
		G.reset_kill_state() //no wandering across the station/asteroid while choking someone
