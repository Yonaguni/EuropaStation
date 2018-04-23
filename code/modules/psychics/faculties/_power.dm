/decl/psipower
	var/name             // Name. If null, psipower won't be generated on roundstart.
	var/faculty          // Associated psi faculty.
	var/min_rank         // Minimum psi rank to use this power.
	var/cost             // Base psi stamina cost for using this power.
	var/cooldown         // Deciseconds cooldown after using this power.
	var/admin_log = TRUE // Whether or not using this power prints an admin attack log.
	var/use_ranged       // This power functions from a distance.
	var/use_melee        // This power functions at melee range.
	var/use_grab         // This power has a variant invoked via grab.
	var/use_manifest     // This power manifests an item in the user's hands.
	var/use_description  // A short description of how to use this power, shown via assay.

/decl/psipower/proc/invoke(var/mob/living/user, var/atom/target)

	if(!user.psi)
		return FALSE

	if(faculty && min_rank)
		var/user_rank = user.psi.get_rank(faculty)
		if(user_rank < min_rank)
			return FALSE

	if(cost && !user.psi.spend_power(cost))
		return FALSE

	if(cooldown)
		user.psi.set_cooldown(cooldown)

	if(user.do_psionics_check(cost, user))
		to_chat(user, "<span class='warning'>Your power strikes a barrier and is leeched away as fast as you can focus it...</span>")
		return FALSE

	if(target.do_psionics_check(cost, user))
		to_chat(user, "<span class='warning'>Your power skates across \the [target], but cannot get a grip...</span>")
		return FALSE

	if(admin_log && ismob(user) && ismob(target))
		admin_attack_log(user, target, "Used psipower ([name])", "Was subjected to a psipower ([name])", "used a psipower ([name]) on")
	return TRUE
