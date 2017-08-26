/datum/controller/subsystem/vote
	name = "Voting"
	wait = 1 SECOND
	flags = SS_NO_INIT | SS_NO_TICK_CHECK
	priority = SS_PRIORITY_VOTE

/datum/controller/subsystem/vote/fire()
	vote.process()
