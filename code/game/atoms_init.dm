/atom
	var/initialized = FALSE
	var/update_icon_on_init	// Default to 'no'.

/atom/New(loc, ...)
	// For the DMM Suite.
	if(_preloader && (type == _preloader.target_path))//in case the instanciated atom is creating other atoms in New()
		_preloader.load(src)

	//. = ..() //uncomment if you are dumb enough to add a /datum/New() proc

	var/do_initialize = SSatoms.initialized
	if(do_initialize > INITIALIZATION_INSSATOMS)
		args[1] = do_initialize == INITIALIZATION_INNEW_MAPLOAD
		if(SSatoms.InitAtom(src, args))
			//we were deleted
			return
	
	var/list/created = SSatoms.created_atoms
	if(created)
		created += src

/atom/proc/Initialize(mapload, ...)
	if(initialized)
		crash_with("Warning: [src]([type]) initialized multiple times!")
	initialized = TRUE

	if (update_icon_on_init)
		queue_icon_update()

	return INITIALIZE_HINT_NORMAL

//called if Initialize returns INITIALIZE_HINT_LATELOAD
//This version shouldn't be called
/atom/proc/LateInitialize()
	var/static/list/warned_types = list()
	if(!warned_types[type])
		WARNING("Old style LateInitialize behaviour detected in [type]!")
		warned_types[type] = TRUE
	Initialize(FALSE)

/atom/Destroy(force = FALSE)
	if (reagents)
		QDEL_NULL(reagents)

	if (light_obj)
		QDEL_NULL(light_obj)

	if (opacity)
		updateVisibility(src)

	LAZYCLEARLIST(our_overlays)
	LAZYCLEARLIST(priority_overlays)

	return ..()
