#define PROCESS_REACTION_ITER 5 //when processing a reaction, iterate this many times

/datum/reagents
	var/total_volume = 0
	var/maximum_volume = 100
	var/atom/my_atom = null
	var/list/doses =   list()
	var/list/volumes = list()
	var/last_message_tick = 0

/datum/reagents/New(var/max = 100, atom/A = null)
	..()
	maximum_volume = max
	my_atom = A

/datum/reagents/Destroy()
	. = ..()
	if(SSchemistry._active_holders)
		SSchemistry._active_holders -= src
	if(my_atom && my_atom.reagents == src)
		my_atom.reagents = null

/* Internal procs */

/datum/reagents/proc/get_free_space() // Returns free space.
	return maximum_volume - total_volume

/datum/reagents/proc/get_master_reagent() // Returns reference to the reagent with the biggest volume.
	var/the_id = null
	var/the_volume = 0
	for(var/rid in volumes)
		var/volume = volumes[rid]
		if(volume > the_volume)
			the_volume = volume
			the_id = rid
	return the_id

/datum/reagents/proc/get_master_reagent_name() // Returns the name of the reagent with the biggest volume.
	var/datum/reagent/R = SSchemistry.get_reagent(get_master_reagent())
	return istype(R) ? R.name : null

/datum/reagents/proc/update_total() // Updates volume.
	total_volume = 0
	for(var/rid in volumes)
		var/amt = volumes[rid]
		if(amt < MINIMUM_CHEMICAL_VOLUME)
			del_reagent(rid)
		else
			total_volume += volumes[rid]
	return

/datum/reagents/proc/delete()
	if(my_atom)
		my_atom.reagents = null

/datum/reagents/proc/handle_reactions()
	SSchemistry.mark_for_update(src)

//returns 1 if the holder should continue reactiong, 0 otherwise.
/datum/reagents/proc/process_reactions()
	if(!my_atom) // No reactions in temporary holders
		return 0
	if(!my_atom.loc) //No reactions inside GC'd containers
		return 0
	if(my_atom.flags & NOREACT) // No reactions here
		return 0

	var/reaction_occured
	var/list/effect_reactions = list()
	var/list/eligible_reactions = list()
	for(var/i in 1 to PROCESS_REACTION_ITER)
		reaction_occured = 0

		//need to rebuild this to account for chain reactions
		for(var/rid in volumes)
			eligible_reactions |= SSchemistry.get_reaction(rid)

		for(var/datum/chemical_reaction/C in eligible_reactions)
			if(C.can_happen(src) && C.process(src))
				effect_reactions |= C
				reaction_occured = 1

		eligible_reactions.Cut()

		if(!reaction_occured)
			break

	for(var/datum/chemical_reaction/C in effect_reactions)
		C.post_reaction(src)

	update_total()
	return reaction_occured

/* Holder-to-chemical */

/datum/reagents/proc/add_reagent(var/id, var/amount, var/data = null, var/safety = 0)

	if(!SSchemistry.get_reagent(id))
		warning("[my_atom] attempted to add a reagent called '[id]' which doesn't exist. ([usr])")
		return 0

	if(!isnum(amount) || amount <= 0)
		return 0

	update_total()
	amount = min(amount, get_free_space())

	if(!volumes[id])
		volumes[id] = amount
	else
		volumes[id] += amount

	update_total()
	if(!safety) handle_reactions()
	if(my_atom) my_atom.on_reagent_change()
	return 1

/datum/reagents/proc/remove_reagent(var/id, var/amount, var/safety = 0)
	if(isnum(amount) && !isnull(volumes[id]))
		volumes[id] -= amount // It can go negative, but it doesn't matter
		update_total() // Because this proc will delete it then
		if(!safety) handle_reactions()
		if(my_atom) my_atom.on_reagent_change()
		return 1
	return 0

/datum/reagents/proc/del_reagent(var/id)
	if(!isnull(volumes[id]))
		volumes -= id
		update_total()
		if(my_atom) my_atom.on_reagent_change()

/datum/reagents/proc/has_reagent(var/id, var/amount = null)
	var/amt = volumes[id]
	if((isnull(amount) && amt > 0) || amt >= amount)
		return 1
	return 0

/datum/reagents/proc/has_any_reagent(var/list/check_reagents)
	for(var/rid in check_reagents)
		if(volumes[rid] >= check_reagents[rid])
			return 1
	return 0

/datum/reagents/proc/has_all_reagents(var/list/check_reagents)
	//this only works if check_reagents has no duplicate entries... hopefully okay since it expects an associative list
	var/missing = check_reagents.len
	for(var/id in check_reagents)
		if(volumes[id] >= check_reagents[id])
			missing--
	return !missing

/datum/reagents/proc/clear_reagents()
	volumes.Cut()

/datum/reagents/proc/get_reagent_amount(var/id)
	var/amt = volumes[id]
	return (!isnull(amt) ? amt : 0)

/datum/reagents/proc/get_reagent_amount_by_type(var/rtype)
	var/amt = 0
	for(var/rid in volumes)
		var/datum/reagent/current = SSchemistry.get_reagent(rid)
		if(istype(current, rtype))
			amt += volumes[rtype]
	return amt

/datum/reagents/proc/get_reagents()
	. = list()
	for(var/rid in volumes)
		var/datum/reagent/current = SSchemistry.get_reagent(rid)
		. += "[current.name] ([volumes[rid]])"
	return english_list(., "EMPTY", "", ", ", ", ")

/* Holder-to-holder and similar procs */

/datum/reagents/proc/remove_any(var/amount = 1) // Removes up to [amount] of reagents from [src]. Returns actual amount removed.
	amount = min(amount, total_volume)

	if(!amount)
		return

	var/part = amount / total_volume

	for(var/rid in volumes)
		var/amount_to_remove = volumes[rid] * part
		remove_reagent(rid, amount_to_remove, 1)

	update_total()
	handle_reactions()
	return amount

/datum/reagents/proc/trans_to_holder(var/datum/reagents/target, var/amount = 1, var/multiplier = 1, var/copy = 0) // Transfers [amount] reagents from [src] to [target], multiplying them by [multiplier]. Returns actual amount removed from [src] (not amount transferred to [target]).
	if(!target || !istype(target))
		return

	amount = max(0, min(amount, total_volume, target.get_free_space() / multiplier))

	if(!amount)
		return

	var/part = amount / total_volume

	for(var/rid in volumes)
		var/datum/reagent/current = SSchemistry.get_reagent(rid)
		var/amount_to_transfer = volumes[rid] * part
		target.add_reagent(rid, amount_to_transfer * multiplier, safety = 1) // We don't react until everything is in place
		if(!copy)
			remove_reagent(current.type, amount_to_transfer, 1)

	if(!copy)
		handle_reactions()
	target.handle_reactions()
	return amount

/* Holder-to-atom and similar procs */

//The general proc for applying reagents to things. This proc assumes the reagents are being applied externally,
//not directly injected into the contents. It first calls touch, then the appropriate trans_to_*() or splash_mob().
//If for some reason touch effects are bypassed (e.g. injecting stuff directly into a reagent container or person),
//call the appropriate trans_to_*() proc.
/datum/reagents/proc/trans_to(var/atom/target, var/amount = 1, var/multiplier = 1, var/copy = 0)
	touch(target) //First, handle mere touch effects

	if(ismob(target))
		return splash_mob(target, amount, copy)
	if(isturf(target))
		return trans_to_turf(target, amount, multiplier, copy)
	if(isobj(target) && target.is_open_container())
		return trans_to_obj(target, amount, multiplier, copy)
	return 0

//Splashing reagents is messier than trans_to, the target's loc gets some of the reagents as well.
/datum/reagents/proc/splash(var/atom/target, var/amount = 1, var/multiplier = 1, var/copy = 0, var/min_spill=0, var/max_spill=60)
	var/spill = 0
	if(!isturf(target) && target.loc)
		spill = amount*(rand(min_spill, max_spill)/100)
		amount -= spill
	if(spill)
		splash(target.loc, spill, multiplier, copy, min_spill, max_spill)

	trans_to(target, amount, multiplier, copy)

/datum/reagents/proc/trans_id_to(var/atom/target, var/id, var/amount = 1)
	if (!target || !target.reagents || !target.simulated)
		return

	amount = min(amount, get_reagent_amount(id))

	if(!amount)
		return

	var/datum/reagents/F = new /datum/reagents(amount)
	F.add_reagent(id, amount)
	remove_reagent(id, amount)

	return F.trans_to(target, amount) // Let this proc check the atom's type

// When applying reagents to an atom externally, touch() is called to trigger any on-touch effects of the reagent.
// This does not handle transferring reagents to things.
// For example, splashing someone with water will get them wet and extinguish them if they are on fire,
// even if they are wearing an impermeable suit that prevents the reagents from contacting the skin.
/datum/reagents/proc/touch(var/atom/target)
	if(ismob(target))
		touch_mob(target, src)
	if(isturf(target))
		touch_turf(target, src)
	if(isobj(target))
		touch_obj(target, src)

/datum/reagents/proc/touch_mob(var/mob/target, var/datum/reagents/holder)
	if(!target || !istype(target) || !target.simulated)
		return

	for(var/rid in volumes)
		var/datum/reagent/current = SSchemistry.get_reagent(rid)
		current.touch_mob(target, volumes[rid], holder)

	update_total()

/datum/reagents/proc/touch_turf(var/turf/target, var/datum/reagents/holder)
	if(!target || !istype(target) || !target.simulated)
		return

	for(var/rid in volumes)
		var/datum/reagent/current = SSchemistry.get_reagent(rid)
		current.touch_turf(target, volumes[rid], holder)

	update_total()

/datum/reagents/proc/touch_obj(var/obj/target, var/datum/reagents/holder)
	if(!target || !istype(target) || !target.simulated)
		return

	for(var/rid in volumes)
		var/datum/reagent/current = SSchemistry.get_reagent(rid)
		current.touch_obj(target, volumes[rid], holder)

	update_total()

// Attempts to place a reagent on the mob's skin.
// Reagents are not guaranteed to transfer to the target.
// Do not call this directly, call trans_to() instead.
/datum/reagents/proc/splash_mob(var/mob/target, var/amount = 1, var/copy = 0)
	var/perm = 1
	if(isliving(target)) //will we ever even need to tranfer reagents to non-living mobs?
		var/mob/living/L = target
		perm = L.reagent_permeability()
	return trans_to_mob(target, amount, CHEM_TOUCH, perm, copy)

/datum/reagents/proc/trans_to_mob(var/mob/target, var/amount = 1, var/type = CHEM_BLOOD, var/multiplier = 1, var/copy = 0) // Transfer after checking into which holder...
	if(!target || !istype(target) || !target.simulated)
		return
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		if(type == CHEM_BLOOD)
			var/datum/reagents/R = C.reagents
			return trans_to_holder(R, amount, multiplier, copy)
		if(type == CHEM_INGEST)
			return C.ingest(src, C.get_ingested_reagents(), amount, multiplier, copy) //perhaps this is a bit of a hack, but currently there's no common proc for eating reagents
		if(type == CHEM_TOUCH)
			var/datum/reagents/R = C.touching
			return trans_to_holder(R, amount, multiplier, copy)
	else
		var/datum/reagents/R = new /datum/reagents(amount)
		. = trans_to_holder(R, amount, multiplier, copy)
		R.touch_mob(target)

/datum/reagents/proc/trans_to_turf(var/turf/target, var/amount = 1, var/multiplier = 1, var/copy = 0) // Turfs don't have any reagents (at least, for now). Just touch it.
	if(!target || !target.simulated)
		return

	var/datum/reagents/R = new /datum/reagents(amount * multiplier)
	. = trans_to_holder(R, amount, multiplier, copy)
	R.touch_turf(target)
	return

/datum/reagents/proc/trans_to_obj(var/obj/target, var/amount = 1, var/multiplier = 1, var/copy = 0) // Objects may or may not; if they do, it's probably a beaker or something and we need to transfer properly; otherwise, just touch.
	if(!target || !target.simulated)
		return

	if(!target.reagents)
		var/datum/reagents/R = new /datum/reagents(amount * multiplier)
		. = trans_to_holder(R, amount, multiplier, copy)
		R.touch_obj(target)
		return

	return trans_to_holder(target.reagents, amount, multiplier, copy)

/* Atom reagent creation - use it all the time */

/atom/proc/create_reagents(var/max_vol)
	reagents = new/datum/reagents(max_vol, src)
