var/datum/controller/subsystem/chemistry/SSchemistry

/datum/controller/subsystem/chemistry
	name = "Chemistry"
	priority = SS_PRIORITY_CHEMISTRY
	init_order = SS_INIT_CHEMISTRY

	var/list/_active_holders
	var/list/_chemical_reactions
	var/list/_chemical_reactions_by_id
	var/list/_chemical_reactions_by_result
	var/list/_chemical_reagents
	var/list/_chemical_reagents_by_id

	var/tmp/list/_processing_holders = list()

/datum/controller/subsystem/chemistry/stat_entry()
	..("AH:[_active_holders.len]")

/datum/controller/subsystem/chemistry/New()
	NEW_SS_GLOBAL(SSchemistry)

/datum/controller/subsystem/chemistry/Initialize()

	_active_holders = list()

	// Init reagent list.
	_chemical_reagents = list()
	_chemical_reagents_by_id = list()
	for(var/path in subtypesof(/datum/reagent))
		var/datum/reagent/D = new path
		_chemical_reagents += D
		_chemical_reagents_by_id[path] = D

	// Init reaction list.
	//Chemical Reactions - Initialises all /datum/chemical_reaction into a list
	// It is filtered into multiple lists within a list.
	// For example:
	// chemical_reaction_list["phoron"] is a list of all reactions relating to phoron
	// Note that entries in the list are NOT duplicated. So if a reaction pertains to
	// more than one chemical it will still only appear in only one of the sublists.
	_chemical_reactions = list()
	_chemical_reactions_by_id = list()
	_chemical_reactions_by_result = list()
	for(var/path in subtypesof(/datum/chemical_reaction))
		var/datum/chemical_reaction/D = new path()
		_chemical_reactions += D
		if(!_chemical_reactions_by_result[D.result])
			_chemical_reactions_by_result[D.result] = list()
		_chemical_reactions_by_result[D.result] += D
		if(D.required_reagents && D.required_reagents.len)
			var/reagent_id = D.required_reagents[1]
			if(!_chemical_reactions_by_id[reagent_id])
				_chemical_reactions_by_id[reagent_id] = list()
			_chemical_reactions_by_id[reagent_id] += D

	. = ..()

/datum/controller/subsystem/chemistry/fire(resumed = FALSE)
	if (!resumed)
		_processing_holders = _active_holders.Copy()

	while(_processing_holders.len)
		var/datum/reagents/holder = _processing_holders[_processing_holders.len]
		_processing_holders.len--

		if (QDELETED(holder))
			_active_holders -= holder
			log_debug("SSchemistry: QDELETED holder found in processing list!")
			if(MC_TICK_CHECK)
				return
			continue

		if (!holder.process_reactions())
			_active_holders -= holder

		if (MC_TICK_CHECK)
			return

/datum/controller/subsystem/chemistry/proc/mark_for_update(var/datum/reagents/holder)
	if (holder in _active_holders)
		return

	//Process once, right away. If we still need to continue then add to the active_holders list and continue later
	if (holder.process_reactions())
		_active_holders += holder

/datum/controller/subsystem/chemistry/Recover()
	src._active_holders =               SSchemistry._active_holders
	src._chemical_reactions =           SSchemistry._chemical_reactions
	src._chemical_reactions_by_id =     SSchemistry._chemical_reactions_by_id
	src._chemical_reactions_by_result = SSchemistry._chemical_reactions_by_result
	src._chemical_reagents =            SSchemistry._chemical_reagents
	src._chemical_reagents_by_id =      SSchemistry._chemical_reagents_by_id

/datum/controller/subsystem/chemistry/proc/get_reaction(var/id)
	return _chemical_reactions_by_id ? _chemical_reactions_by_id[id] : null

/datum/controller/subsystem/chemistry/proc/get_reagent(var/id)
	return _chemical_reagents_by_id ? _chemical_reagents_by_id[id] : null

/datum/controller/subsystem/chemistry/proc/get_reactions_by_result(var/id)
	return _chemical_reactions_by_result ? _chemical_reactions_by_result[id] : null
