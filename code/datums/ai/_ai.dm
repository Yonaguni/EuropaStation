#define MOB_AI_GENERIC "generic"
#define MOB_AI_HERD "herd"

/*
 *  This system is used for general-purpose mob behavior and is tied to a process in the
 *  scheduler. /mob/living/animal is the only class that currently uses the datum system.
 *  The mob_ai_type variable defines what type is used if the mob has no client and the
 *  datum itself takes triggers/events from the various mob procs and reacts accordingly.
 */