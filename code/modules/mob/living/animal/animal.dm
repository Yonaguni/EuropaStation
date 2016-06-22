/mob/living/animal
	name = "animal"
	icon = 'icons/mob/creatures/animal.dmi'
	universal_speak = 0
	health = 20
	maxHealth = 20
	pass_flags = PASSTABLE

	mob_bump_flag = SIMPLE_ANIMAL
	mob_swap_flags = MONKEY|SLIME|SIMPLE_ANIMAL
	mob_push_flags = MONKEY|SLIME|SIMPLE_ANIMAL

	var/icon_living
	var/icon_dead
	var/icon_gib
	var/icon_asleep

	// Simple environment checks.
	var/min_pressure = 80
	var/max_pressure = 120
	var/min_temp = 260
	var/max_temp = 360
	var/min_oxygen = 16
	var/max_toxins = 5

	var/next_update_speech_mask = 0
	var/current_speech_mask
	var/list/speech_masks = list()
	var/list/speech_verbs = list()
	var/animal_move_delay = 6 // Ticks between moves.

	var/melee_damage_lower = 0
	var/melee_damage_upper = 0

	var/attacktext = "attacked"
	var/attack_sound = null
	var/environment_smash

	var/friendly_interaction = "nuzzles"
	var/help_interaction_text = "pets"
	var/harm_interaction_text = "kicks"
	var/disarm_interaction_text = "pokes"

	var/mob_ai_type
	var/datum/ai_mob/mob_ai

	var/alert_offset = 14

/mob/living/animal/initialize()
	..()
	if(mob_ai_type)
		if(mob_ai)
			qdel(mob_ai)
		mob_ai = new mob_ai_type(src)
		if(mob_ai.speak && mob_ai.speak.len)
			speech_masks = mob_ai.speak.Copy()
	health = maxHealth
	update_icon()

/mob/living/animal/regenerate_icons()
	..()
	update_icon()

/mob/living/animal/Login()
	if(src && src.client)
		src.client.screen = null
	..()

/mob/living/animal/Life()
	. = ..()
	if(stat != DEAD && health <= 0)
		death()

/mob/living/animal/update_icon()

	overlays.Cut()

	if(mob_ai)
		if(mob_ai.panicked > 0)
			var/image/I = image('icons/mob/creatures/animal.dmi', "panic")
			I.pixel_y = alert_offset
			overlays += I
		else if(mob_ai.enraged > 0)
			var/image/I = image('icons/mob/creatures/animal.dmi', "rage")
			I.pixel_y = alert_offset
			overlays += I

	if(stat == DEAD && icon_dead)
		icon_state = icon_dead
		return

	if(stat == UNCONSCIOUS && icon_asleep)
		icon_state = icon_asleep
		return

	if(icon_living)
		icon_state = icon_living
		return

	icon_state = initial(icon_state)

/mob/living/animal/bullet_act(var/obj/item/projectile/proj)
	. = ..()
	if(mob_ai && !client) mob_ai.receive_hostile_interaction(proj.firer ? proj.firer : get_turf(src))

/mob/living/animal/movement_delay()
	return animal_move_delay+config.animal_delay

/mob/living/animal/Stat()
	..()
	if(statpanel("Status"))
		stat(null, "Health: [round((health / maxHealth) * 100)]%")

/mob/living/animal/ex_act(severity)
	if(severity == 1)
		gib()
	else
		if(!blinded)
			flash_eyes()
		adjustBruteLoss(severity == 2 ? 60 : 30)
		if(mob_ai && !client) mob_ai.receive_hostile_interaction(get_turf(src))

/mob/living/animal/put_in_hands(var/obj/item/W) // No hands.
	W.forceMove(get_turf(src))
	return 1

/mob/living/animal/handle_fire()
	. = ..()
	return

/mob/living/animal/update_fire()
	. = ..()
	return

/mob/living/animal/IgniteMob()
	. = ..()
	return

/mob/living/animal/ExtinguishMob()
	. = ..()
	return
