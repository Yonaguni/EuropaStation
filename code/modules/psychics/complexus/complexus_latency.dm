/datum/psi_complexus/proc/check_latency_trigger(var/trigger_strength = 0, var/source, var/redactive = FALSE)

	set waitfor = 0

	if(!LAZYLEN(latencies) || world.time < next_latency_trigger)
		return FALSE

	if(!prob(trigger_strength))
		next_latency_trigger = world.time + rand(100, 300)
		return FALSE

	var/faculty = pick(latencies)
	var/new_rank = rand(2,5)
	owner.set_psi_rank(faculty, new_rank)
	to_chat(owner, "<span class='danger'>You scream internally as your [psychic_ids_to_strings[faculty]] faculty is forced into operancy by [source]!</span>")
	next_latency_trigger = world.time + rand(600, 1800) * new_rank
	if(!redactive) owner.adjustBrainLoss(rand(trigger_strength * 2, trigger_strength * 4))
	return TRUE
