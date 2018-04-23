#define GRAFFITI_AGE_DECAY 10
#define GRAFFITI_AGE_MAX 50
#define GRAFFITI_AGE_SCRAMBLE_WEIGHT 0.5
#define GRAFFITI_FILE "data/persistent/[lowertext(using_map.name)]-graffiti.txt"

var/datum/controller/subsystem/persistence/SSpersistence

/datum/controller/subsystem/persistence
	name = "Persistence"
	init_order = SS_INIT_PERSISTENCE
	flags = SS_NO_FIRE
	var/list/graffiti

/datum/controller/subsystem/persistence/New()
	NEW_SS_GLOBAL(SSpersistence)

/datum/controller/subsystem/persistence/Initialize()

	if(!fexists(GRAFFITI_FILE))
		return

	for(var/graffiti_line in file2list(GRAFFITI_FILE, "\n"))

		if(!graffiti_line)
			continue

		// Break the line up.
		var/list/graffiti_tokens = splittext(graffiti_line, "\t")
		if(graffiti_tokens.len < 6)
			continue

		var/_x =       text2num(graffiti_tokens[1])
		var/_y =       text2num(graffiti_tokens[2])
		var/_z =       text2num(graffiti_tokens[3])
		var/_n =       text2num(graffiti_tokens[4])
		var/_author =  graffiti_tokens[5]
		var/_message = graffiti_tokens[6]

		// Sanity checks.
		if(isnull(_n) || isnull(_x) || isnull(_y) || isnull(_z))
			continue

		// Too old, get outta here.
		if(_n > GRAFFITI_AGE_MAX)
			continue

		// If it's old enough we start to trim it down and scramble parts.
		if(_n >= GRAFFITI_AGE_DECAY)
			var/decayed_message = ""
			for(var/i = 1 to length(_message))
				var/char = copytext(_message, i, i + 1)
				if(prob(round(_n * GRAFFITI_AGE_SCRAMBLE_WEIGHT)))
					if(prob(99))
						decayed_message += pick(".",",","-","'","\\","/","\"",":",";")
				else
					decayed_message += char
			_message = decayed_message

		// If it has decayed to nothing we ditch it and move on.
		if(!length(_message))
			continue

		// Message is valid, find a valid turf for it.
		var/turf/T = locate(_x, _y, _z)
		if(!istype(T) || !T.can_engrave())
			continue

		// Is the turf full of other crap?
		var/too_much_graffiti = 0
		for(var/obj/effect/decal/writing/W in T)
			too_much_graffiti++
		if(too_much_graffiti >= 5)
			continue

		// Finalize the decal.
		var/obj/effect/decal/writing/new_graffiti = new(T)
		new_graffiti.message = _message
		new_graffiti.graffiti_age = _n+1
		new_graffiti.author = _author

/datum/controller/subsystem/persistence/Shutdown()
	// Goodnight sweet prince.
	// Please for the love of god don't point this at a directory.
	if(fexists(GRAFFITI_FILE)) fdel(GRAFFITI_FILE)
	var/graffiti_file = file(GRAFFITI_FILE)
	for(var/thing in graffiti)
		var/obj/effect/decal/writing/save_graffiti = thing
		if(save_graffiti.graffiti_age >= GRAFFITI_AGE_MAX)
			continue
		var/turf/T = save_graffiti.loc
		if(!istype(T) || !T.can_engrave())
			continue
		graffiti_file << "[save_graffiti.x]\t[save_graffiti.y]\t[save_graffiti.z]\t[save_graffiti.graffiti_age]\t[save_graffiti.author ? save_graffiti.author : "unknown"]\t[save_graffiti.message]"

#undef GRAFFITI_AGE_DECAY
#undef GRAFFITI_AGE_MAX
#undef GRAFFITI_AGE_SCRAMBLE_WEIGHT
