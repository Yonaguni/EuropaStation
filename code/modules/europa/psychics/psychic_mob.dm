/mob/living/var/next_psy = 0
/mob/living/var/list/psychic_faculties = list()
/mob/living/var/list/maintaining_powers = list()
/mob/living/var/psychic_power = 30
/mob/living/var/max_psychic_power = 30

/datum/psychic_power_assay
	var/mob/living/owner
	var/rank = 1
	var/decl/psychic_faculty/associated_faculty

/datum/psychic_power_assay/proc/set_rank(var/newrank, var/silent)
	if(rank == newrank)
		return
	var/lastrank = rank
	rank = newrank
	if(!silent)
		var/use_span = (rank > lastrank)  ? "notice" : "danger"
		owner << "<span class = '[use_span]'>Your understanding of [associated_faculty.name] [rank > lastrank ? "surges" : "falls"] to the level of [psychic_ranks_to_strings[rank]].</span>"
	owner.update_psychic_powers(silent)

/datum/psychic_power_assay/New(var/mob/living/_owner, var/decl/psychic_faculty/_associated_faculty)
	. = ..()
	associated_faculty = _associated_faculty
	owner = _owner

/mob/living/proc/check_psychic_faculty(var/faculty = PSYCHIC_CREATIVITY, var/min_rank = 1, var/opposing_rank, var/opposing_school = PSYCHIC_CREATIVITY)
	if(!(faculty in psychic_faculties) || psychic_power <= 0)
		return 0
	var/prank = get_psychic_faculty_rank(faculty)
	if(opposing_rank && prank <= opposing_rank)
		return 0
	return (prank >= min_rank)

/mob/living/proc/get_psychic_faculty_rank(var/faculty = PSYCHIC_CREATIVITY)
	if(!(faculty in psychic_faculties) || psychic_power <= 0)
		return 0
	var/datum/psychic_power_assay/power = psychic_faculties[faculty]
	return power.rank

/mob/living/proc/spend_psychic_power(var/amount, var/decl/psychic_power/power)
	if(psychic_power <= 0)
		power.cancelled(src)
		backblast(amount)
		return 0
	psychic_power -= amount
	if(psychic_power <= 0)
		backblast(amount)
	return 1

/mob/living/proc/backblast(var/amount)
	src << 'sound/effects/psi/power_feedback.ogg'
	src << "<span class='danger'><font size=3>Wild energistic feedback blasts across your psyche!</font></span>"
	if(prob(60))
		emote("scream")
	if(amount)
		adjustBrainLoss(amount)
	for(var/datum/maintained_power/power in maintaining_powers)
		power.fail()
	for(var/obj/item/psychic_power/power_holder in contents)
		drop_from_inventory(power_holder)

/mob/living/carbon/human/backblast(var/amount)
	..()
	if(should_have_organ(BP_BRAIN))
		var/obj/item/organ/internal/brain/sponge = internal_organs_by_name[BP_BRAIN]
		if(!sponge)
			return
		if(sponge.damage >= sponge.max_damage)
			var/obj/item/organ/external/affecting = get_organ("head")
			if(affecting && !affecting.is_stump())
				affecting.droplimb(0, DROPLIMB_BLUNT)
				if(sponge)
					qdel(sponge)

/mob/living/proc/update_psychic_powers(var/silent)
	if(psychic_faculties.len)
		if(!(/mob/living/proc/evoke_psychic_power in verbs))
			verbs += /mob/living/proc/evoke_psychic_power
			if(!silent)
				src << "<span class='notice'>You feel your mind's eye open...</span>"
				usr << 'sound/effects/psi/power_unlock.ogg'
	else
		if(/mob/living/proc/evoke_psychic_power in verbs)
			verbs -= /mob/living/proc/evoke_psychic_power
			if(!silent)
				src << "<span class='danger'>Your mind's eye slams shut!</span>"
				usr << 'sound/effects/psi/power_unlock.ogg'

/mob/living/proc/evoke_psychic_power()
	set name = "Evoke Power"
	set desc = "Evoke a metaspychic power."
	set category = "Abilities"

	/* TODO BETTER INTERFACE */
	var/list/usable_powers = list()
	for(var/faculty in psychic_faculties)
		var/datum/psychic_power_assay/power_assay = psychic_faculties[faculty]
		for(var/i=1 to power_assay.rank)
			var/decl/psychic_power/power = power_assay.associated_faculty.powers[i]
			if(!power.visible)
				continue
			usable_powers[power.name] = power
	var/chosen = input("Select a power to evoke.","Psychic Powers") as null|anything in usable_powers
	if(!chosen)
		return
	/* END TODO */

	var/decl/psychic_power/power = usable_powers[chosen]
	power.evoke(src)

/mob/living/Stat()
	. = ..()
	if(. && psychic_faculties && psychic_faculties.len)
		statpanel("Sleights", "Power Points", "[max(0,psychic_power)]/[max_psychic_power]")
		for(var/pname in psychic_faculties)
			var/datum/psychic_power_assay/assay = psychic_faculties[pname]
			statpanel("Sleights", "[capitalize(assay.associated_faculty.name)]", "[capitalize(psychic_ranks_to_strings[assay.rank])]")

/mob/living/Life()
	. = ..()
	if(stat != DEAD)
		if(stat == UNCONSCIOUS)
			if(maintaining_powers.len)
				backblast(maintaining_powers.len)
		else
			var/turf/T = get_turf(src)
			if(T && T.is_psi_null())
				if(maintaining_powers.len)
					backblast(maintaining_powers.len)
				if(psychic_power)
					psychic_power = max(0, psychic_power - rand(1,3))
					src << "<span class='warning'>You feel your psi-power leeched away by \the [T]...</span>"
				return
			if(psychic_power < max_psychic_power)
				psychic_power = min(max_psychic_power, psychic_power + rand(1,3))
			for(var/datum/maintained_power/mpower in maintaining_powers)
				if(spend_psychic_power(mpower.power.passive_cost, mpower.power))
					mpower.power.tick(mpower.owner)
