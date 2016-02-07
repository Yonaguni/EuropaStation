var/datum/controller/process/chemistry/chemistryProcess

/datum/controller/process/chemistry
	var/list/active_holders
	var/list/chemical_reactions_list
	var/list/chemical_reagents_list

/datum/controller/process/chemistry/setup()
	name = "chemistry"
	schedule_interval = 10 // every 1 second
	chemistryProcess = src
	active_holders = list()

	// Initialises all /datum/reagent into a list indexed by reagent id
	chemical_reagents_list = list()
	for(var/path in (typesof(/datum/reagent) - /datum/reagent))
		var/datum/reagent/D = new path()
		if(!D.name)
			continue
		chemical_reagents_list[D.id] = D

	chemical_reactions_list = list()
	for(var/path in (typesof(/datum/chemical_reaction) - /datum/chemical_reaction))
		var/datum/chemical_reaction/D = new path()
		if(D.required_reagents && D.required_reagents.len)
			var/reagent_id = D.required_reagents[1]
			if(!chemical_reactions_list[reagent_id])
				chemical_reactions_list[reagent_id] = list()
			chemical_reactions_list[reagent_id] += D

/datum/controller/process/chemistry/statProcess()
	..()
	stat(null, "[active_holders.len] reagent holder\s")

/datum/controller/process/chemistry/doWork()
	for(last_object in active_holders)
		var/datum/reagents/holder = last_object
		if(!holder.process_reactions())
			active_holders -= holder
		SCHECK

/datum/controller/process/chemistry/proc/mark_for_update(var/datum/reagents/holder)
	if(holder in active_holders)
		return
	//Process once, right away. If we still need to continue then add to the active_holders list and continue later
	if(holder.process_reactions())
		active_holders += holder
