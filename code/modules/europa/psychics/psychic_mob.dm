/datum/mind
	var/list/psychic_faculties = list()
	var/list/psychic_powers = list()
	var/list/maintaining_powers = list()
	var/psychic_power = 30
	var/max_psychic_power = 30

/mob/Login()
	. = ..()
	if(mind && mind.psychic_powers)
		mind.update_psychic_powers()

/datum/psychic_power_assay
	var/datum/mind/owner
	var/rank = 1
	var/decl/psychic_faculty/associated_faculty
	var/list/powers = list()

/datum/psychic_power_assay/proc/set_rank(var/newrank, var/silent)

	if(!owner)
		return

	if(rank == newrank)
		return
	var/lastrank = rank
	rank = newrank
	if(!silent)
		var/use_span = (rank > lastrank)  ? "notice" : "danger"
		owner.current << "<span class = '[use_span]'>Your understanding of [associated_faculty.name] [rank > lastrank ? "surges" : "falls"] to the level of [psychic_ranks_to_strings[rank]].</span>"

	owner.psychic_powers -= powers
	if(rank > lastrank)
		for(var/i = lastrank+1 to rank)
			var/ptype = associated_faculty.powers[i]
			powers += new ptype(owner, associated_faculty, i)
	else
		for(var/i = rank+1 to lastrank)
			qdel(powers[i])
			powers -= powers[i]
	owner.psychic_powers |= powers
	owner.update_psychic_powers(silent)

/datum/psychic_power_assay/New(var/datum/mind/_owner, var/decl/psychic_faculty/_associated_faculty)
	. = ..()
	associated_faculty = _associated_faculty
	owner = _owner

/datum/mind/proc/check_psychic_faculty(var/faculty = PSYCHIC_CREATIVITY, var/min_rank = 1, var/opposing_rank, var/opposing_school = PSYCHIC_CREATIVITY)
	if(!(faculty in psychic_faculties) || psychic_power <= 0)
		return 0
	var/prank = get_psychic_faculty_rank(faculty)
	if(opposing_rank && prank <= opposing_rank)
		return 0
	return (prank >= min_rank)

/datum/mind/proc/get_psychic_faculty_rank(var/faculty = PSYCHIC_CREATIVITY)
	if(!(faculty in psychic_faculties) || psychic_power <= 0)
		return 0
	var/datum/psychic_power_assay/power = psychic_faculties[faculty]
	return power.rank

/datum/mind/proc/spend_psychic_power(var/amount, var/datum/psychic_power/power)
	if(psychic_power <= 0)
		power.cancelled(src)
		current.backblast(amount)
		return 0
	psychic_power -= amount
	if(psychic_power <= 0)
		current.backblast(amount)
	return 1

/mob/proc/backblast(var/amount)
	return

/mob/living/backblast(var/amount)
	src << 'sound/effects/psi/power_feedback.ogg'
	src << "<span class='danger'><font size=3>Wild energistic feedback blasts across your psyche!</font></span>"
	if(prob(60))
		emote("scream")
	if(amount)
		adjustBrainLoss(amount)
	for(var/datum/maintained_power/power in mind.maintaining_powers)
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

/datum/mind/proc/update_psychic_powers(var/silent)

	if(!current || !current.client)
		return

	if(current.client.psi_toggle)
		current.client.screen -= current.client.psi_toggle
	if(current.client.psi_hud && current.client.psi_hud.len)
		current.client.screen -= current.client.psi_hud
	current.client.psi_hud.Cut()

	if(psychic_powers && psychic_powers.len)
		for(var/datum/psychic_power/power in psychic_powers)
			if(!current.client.psychic_hud_elements["\ref[power]"])
				current.client.psychic_hud_elements["\ref[power]"] = new /obj/screen/psi/power(power)
		for(var/psiref in current.client.psychic_hud_elements)
			var/datum/psychic_power/power = locate(psiref)
			if(!power || !(power in psychic_powers))
				current.client.psychic_hud_elements[psiref] = null
				current.client.psychic_hud_elements -= psiref
				qdel(power)
			else
				current.client.psi_hud += current.client.psychic_hud_elements[psiref]

		if(!current.client.hide_psi_powers)
			current.client.screen += current.client.psi_hud
		if(!current.client.psi_toggle)
			current.client.psi_toggle = new()
		current.client.screen |= current.client.psi_toggle
		current.client.psi_toggle.update_state(current)
		spawn(1)
			current.client.psi_toggle.update_state(current)

/mob/living/Stat()
	. = ..()
	if(. && statpanel("Status") && mind && mind.psychic_faculties && mind.psychic_faculties.len)
		stat("Psipower", "[max(0,mind.psychic_power)]/[mind.max_psychic_power]")

/mob/living/Life()
	. = ..()
	if(stat != DEAD && mind)
		if(stat == UNCONSCIOUS)
			if(mind.maintaining_powers.len)
				backblast(mind.maintaining_powers.len)
		else
			var/turf/T = get_turf(src)
			if(T && T.is_psi_null())
				if(mind.maintaining_powers.len)
					backblast(mind.maintaining_powers.len)
				if(mind.psychic_power)
					mind.psychic_power = max(0, mind.psychic_power - rand(1,3))
					src << "<span class='warning'>You feel your psi-power leeched away by \the [T]...</span>"
				return
			if(mind.psychic_power < mind.max_psychic_power)
				mind.psychic_power = min(mind.max_psychic_power, mind.psychic_power + rand(1,3))
			for(var/datum/maintained_power/mpower in mind.maintaining_powers)
				if(mind.spend_psychic_power(mpower.power.passive_cost, mpower.power) && mpower && !deleted(mpower))
					mpower.power.tick(mpower.owner)
