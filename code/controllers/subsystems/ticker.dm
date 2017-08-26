// Should be merged with the gameticker *eventually* for sanity's sake.

/var/datum/controller/subsystem/ticker/SSticker

/datum/controller/subsystem/ticker
	name = "Ticker"
	wait = 2 SECONDS
	init_order = SS_INIT_LOBBY
	flags = SS_NO_TICK_CHECK | SS_FIRE_IN_LOBBY

/datum/controller/subsystem/ticker/New()
	NEW_SS_GLOBAL(SSticker)

/datum/controller/subsystem/ticker/Initialize()
	set waitfor = 0
	if (!ticker)
		ticker = new

	..()

	ticker.pregame()

/datum/controller/subsystem/ticker/fire()
	ticker.process()
