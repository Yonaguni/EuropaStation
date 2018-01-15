var/datum/antagonist/godtouched/godtouched

/datum/antagonist/godtouched
	id = MODE_GODTOUCHED
	role_text = "Godtouched"
	role_text_plural = "Godtouched"
	welcome_text = "Your mind is no longer wholly your own; something from outside the Real has twined itself \
		through your being, and you are a True Believer, now. Serve and exalt your otherworldy master."
	initial_spawn_req = 1 // Make this 3 before merge.
	initial_spawn_target = 10

/datum/antagonist/godtouched/New(var/no_reference)
	..()
	if(!no_reference)
		godtouched = src

/datum/antagonist/godtouched/add_antagonist(var/datum/mind/player, var/ignore_role, var/do_not_equip, var/move_to_spawn, var/do_not_announce, var/preserve_appearance, var/mob/living/presence/enthralled_by)
	if(!istype(enthralled_by))
		enthralled_by = presences.get_next_presence_for_unaligned_godtouched()
	if(!istype(enthralled_by))
		return FALSE
	. = ..()
	if(.) enthralled_by.welcome_believer(player.current)

/datum/antagonist/godtouched/is_antagonist(var/datum/mind/player, var/mob/living/presence/controller)
	. = ..()
	if(. && istype(controller))
		. = controller.believers[player.current]
